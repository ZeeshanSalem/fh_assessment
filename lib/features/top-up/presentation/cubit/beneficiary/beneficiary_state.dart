part of 'beneficiary_cubit.dart';


enum BeneficiaryStatus {
  initial,
  loading,
  success,
  failure,
}

class BeneficiaryState extends Equatable {
  final BeneficiaryStatus? status;
  final ErrorModel? errorModel;

  final List<Beneficiary>? beneficiaries;

  const BeneficiaryState({
    this.errorModel,
    this.status,
    this.beneficiaries,
  });

  factory BeneficiaryState.fromJson(json) {
    return BeneficiaryState(
      status: BeneficiaryStatus.values[json['status'] ?? 0],
      errorModel: json['errorModel'] != null
          ? ErrorModel.fromJson(json['errorModel'])
          : null,
      beneficiaries: json['beneficiaries'] != null
          ? List.from(json['beneficiaries']
              .map((beneficiary) => Beneficiary.fromJson(beneficiary))
              .toList())
          : null,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'errorModel': errorModel?.toJson(),
        'beneficiaries':
            beneficiaries?.map((beneficiary) => beneficiary.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        errorModel,
        status,
        beneficiaries,
      ];
}
