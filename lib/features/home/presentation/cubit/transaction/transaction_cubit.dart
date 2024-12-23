import 'package:equatable/equatable.dart';
import 'package:fh_assignment/core/cubit/base_cubit.dart';
import 'package:fh_assignment/core/error/model/error_response_model.dart';
import 'package:fh_assignment/core/utils/transaction_validator.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';
import 'package:fh_assignment/features/home/domain/repository/home_repository.dart';

part 'transaction_state.dart';

class TransactionCubit extends BaseCubit<TransactionState> {
  final HomeRepository homeRepository;

  TransactionCubit({
    required this.homeRepository,
  }) : super(TransactionState(
          status: TransactionStatus.initial,
        )) {
    getTransactions();
  }

  Future<void> getTransactions() async {
    try {
      emit(state.copyWith(
        status: TransactionStatus.loading,
      ));
      final response = await homeRepository.getTransactions();

      response.fold((l) {
        emit(
          state.copyWith(
            status: TransactionStatus.failure,
            errorModel: handleException(l),
          ),
        );
      }, (r) {
        /// @Dev :to show last transaction is first one
        List<Transaction> reverseList = r.reversed.toList();

        emit(state.copyWith(
          status: TransactionStatus.success,
          transactions: reverseList,
        ));
      });
    } catch (e, stackTrace) {
      logger.e('$e', stackTrace);

      emit(state.copyWith(
        status: TransactionStatus.failure,
        errorModel: ErrorModel(
          message: 'Exception $e',
        ),
      ));
    }
  }

  Future<void> recharge(Transaction transaction) async {
    try {
      emit(state.copyWith(
        status: TransactionStatus.addingTransaction,
      ));

      final response = await homeRepository.addTransaction(transaction);

      response.fold((l) {
        emit(
          state.copyWith(
            status: TransactionStatus.transactionFailed,
            errorModel: handleException(l),
          ),
        );
      }, (r) {
        List<Transaction> transaction = List.from(state.transactions ?? []);

        /*
        * Here insert in 0 mean. to show on top because while during fetch we
        * reverse list.
        * */
        transaction.insert(0, r);

        emit(state.copyWith(
          status: TransactionStatus.transactionAdded,
          transactions: transaction,
        ));
      });
    } catch (e, stackTrace) {
      logger.e('$e', stackTrace);
      emit(state.copyWith(
        status: TransactionStatus.transactionFailed,
        errorModel: ErrorModel(
          message: 'Exception $e',
        ),
      ));
    }
  }

  /*
   *  Validates a transaction against multiple business rules:
   * 1. Balance Check:
   *    - Ensures available balance is sufficient for the transaction
   *    - Returns error if transaction amount exceeds available balance
   *
   * 2. Monthly Spending Limit:
   *    - Total monthly transactions cannot exceed AED 3,000
   *    - Includes all debt transactions in current calendar month
   *
   * 3. Beneficiary Limits:
   *    - Verified users: Maximum AED 1,000 per beneficiary per month
   *    - Unverified users: Maximum AED 500 per beneficiary per month
  */
  TransactionValidationResult validateTransaction(
      Transaction transaction, bool isUserVerified, num availableBalance) {
    final monthlyTransactions = _getCurrentMonthTransactions();

    final validator = TransactionValidator(
      monthlyTransactions: monthlyTransactions,
      isUserVerified: isUserVerified,
      availableBalance: availableBalance,
    );

    return validator.validateTransaction(transaction);
  }

  List<Transaction> _getCurrentMonthTransactions() {
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month);

    return state.transactions?.where((transaction) {
          final transactionDate = DateTime.parse(transaction.createdAt!);
          return transactionDate.year == currentMonth.year &&
              transactionDate.month == currentMonth.month;
        }).toList() ??
        [];
  }

  void addTransactionFromTopUp(Transaction? transaction) {
    emit(state.copyWith(
      status: TransactionStatus.addingTransaction,
    ));
    if (transaction == null) return;
    List<Transaction> transactions = List.from(state.transactions ?? []);

    /*
        * Here insert in 0 mean. to show on top because while during fetch we
        * reverse list.
        * */
    transactions.insert(0, transaction);

    emit(state.copyWith(
      status: TransactionStatus.transactionAdded,
      transactions: transactions,
    ));
  }
}
