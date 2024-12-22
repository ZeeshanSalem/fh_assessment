import 'package:fh_assignment/core/di/injection_container_common.dart';
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
}
