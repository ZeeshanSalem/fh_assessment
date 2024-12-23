import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/constants.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/features/top-up/presentation/cubit/top_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AmountTile extends StatelessWidget {
  const AmountTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopUpCubit, TopUpState>(
      buildWhen: (context, state) =>
          state.status == TopUpStatus.optionSelection ||
          state.status == TopUpStatus.optionSelected,
      builder: (context, state) {
        return Wrap(
          spacing: 5,
          children: List.generate(
            Constant.rechargeableAmounts.length,
            (index) => ChoiceChip(
              selectedColor: CustomColors.primary,
              checkmarkColor: Colors.white,
              disabledColor: Colors.grey,
              labelStyle: AppTypography.lightTheme.bodyMedium?.copyWith(
                color: state.selectedAmount ==
                    Constant.rechargeableAmounts[index]
                    ? Colors.white
                    : Colors.black,
              ),
              label: Text('${Constant.currency} ${Constant.rechargeableAmounts[index]}'),
              selected:
                  state.selectedAmount == Constant.rechargeableAmounts[index],
              onSelected: (value) {
                if (value) {
                  context.read<TopUpCubit>()
                      .onAmountSelection(Constant.rechargeableAmounts[index]);
                } else {
                  context.read<TopUpCubit>().onAmountSelection(null);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
