import 'package:fh_assignment/core/common_widgets/common_widget.dart';
import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/features/top-up/data/models/beneficiary.dart';
import 'package:fh_assignment/features/top-up/presentation/cubit/beneficiary/beneficiary_cubit.dart';
import 'package:fh_assignment/features/top-up/presentation/cubit/top_up_cubit.dart';
import 'package:fh_assignment/features/top-up/presentation/ui/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'beneficiary_tile.dart';

class BeneficiariesTile extends StatelessWidget {
  const BeneficiariesTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopUpCubit, TopUpState>(
      buildWhen: (context, topUpState) =>
          topUpState.status == TopUpStatus.optionSelection ||
          topUpState.status == TopUpStatus.optionSelected,
      builder: (context, topUpState) {
        return _buildBeneficiaryList(topUpState);
      },
    );
  }

  ///
  /// 1. List View for Beneficiaries
  ///
  BlocConsumer<BeneficiaryCubit, BeneficiaryState> _buildBeneficiaryList(
      TopUpState topUpState) {
    return BlocConsumer<BeneficiaryCubit, BeneficiaryState>(
      builder: (context, state) {
        if (state.status == BeneficiaryStatus.loading) {
          return ShimmerLoadingTile();
        }
        return ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => InkWell(
            splashColor: Colors.white,
            onTap: () {
              // toggle beneficiary selection.
              if (topUpState.selectedBeneficiary?.id ==
                  state.beneficiaries![index].id) {
                context.read<TopUpCubit>().onBeneficiarySelection(
                      null,
                    );
              } else {
                context.read<TopUpCubit>().onBeneficiarySelection(
                      state.beneficiaries![index],
                    );
              }
            },
            child: BeneficiaryTile(
              isSelected: topUpState.selectedBeneficiary?.id ==
                  state.beneficiaries![index].id,
              beneficiary: state.beneficiaries![index],
            ),
          ),
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey,
          ),
          itemCount: state.beneficiaries?.length ?? 0,
          shrinkWrap: true,
        );
      },
      listener: (context, state) {
        // if curd operation failed here we show a message in snack bar.
        if (state.status == BeneficiaryStatus.crudFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              status: SnackBarStatusEnum.failure,
              context: context,
              msg: '${state.errorModel?.message}',
            ),
          );
        }
      },
    );
  }
}
