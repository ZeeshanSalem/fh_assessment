import 'package:fh_assignment/core/routing/routers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  _init() async {
    await Future.delayed(
      Duration(
        seconds: 1,
      ),
    ).then((value) {
      context.pushReplacementNamed(
        Routes.homeRoute,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// todo: add font style.
            Text(
              'Finance House',
            ),
            const SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
