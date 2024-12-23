import 'package:equatable/equatable.dart';
import 'package:fh_assignment/core/cubit/base_cubit.dart';
import 'package:fh_assignment/core/error/model/error_response_model.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';
import 'package:fh_assignment/features/top-up/data/models/beneficiary.dart';
import 'package:fh_assignment/features/top-up/domain/repository/top_up_repository.dart';

part 'top_up_state.dart';

class TopUpCubit extends BaseCubit<TopUpState> {
  final TopUpRepository topUpRepository;

  TopUpCubit({
    required this.topUpRepository,
  }) : super(
          const TopUpState(
            status: TopUpStatus.initial,
          ),
        );

  void onAmountSelection(num? amount) {
    emit(
      state.copyWith(
        status: TopUpStatus.optionSelection,
        selectedAmount: null,
        selectedBeneficiary: state.selectedBeneficiary,
      ),
    );
    emit(
      state.copyWith(
          status: TopUpStatus.optionSelected,
          selectedAmount: amount,
          selectedBeneficiary: state.selectedBeneficiary),
    );
  }

  void onBeneficiarySelection(Beneficiary? beneficiary) {
    emit(
      state.copyWith(
        status: TopUpStatus.optionSelection,
        selectedAmount: state.selectedAmount,
        selectedBeneficiary: null,
      ),
    );
    emit(
      state.copyWith(
          status: TopUpStatus.optionSelected,
          selectedAmount: state.selectedAmount,
          selectedBeneficiary: beneficiary),
    );
  }

  Future<void> onTopUp(Transaction transaction) async {
    try {
      emit(state.copyWith(
          status: TopUpStatus.loading,
          selectedAmount: state.selectedAmount,
          selectedBeneficiary: state.selectedBeneficiary));

      final response = await topUpRepository.topUp(transaction);

      response.fold((l) {
        emit(
          state.copyWith(
              status: TopUpStatus.failure,
              errorModel: handleException(l),
              selectedAmount: state.selectedAmount,
              selectedBeneficiary: state.selectedBeneficiary),
        );
      }, (r) {
        emit(state.copyWith(
            status: TopUpStatus.success,
            latestTransaction: transaction,
            selectedAmount: state.selectedAmount,
            selectedBeneficiary: state.selectedBeneficiary));
      });
    } catch (e, stackTrace) {
      logger.e('$e', stackTrace);
      emit(state.copyWith(
        status: TopUpStatus.failure,
        selectedAmount: state.selectedAmount,
        selectedBeneficiary: state.selectedBeneficiary,
        errorModel: ErrorModel(
          message: 'Exception $e',
        ),
      ));
    }
  }
}
