import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/features/top-up/presentation/ui/widgets/amount_tile.dart';
import 'package:flutter/material.dart';

import 'widgets/widget.dart';

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Top Up',
          style: AppTypography.lightTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              'Recharge',
              style: AppTypography.lightTheme.headlineMedium,
            ),
            AmountTile(),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Beneficiaries',
                    style: AppTypography.lightTheme.headlineMedium,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all(
                        CircleBorder(),
                      ),
                      backgroundColor: WidgetStateProperty.all(
                        CustomColors.primary
                      ),
                      padding: WidgetStateProperty.all(EdgeInsets.all(02)),

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
              itemBuilder: (context, index) => BeneficiaryTile(
                isSelected: index == 0,
              ),
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey,
              ),
              itemCount: 5,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
