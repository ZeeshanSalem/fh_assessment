import 'package:fh_assignment/core/di/injection_container_common.dart';
import 'package:fh_assignment/features/home/data/repository/home_repository_impl.dart';
import 'package:fh_assignment/features/home/domain/repository/home_repository.dart';
import 'package:fh_assignment/features/top-up/data/repository_imp/beneficiary_repository_impl.dart';
import 'package:fh_assignment/features/top-up/data/repository_imp/top_up_repository_impl.dart';
import 'package:fh_assignment/features/top-up/domain/repository/beneficiary_repository.dart';
import 'package:fh_assignment/features/top-up/domain/repository/top_up_repository.dart';

Future<void> initDomainDI() async {
  serviceLocator.registerLazySingleton<TopUpRepository>(
    () => TopUpRepositoryImpl(
      topUpDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<BeneficiaryRepository>(
    () => BeneficiaryRepositoryImpl(
      topUpDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      homeRemoteDataSource: serviceLocator(),
      networkInfo: serviceLocator(),
    ),
  );
}
