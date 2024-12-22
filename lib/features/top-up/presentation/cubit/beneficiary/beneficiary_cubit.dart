import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fh_assignment/core/cubit/base_cubit.dart';
import 'package:fh_assignment/core/error/model/error_response_model.dart';
import 'package:fh_assignment/features/top-up/data/models/beneficiary.dart';
import 'package:fh_assignment/features/top-up/domain/repository/beneficiary_repository.dart';
import 'package:fh_assignment/features/top-up/domain/repository/top_up_repository.dart';

part 'beneficiary_state.dart';

class BeneficiaryCubit extends BaseCubit<BeneficiaryState> {
  final BeneficiaryRepository beneficiaryRepository;

  BeneficiaryCubit({
    required this.beneficiaryRepository,
  }) : super(const BeneficiaryState(
          status: BeneficiaryStatus.initial,
        ));



}
