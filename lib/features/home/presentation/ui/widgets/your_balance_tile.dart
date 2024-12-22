import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return RichText(
                  text: TextSpan(
                      text: 'Your Balance\n',
                      style: AppTypography.lightTheme.bodySmall?.copyWith(
                          color: Colors.white),
                      children: [
                        TextSpan(
                          text: 'AED ${state.user?.totalBalance ?? 0}',
                          style: AppTypography.lightTheme.headlineLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ]),
                );
              },
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
