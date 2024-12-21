import 'package:fh_assignment/core/di/injection_container_common.dart';
import 'package:fh_assignment/core/utils/preferences_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> initCacheDI() async {
  final sharedPref = await SharedPreferences.getInstance();

  serviceLocator.registerLazySingleton<SharedPreferences>(() => sharedPref);
  serviceLocator.registerLazySingleton<PreferencesUtil>(
      () => PreferencesUtil(preferences: sharedPref, logger: serviceLocator()));
}
