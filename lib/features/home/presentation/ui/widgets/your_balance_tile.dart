import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:flutter/material.dart';

///
/// Balance Tile contain total amount and currency with top-up action button.
///
class YourBalanceTile extends StatelessWidget {
  const YourBalanceTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.lightPurple,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                  text: 'Your Balance\n',
                  style: AppTypography.lightTheme.bodySmall?.copyWith(color: Colors.white),
                  children: [
                    TextSpan(
                      text: 'AED 3000',
                      style: AppTypography.lightTheme.headlineLarge?.copyWith(color: Colors.white),
                    ),
                  ]),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
