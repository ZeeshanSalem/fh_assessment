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

  /// TopUp Recharge Amount options.
  /// It's contain 5, 10, 20, 30, 50,75 and 100 AED.
  final List<String> rechargeableAmounts = [
    'AED 5',
    'AED 10',
    'AED 20',
    'AED 30',
    'AED 50',
    'AED 75',
    'AED 100',
  ];

  onAmountSelection(String? amount) {
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
        selectedBeneficiary: beneficiary
      ),
    );
  }
}
