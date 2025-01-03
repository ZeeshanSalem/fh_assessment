import 'package:fh_assignment/core/di/injection_container_common.dart';
import 'package:fh_assignment/features/home/presentation/cubit/home_cubit.dart';
import 'package:fh_assignment/features/home/presentation/cubit/transaction/transaction_cubit.dart';
import 'package:fh_assignment/features/top-up/presentation/cubit/beneficiary/beneficiary_cubit.dart';
import 'package:fh_assignment/features/top-up/presentation/cubit/top_up_cubit.dart';

Future<void> initPresentationDI() async {
  serviceLocator.registerFactory<TopUpCubit>(
    () => TopUpCubit(
      topUpRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<BeneficiaryCubit>(
    () => BeneficiaryCubit(
      beneficiaryRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<HomeCubit>(
    () => HomeCubit(
      homeRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<TransactionCubit>(
    () => TransactionCubit(
      homeRepository: serviceLocator(),
    ),
  );
}
