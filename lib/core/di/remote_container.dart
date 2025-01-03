import 'package:fh_assignment/core/di/injection_container_common.dart';
import 'package:fh_assignment/features/home/data/data_source/home_local_data_source.dart';
import 'package:fh_assignment/features/top-up/data/data_source/top_up_data_source.dart';

Future<void> initRemoteDI() async {
  serviceLocator.registerLazySingleton<TopUpDataSource>(
    () => TopUpDataSourceImpl(
      networkClient: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<TopUpDataSource>(
    () => TopUpDataSourceImpl(
      networkClient: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(
      networkClient: serviceLocator(),
      preferencesUtil: serviceLocator(),
    ),
  );
}
