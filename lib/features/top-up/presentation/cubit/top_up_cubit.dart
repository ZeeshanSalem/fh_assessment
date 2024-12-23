import 'package:equatable/equatable.dart';
import 'package:fh_assignment/core/cubit/base_cubit.dart';
import 'package:fh_assignment/core/error/model/error_response_model.dart';
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



  onAmountSelection(num? amount) {
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

  onBeneficiarySelection(Beneficiary? beneficiary) {
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
}
