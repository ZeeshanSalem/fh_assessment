import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/features/home/presentation/ui/widgets/widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 8,
          ),
          child: CircleAvatar(
            child: Icon(
              Icons.person,
              size: 32,
            ),
          ),
        ),
        title: RichText(
          text: TextSpan(
              text: 'Welcome back\n',
              style: AppTypography.lightTheme.titleMedium,
              children: [
                TextSpan(
                  text: 'Zeeshan Saleem',
                  style: AppTypography.lightTheme.titleLarge,
                ),
              ]),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none_outlined,
              size: 32,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            /// Total Balance  tile
            YourBalanceTile(),

            /// Feature Action Buttons.
            Text(
              'Features',
              style: AppTypography.lightTheme.titleMedium,
            ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: FeatureButton(
                    btnIcon: Icons.add,
                    btnName: 'Top Up',
                    onPress: () {},
                  ),
                ),
                Expanded(
                  child: FeatureButton(
                    btnIcon: Icons.send,
                    btnName: 'Transfer',
                    onPress: () {},
                  ),
                ),
              ],
            ),

            ///  Transaction.
            Text(
              'Transaction',
              style: AppTypography.lightTheme.titleMedium,
            ),

            ListView.separated(
              itemBuilder: (context, index) => TransactionTile(),
              separatorBuilder: (context, index) => Divider(color: Colors.grey,),
              itemCount: 5,
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
