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

  /// this check is used when we add new topUp and want to come back
  /// from topUp Screen at that time we can refresh list on home screen.
  final bool? isNewTopUpAdded;

  /// Selected Recharge amount for topUp
  final num? topUpAmount;

  /// Account for topUp Contain
  /// 1. nickname
  /// 2. id: [Register Phone Number]
  final Beneficiary? selectedBeneficiary;

  const TopUpState({
    this.errorModel,
    this.status,
    this.topUpAmount,
    this.selectedBeneficiary,
    this.latestTransaction,
    this.isNewTopUpAdded,
  });

  TopUpState copyWith({
    TopUpStatus? status,
    ErrorModel? errorModel,
    num? topUpAmount,
    Beneficiary? selectedBeneficiary,
    Transaction? latestTransaction,
    bool? isNewTopUpAdded,
  }) {
    return TopUpState(
      status: status ?? this.status,
      isNewTopUpAdded: isNewTopUpAdded ?? this.isNewTopUpAdded,
      errorModel: errorModel ?? this.errorModel,
      latestTransaction: latestTransaction ?? this.latestTransaction,
      topUpAmount: topUpAmount,
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
      topUpAmount: json['topUpAmount'],
      isNewTopUpAdded: json['isNewTopUpAdded'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'errorModel': errorModel?.toJson(),
        'selectedBeneficiary': selectedBeneficiary?.toJson(),
        'topUpAmount': topUpAmount,
        'isNewTopUpAdded': isNewTopUpAdded,
        'latestTransaction': latestTransaction?.toJson(),
      };

  @override
  List<Object?> get props => [
        errorModel,
        status,
        selectedBeneficiary,
        topUpAmount,
        latestTransaction,
        isNewTopUpAdded,
      ];
}
