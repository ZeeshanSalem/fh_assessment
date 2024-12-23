import 'package:equatable/equatable.dart';
import 'package:fh_assignment/core/cubit/base_cubit.dart';
import 'package:fh_assignment/core/error/model/error_response_model.dart';
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

        List<Transaction> sortedList = r;
        sortedList.sort((a, b) {
          DateTime dateA = DateTime.parse(a.createdAt!);
          DateTime dateB = DateTime.parse(b.createdAt!);
          return dateB.compareTo(dateA);
        });
        emit(state.copyWith(
          status: TransactionStatus.success,
          transactions: sortedList,
        ));
      });
    } catch (e, s) {
      emit(state.copyWith(
        status: TransactionStatus.failure,
        errorModel: ErrorModel(
          message: 'Exception $e',
        ),
      ));
    }
  }

  Future<void> addTransaction(Transaction transaction) async {
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

        // here add in top because this list will be always
        transaction.add(r);


        transaction.sort((a, b) {
          DateTime dateA = DateTime.parse(a.createdAt!);
          DateTime dateB = DateTime.parse(b.createdAt!);
          return dateB.compareTo(dateA);
        });

        emit(state.copyWith(
          status: TransactionStatus.transactionAdded,
          transactions: transaction,
        ));
      });
    } catch (e, s) {
      emit(state.copyWith(
        status: TransactionStatus.transactionFailed,
        errorModel: ErrorModel(
          message: 'Exception $e',
        ),
      ));
    }
  }
}
