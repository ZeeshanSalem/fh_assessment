import 'package:fh_assignment/core/common_widgets/common_widget.dart';
import 'package:fh_assignment/core/utils/constants.dart';
import 'package:fh_assignment/core/utils/enums.dart';
import 'package:fh_assignment/core/utils/utils.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';
import 'package:fh_assignment/features/home/presentation/cubit/home_cubit.dart';
import 'package:fh_assignment/features/home/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:loader_overlay/loader_overlay.dart';

part 'transaction_tile.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state.status == TransactionStatus.loading) {
          return ShimmerLoadingTile();
        }

        if (state.status == TransactionStatus.failure) {
          return FailureWidget(onPressed: () {
            context.read<TransactionCubit>().getTransactions();
          });
        }

        int total = state.transactions?.length ?? 0;
        return ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 10),
          reverse: false,
          itemBuilder: (context, index) => TransactionTile(
            transaction: state.transactions![index],
          ),
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey,
          ),
          itemCount: total >= 6 ? 6 : 0,
          shrinkWrap: true,
        );
      },
      // Listener Part
      listener: (context, state) {
        if (state.status == TransactionStatus.addingTransaction) {
          context.loaderOverlay.show();
        }
        if (state.status == TransactionStatus.transactionAdded) {
          /*
          * here whenever new transaction is added. it will index 0.
          * */
          context.read<HomeCubit>().updateMyBalance(state.transactions![0]);
          _hideOverlay(context);
          _showMessage(TransactionStatus.transactionAdded, context);
        }
        if (state.status == TransactionStatus.transactionFailed) {
          _hideOverlay(context);
          _showMessage(TransactionStatus.transactionFailed, context);
        }
      },
    );
  }

  _hideOverlay(BuildContext context) {
    if (context.loaderOverlay.visible) {
      context.loaderOverlay.hide();
    }
  }

  _showMessage(TransactionStatus transactionStatus, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      customSnackBar(
        status: transactionStatus == TransactionStatus.transactionAdded
            ? SnackBarStatusEnum.success
            : SnackBarStatusEnum.failure,
        context: context,
        msg: transactionStatus == TransactionStatus.transactionAdded
            ? Constant.transactionSuccessMsg
            : Constant.transactionUnSuccessMsg,
      ),
    );
  }
}
