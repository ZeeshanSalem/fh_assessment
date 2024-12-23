import 'package:equatable/equatable.dart';
import 'package:fh_assignment/core/cubit/base_cubit.dart';
import 'package:fh_assignment/core/error/model/error_response_model.dart';
import 'package:fh_assignment/features/top-up/data/models/beneficiary.dart';
import 'package:fh_assignment/features/top-up/domain/repository/beneficiary_repository.dart';

part 'beneficiary_state.dart';

class BeneficiaryCubit extends BaseCubit<BeneficiaryState> {
  final BeneficiaryRepository beneficiaryRepository;

  BeneficiaryCubit({
    required this.beneficiaryRepository,
  }) : super(
          const BeneficiaryState(
            status: BeneficiaryStatus.initial,
          ),
        ){
    getBeneficiaries();
  }

  /// Get all beneficiaries
  Future<void> getBeneficiaries() async {
    emit(state.copyWith(status: BeneficiaryStatus.loading));
    try {
      final result = await beneficiaryRepository.getBeneficiaries();
      result.fold(
        (exception) {
          emit(state.copyWith(
            status: BeneficiaryStatus.failure,
            errorModel: handleException(exception),
          ));
        },
        (beneficiaries) {
          emit(state.copyWith(
            status: BeneficiaryStatus.success,
            beneficiaries: beneficiaries,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: BeneficiaryStatus.failure,
        errorModel: ErrorModel(message: 'Unexpected error occurred'),
      ));
    }
  }

  /// Add a new beneficiary
  Future<void> addBeneficiary(Beneficiary beneficiary) async {
    emit(state.copyWith(status: BeneficiaryStatus.crudLoading));
    try {
      // Check if a beneficiary with the same ID already exists
      final isDuplicate = state.beneficiaries?.any((existingBeneficiary) => existingBeneficiary.id == beneficiary.id);

      if (isDuplicate == true) {
        // Emit failed state if the ID already exists
        emit(state.copyWith(
          status: BeneficiaryStatus.crudFailed,
          errorModel: ErrorModel(message: 'Beneficiary with the same ID already exists'),
        ));
        return; // Early return to prevent further processing
      }
      final result = await beneficiaryRepository.addBeneficiary(beneficiary);
      result.fold(
        (exception) {
          emit(state.copyWith(
            status: BeneficiaryStatus.crudFailed,
            errorModel: handleException(exception),
          ));
        },
        (success) {
          if (success) {
            final updatedBeneficiaries = [...?state.beneficiaries, beneficiary];
            emit(state.copyWith(
              status: BeneficiaryStatus.crudSuccess,
              beneficiaries: updatedBeneficiaries,
            ));
          }
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: BeneficiaryStatus.crudFailed,
        errorModel: ErrorModel(message: 'Unexpected error occurred'),
      ));
    }
  }

  /// Update a beneficiary
  Future<void> updateBeneficiary(Beneficiary updatedBeneficiary) async {
    emit(state.copyWith(status: BeneficiaryStatus.crudLoading));
    try {
      final result =
          await beneficiaryRepository.updateBeneficiary(updatedBeneficiary);
      result.fold(
        (exception) {
          emit(state.copyWith(
            status: BeneficiaryStatus.crudFailed,
            errorModel: handleException(exception),
          ));
        },
        (success) {
          if (success) {
            final updatedBeneficiaries =
                state.beneficiaries?.map((beneficiary) {
              return beneficiary.id == updatedBeneficiary.id
                  ? updatedBeneficiary
                  : beneficiary;
            }).toList();
            emit(state.copyWith(
              status: BeneficiaryStatus.crudSuccess,
              beneficiaries: updatedBeneficiaries,
            ));
          }
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: BeneficiaryStatus.crudFailed,
        errorModel: ErrorModel(message: 'Unexpected error occurred'),
      ));
    }
  }

  /// Delete a beneficiary
  Future<void> deleteBeneficiary(String id) async {
    emit(state.copyWith(status: BeneficiaryStatus.crudLoading));
    try {
      final result = await beneficiaryRepository.deleteBeneficiary(id);
      result.fold(
        (exception) {
          emit(state.copyWith(
            status: BeneficiaryStatus.crudFailed,
            errorModel: handleException(exception),
          ));
        },
        (success) {
          if (success) {
            final updatedBeneficiaries =
                state.beneficiaries?.where((b) => b.id != id).toList();
            emit(state.copyWith(
              status: BeneficiaryStatus.crudSuccess,
              beneficiaries: updatedBeneficiaries,
            ));
          }
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: BeneficiaryStatus.crudFailed,
        errorModel: ErrorModel(message: 'Unexpected error occurred'),
      ));
    }
  }
}
