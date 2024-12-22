import 'package:fh_assignment/core/common_widgets/common_widget.dart';
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
        if (state.status == BeneficiaryStatus.loading) {
          return ShimmerLoadingTile();
        }
        return ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => BeneficiaryTile(
            isSelected: index == 0,
            beneficiary: state.beneficiaries![index],
          ),
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey,
          ),
          itemCount: state.beneficiaries?.length ?? 0,
          shrinkWrap: true,
        );
      },
      listener: (context, state) {},
    );
  }
}
