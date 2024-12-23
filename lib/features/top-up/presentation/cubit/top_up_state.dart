part of 'top_up_cubit.dart';

enum TopUpStatus {
  initial,
  loading,
  success,
  failure,
  optionSelection,
  optionSelected,
}

class TopUpState extends Equatable {
  final TopUpStatus? status;
  final ErrorModel? errorModel;
  final Transaction? latestTransaction;

  /// Selected Recharge amount for topUp
  final num? selectedAmount;

  /// Account for topUp Contain
  /// 1. nickname
  /// 2. id: [Register Phone Number]
  final Beneficiary? selectedBeneficiary;

  const TopUpState(
      {this.errorModel,
      this.status,
      this.selectedAmount,
      this.selectedBeneficiary,
      this.latestTransaction});

  TopUpState copyWith({
    TopUpStatus? status,
    ErrorModel? errorModel,
    num? selectedAmount,
    Beneficiary? selectedBeneficiary,
    Transaction? latestTransaction,
  }) {
    return TopUpState(
      status: status ?? this.status,
      errorModel: errorModel ?? this.errorModel,
      latestTransaction: latestTransaction ?? this.latestTransaction,
      selectedAmount: selectedAmount,
      selectedBeneficiary: selectedBeneficiary,
    );
  }

  factory TopUpState.fromJson(json) {
    return TopUpState(
      status: TopUpStatus.values[json['status'] ?? 0],
      errorModel: json['errorModel'] != null
          ? ErrorModel.fromJson(json['errorModel'])
          : null,
      latestTransaction: json['latestTransaction'] != null
          ? Transaction.fromJson(json['latestTransaction'])
          : null,
      selectedBeneficiary: json['selectedBeneficiary'] != null
          ? Beneficiary.fromJson(json['selectedBeneficiary'])
          : null,
      selectedAmount: json['selectedAmount'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'errorModel': errorModel?.toJson(),
        'selectedBeneficiary': selectedBeneficiary?.toJson(),
        'selectedAmount': selectedAmount,
        'latestTransaction': latestTransaction?.toJson(),
      };

  @override
  List<Object?> get props => [
        errorModel,
        status,
        selectedBeneficiary,
        selectedAmount,
        latestTransaction,
      ];
}
