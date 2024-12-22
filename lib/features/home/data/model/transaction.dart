class Transaction {
  String? createdAt;
  String? beneficiary;
  String? type;
  String? amount;
  String? accountNumber;
  String? currency;
  String? id;

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
    type = json['type'];
    amount = json['amount'];
    accountNumber = json['accountNumber'];
    currency = json['currency'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['beneficiary'] = beneficiary;
    data['type'] = type;
    data['amount'] = amount;
    data['accountNumber'] = accountNumber;
    data['currency'] = currency;
    data['id'] = id;
    return data;
  }
}