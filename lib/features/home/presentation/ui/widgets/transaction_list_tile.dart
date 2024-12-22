import 'package:fh_assignment/core/common_widgets/common_widget.dart';
import 'package:fh_assignment/features/home/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';

part 'transaction_tile.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
      if (state.status == TransactionStatus.loading) {
        return ShimmerLoadingTile();
      }
      int total = state.transactions?.length ?? 0;
      return ListView.separated(
        itemBuilder: (context, index) => TransactionTile(),
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
        ),
        itemCount: total > 3 ? 3 : 0,
        shrinkWrap: true,
      );
    });
  }
}