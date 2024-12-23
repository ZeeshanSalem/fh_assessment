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
        topUpAmount: null,
        selectedBeneficiary: state.selectedBeneficiary,
      ),
    );
    emit(
      state.copyWith(
          status: TopUpStatus.optionSelected,
          topUpAmount: amount,
          selectedBeneficiary: state.selectedBeneficiary),
    );
  }

  void onBeneficiarySelection(Beneficiary? beneficiary) {
    emit(
      state.copyWith(
        status: TopUpStatus.optionSelection,
        topUpAmount: state.topUpAmount,
        selectedBeneficiary: null,
      ),
    );
    emit(
      state.copyWith(
          status: TopUpStatus.optionSelected,
          topUpAmount: state.topUpAmount,
          selectedBeneficiary: beneficiary),
    );
  }

  Future<void> onTopUp(Transaction transaction) async {
    try {
      emit(state.copyWith(
          status: TopUpStatus.loading,
          topUpAmount: state.topUpAmount,
          selectedBeneficiary: state.selectedBeneficiary));

      final response = await topUpRepository.topUp(transaction);

      response.fold((l) {
        emit(
          state.copyWith(
              status: TopUpStatus.failure,
              errorModel: handleException(l),
              topUpAmount: state.topUpAmount,
              selectedBeneficiary: state.selectedBeneficiary),
        );
      }, (r) {
        emit(state.copyWith(
          status: TopUpStatus.success,
          latestTransaction: transaction,
          topUpAmount: state.topUpAmount,
          selectedBeneficiary: state.selectedBeneficiary,
          isNewTopUpAdded: true,
        ));
      });
    } catch (e, stackTrace) {
      logger.e('$e', stackTrace);
      emit(state.copyWith(
        status: TopUpStatus.failure,
        topUpAmount: state.topUpAmount,
        selectedBeneficiary: state.selectedBeneficiary,
        errorModel: ErrorModel(
          message: 'Exception $e',
        ),
      ));
    }
  }
}
