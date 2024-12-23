import 'package:fh_assignment/core/di/injection_container_common.dart';
import 'package:fh_assignment/core/routing/routers.dart';
import 'package:fh_assignment/features/home/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:fh_assignment/features/home/presentation/ui/home_screen.dart';
import 'package:fh_assignment/features/splash/presentation/ui/splash_screen.dart';
import 'package:fh_assignment/features/top-up/presentation/cubit/beneficiary/beneficiary_cubit.dart';
import 'package:fh_assignment/features/top-up/presentation/cubit/top_up_cubit.dart';
import 'package:fh_assignment/features/top-up/presentation/ui/top_up_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter routeConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: Routes.initialRoute,
      path: Routes.initialRoute,
      builder: (context, state) {
        return const SplashScreen();
      },

      routes: [


      ],
    ),

    GoRoute(
        name: Routes.homeRoute,
        path: Routes.homeRoute,
        builder: (context, state) {
          return BlocProvider<TransactionCubit>(
            create: (context) => serviceLocator<TransactionCubit>(),
            child: HomeScreen(),
          );
        },
        routes: [
          GoRoute(
            name: '${Routes.homeRoute}/${Routes.topUpRoute}',
            path: Routes.topUpRoute,
            builder: (context, state) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<TopUpCubit>(
                    create: (context) => serviceLocator<TopUpCubit>(),
                  ),
                  BlocProvider<BeneficiaryCubit>(
                    create: (context) => serviceLocator<BeneficiaryCubit>(),
                  ),

                  BlocProvider<TransactionCubit>.value(
                    value: serviceLocator<TransactionCubit>(),
                  ),
                ],
                child: TopUpScreen(),
              );
            },
          ),
        ]
    ),
  ],
);
