import 'package:equatable/equatable.dart';
import 'package:fh_assignment/core/utils/enums.dart';

class Transaction extends Equatable {
  String? createdAt;
  String? beneficiary;
  TransactionType? type;
  String? amount;
  String? accountNumber; // it's register phone number
  String? currency;
  String? id; // will be generated in server.

  Transaction(
      {this.createdAt,
      this.beneficiary,
      this.type,
      this.amount,
      this.accountNumber,
      this.currency,
      this.id});

  Transaction.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    beneficiary = json['beneficiary'];
    type = json['type'] != null ? _transactionTypeFromString(json['type']) : null; // Map string to enum
    amount = json['amount'];
    accountNumber = json['accountNumber'];
    currency = json['currency'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['beneficiary'] = beneficiary;
    data['type'] = type?.name;
    data['amount'] = amount;
    data['accountNumber'] = accountNumber;
    data['currency'] = currency;
    data['id'] = id;
    return data;
  }

  // Helper function to convert string to enum
  TransactionType? _transactionTypeFromString(String? type) {
    if (type == null) return null;
    return TransactionType.values.firstWhere(
      (e) => e.name == type,
      orElse: () => throw ArgumentError('Invalid transaction type: $type'),
    );
  }

  @override
  List<Object?> get props =>
      [createdAt, beneficiary, type, amount, accountNumber, currency, id];
}
