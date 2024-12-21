import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/features/top-up/presentation/ui/widgets/amount_tile.dart';
import 'package:flutter/material.dart';

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
          ],
        ),
      ),
    );
  }
}
