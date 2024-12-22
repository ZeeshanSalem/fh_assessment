import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/constants.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/features/top-up/presentation/cubit/beneficiary/beneficiary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/widget.dart';

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Top Up',
          style: AppTypography.lightTheme.titleLarge,
        ),
      ),
      body: Padding(
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
                    ((state.beneficiaries ?? []).length) >
                            Constant.maxAllowBeneficiaries
                        ? const SizedBox()
                        : ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AddBeneficiaryDialog(
                                  onAddBeneficiary: (phoneNumber, nickname) {
                                    // Handle the added beneficiary
                                    print("Phone Number: $phoneNumber");
                                    print("Nickname: $nickname");
                                  },
                                ),
                              );

                            },
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                CircleBorder(),
                              ),
                              backgroundColor:
                                  WidgetStateProperty.all(CustomColors.primary),
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
          ],
        ),
      ),
    );
  }
}
