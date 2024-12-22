import 'package:fh_assignment/core/utils/app_colors.dart';
import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          spacing: 10,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: CustomColors.primary,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 44,
                        color: CustomColors.primary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${state.user?.name}',
                      style: AppTypography.lightTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Verified',
                style: AppTypography.lightTheme.headlineMedium,
              ),
              trailing: Switch(
                  inactiveThumbColor: Colors.grey,
                  value: state.user?.accountStatus ?? false,
                  onChanged: (val) {
                    context.read<HomeCubit>().onAccountVerification(val);
                  }),
            ),
          ],
        );
      },
    );
  }
}
