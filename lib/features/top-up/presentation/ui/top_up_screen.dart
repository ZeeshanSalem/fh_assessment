import 'package:fh_assignment/core/common_widgets/common_widget.dart';
import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/constants.dart';
import 'package:fh_assignment/core/utils/enums.dart';
import 'package:fh_assignment/core/utils/transaction_validator.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';
import 'package:fh_assignment/features/home/data/model/user.dart';
import 'package:fh_assignment/features/home/presentation/cubit/home_cubit.dart';
import 'package:fh_assignment/features/home/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:fh_assignment/features/top-up/presentation/cubit/beneficiary/beneficiary_cubit.dart';
import 'package:fh_assignment/features/top-up/presentation/cubit/top_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'widgets/widget.dart';
import 'dart:io' show Platform;

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: LoaderOverlay(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.pop(context.read<TopUpCubit>().state.isNewTopUpAdded);

              },
              icon:
                  Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
            ),
            centerTitle: true,
            title: Text(
              'Top Up',
              style: AppTypography.lightTheme.titleLarge,
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10,
              children: [
                Text(
                  'Recharge',
                  style: AppTypography.lightTheme.headlineMedium,
                ),
                AmountTile(),
                BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
                    builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Beneficiaries',
                          style: AppTypography.lightTheme.headlineMedium,
                        ),

                        // @Dev : if beneficiaries greater than total user will be able to add beneficiary.
                        ((state.beneficiaries ?? []).length) >=
                                Constant.maxAllowBeneficiaries
                            ? const SizedBox()
                            : ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (dialogContext) =>
                                        BlocProvider.value(
                                      value: context.read<BeneficiaryCubit>(),
                                      child: AddBeneficiaryDialog(),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  shape: WidgetStateProperty.all(
                                    CircleBorder(),
                                  ),
                                  backgroundColor: WidgetStateProperty.all(
                                      CustomColors.primary),
                                  padding:
                                      WidgetStateProperty.all(EdgeInsets.all(02)),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                      ],
                    ),
                  );
                }),
                BeneficiariesTile(),

                /*
                * @Dev
                * Here will perform few checks
                *
                */
                BlocConsumer<TopUpCubit, TopUpState>(
                  listener: (context, state) {
                    //1. First need to update over balance.

                    if (state.status == TopUpStatus.success) {
                      context
                          .read<HomeCubit>()
                          .updateMyBalance(state.latestTransaction);
                      context
                          .read<TransactionCubit>()
                          .addTransactionFromTopUp(state.latestTransaction);

                      _hideOverlay(context);
                      _showMessage(TopUpStatus.success, context);
                    }

                    if (state.status == TopUpStatus.failure) {
                      _hideOverlay(context);
                      _showMessage(TopUpStatus.failure, context);
                    }
                  },
                  builder: (context, state) {
                    if (state.topUpAmount == null ||
                        state.selectedBeneficiary == null) {
                      return const SizedBox();
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                            onPressed: () {
                              context.loaderOverlay.show();
                              Transaction newTransaction = Transaction(
                                createdAt: DateTime.now().toIso8601String(),
                                beneficiary:
                                    '${state.selectedBeneficiary?.nickName}',
                                type: TransactionType.debt,
                                accountNumber: '${state.selectedBeneficiary?.id}',
                                amount: '${state.topUpAmount}',
                                currency: Constant.currency,
                              );

                              User? user = context.read<HomeCubit>().state.user;
                              final transactionCubit =
                                  context.read<TransactionCubit>();

                              TransactionValidationResult result =
                                  transactionCubit.validateTransaction(
                                      newTransaction,
                                      user?.accountStatus ?? false,
                                      user?.totalBalance ?? 0);

                              if (result.isValid) {
                                context
                                    .read<TopUpCubit>()
                                    .onTopUp(newTransaction);
                              } else {
                                context.loaderOverlay.hide();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  customSnackBar(
                                    status: SnackBarStatusEnum.failure,
                                    context: context,
                                    msg: result.errorMessage ??
                                        Constant.transactionUnSuccessMsg,
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Pay',
                              style:
                                  AppTypography.lightTheme.titleMedium?.copyWith(
                                color: Colors.white,
                              ),
                            )),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _hideOverlay(BuildContext context) {
    if (context.loaderOverlay.visible) {
      context.loaderOverlay.hide();
    }
  }

  _showMessage(TopUpStatus topStatus, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(
        status: topStatus == TopUpStatus.success
            ? SnackBarStatusEnum.success
            : SnackBarStatusEnum.failure,
        context: context,
        msg: topStatus == TopUpStatus.success
            ? Constant.transactionSuccessMsg
            : Constant.transactionUnSuccessMsg,
      ),
    );
  }
}
