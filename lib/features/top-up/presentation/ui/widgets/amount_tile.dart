import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/features/top-up/presentation/cubit/top_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmountTile extends StatelessWidget {
  const AmountTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopUpCubit, TopUpState>(
      builder: (context, state) {
        final topUpCubit = context.read<TopUpCubit>();
        return Wrap(
          spacing: 5,
          children: List.generate(
            topUpCubit.rechargeableAmounts.length,
            (index) => ChoiceChip(
              selectedColor: CustomColors.primary,
              checkmarkColor: Colors.white,
              disabledColor: Colors.grey,
              labelStyle: AppTypography.lightTheme.bodyMedium?.copyWith(
                color: state.selectedAmount ==
                        topUpCubit.rechargeableAmounts[index]
                    ? Colors.white
                    : Colors.black,
              ),
              label: Text(topUpCubit.rechargeableAmounts[index]),
              selected:
                  state.selectedAmount == topUpCubit.rechargeableAmounts[index],
              onSelected: (value) {
                if (value) {
                  topUpCubit.selectAmountForRecharge(
                      topUpCubit.rechargeableAmounts[index]);
                } else {
                  topUpCubit.selectAmountForRecharge(null);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
