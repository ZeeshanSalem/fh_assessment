import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_parent.dart';
import 'core/di/injection_container_common.dart';
import 'core/routing/routing.dart';
import 'core/shared_pref/preference.dart';
import 'core/utils/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  PreferenceUtils.init();
  await initDi();
  // Lock the app in portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AppGlobalProvider(
      child: MaterialApp.router(
        title: 'Finance House',
        debugShowCheckedModeBanner: false,
        routerConfig: routeConfig,
        theme: AppTheme.lightTheme,

      ),
    );
  }
}
