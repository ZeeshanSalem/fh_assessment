import 'package:fh_assignment/core/utils/app_colors.dart';
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
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              Text(
                '27, May 2024 04:38 PM',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Text(
          '- AED 20',
          style: TextStyle(fontSize: 16, color: CustomColors.error),
        ),
      ],
    );
  }
}
