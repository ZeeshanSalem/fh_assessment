import 'package:fh_assignment/core/utils/typography.dart';
import 'package:fh_assignment/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routing/routers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    context.read<HomeCubit>().getMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.status == HomeStatus.success) {
          context.goNamed(
            Routes.homeRoute,
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// todo: add font style.
              Text(
                'Finance House',
                style: AppTypography.lightTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
