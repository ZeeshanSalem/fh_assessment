import 'package:fh_assignment/core/utils/typography.dart';
import 'package:flutter/material.dart';

class BeneficiaryTile extends StatelessWidget {
  const BeneficiaryTile({
    super.key,
    this.isSelected = false,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: CircleAvatar(
              child: Text('Z'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 02,
            children: [
              Text(
                'Zeeshan Saleem',
                style: AppTypography.lightTheme.bodyMedium,
              ),
              Text(
                '+971-524691686',
                style: AppTypography.lightTheme.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
