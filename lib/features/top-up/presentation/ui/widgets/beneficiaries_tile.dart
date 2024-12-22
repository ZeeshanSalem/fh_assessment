import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/constants.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/features/top-up/data/models/beneficiary.dart';
import 'package:fh_assignment/features/top-up/presentation/cubit/beneficiary/beneficiary_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'beneficiary_tile.dart';

class BeneficiariesTile extends StatelessWidget {
  const BeneficiariesTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BeneficiaryCubit, BeneficiaryState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
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
                          onPressed: () {},
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
            ),

            ListView.separated(
              itemBuilder: (context, index) =>
                  BeneficiaryTile(
                    isSelected: index == 0,
                    beneficiary: state.beneficiaries![index],
                  ),
              separatorBuilder: (context, index) =>
                  Divider(
                    color: Colors.grey,
                  ),
              itemCount: state.beneficiaries?.length ?? 0,
              shrinkWrap: true,
            ),
          ],
        );
      },
      listener: (context, state) {},
    );
  }
}
