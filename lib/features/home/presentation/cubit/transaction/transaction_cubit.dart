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

        /// @Dev :to show last transaction is first one
        List<Transaction> reverseList = r.reversed.toList();

        emit(state.copyWith(
          status: TransactionStatus.success,
          transactions: reverseList,
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

        /*
        * Here insert in 0 mean. to show on top because while during fetch we
        * reverse list.
        * */
        transaction.insert(0,r);



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
