import 'package:fh_assignment/core/di/injection_container_common.dart';
import 'package:fh_assignment/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// @Dev: here it parent where we have global provider init for all over the
/// like localization etc.
class AppGlobalProvider extends StatelessWidget {
  const AppGlobalProvider({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<HomeCubit>(),
        ),

      ],
      child: child,
    );
  }
}