import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          child: Text(
            'Z',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Column(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Transfer to Alex',
                style: AppTypography.lightTheme.bodyMedium,
              ),
              Text(
                '27, May 2024 04:38 PM',
                style: AppTypography.lightTheme.bodySmall,
              ),
            ],
          ),
        ),
        Text(
          '- AED 20',
          style: AppTypography.lightTheme.headlineMedium?.copyWith(
            color: CustomColors.error,
          ),
        ),
      ],
    );
  }
}
