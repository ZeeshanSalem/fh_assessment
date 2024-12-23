part of 'transaction_cubit.dart';

enum TransactionStatus {
  initial,
  loading,
  success,
  failure,
  addingTransaction,
  transactionAdded,
  transactionFailed,
}

class TransactionState extends Equatable {
  final TransactionStatus? status;
  final ErrorModel? errorModel;
  final List<Transaction>? transactions;

  const TransactionState({this.errorModel, this.status, this.transactions});

  TransactionState copyWith({
    TransactionStatus? status,
    ErrorModel? errorModel,
    List<Transaction>? transactions,
  }) {
    return TransactionState(
      status: status ?? this.status,
      errorModel: errorModel ,
      transactions: transactions ?? this.transactions,
    );
  }

  factory TransactionState.fromJson(json) {
    return TransactionState(
      status: TransactionStatus.values[json['status'] ?? 0],
      errorModel: json['errorModel'] != null
          ? ErrorModel.fromJson(json['errorModel'])
          : null,
      transactions: json['transactions'] != null
          ? List.from(json['transactions']
              .map((tran) => Transaction.fromJson(tran))
              .toList())
          : null,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'errorModel': errorModel?.toJson(),
        'transactions': transactions?.map((tran) => tran.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        errorModel,
        status,
        transactions,
      ];
}
