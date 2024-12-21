import 'package:fh_assignment/core/routing/routers.dart';
import 'package:fh_assignment/features/home/presentation/ui/home_screen.dart';
import 'package:fh_assignment/features/splash/presentation/ui/splash_screen.dart';
import 'package:flutter/cupertino.dart';
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
          GoRoute(
            name: Routes.homeRoute,
            path: Routes.homeRoute,
            builder: (context, state) {
              return const HomeScreen();
            },
          ),
        ]),
  ],
);
