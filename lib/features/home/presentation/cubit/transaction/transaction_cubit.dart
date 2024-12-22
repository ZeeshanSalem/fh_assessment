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
        ));

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
        emit(state.copyWith(
          status: TransactionStatus.success,
          transactions: r,
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
}
