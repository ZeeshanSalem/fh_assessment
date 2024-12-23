import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fh_assignment/core/error/exception.dart';
import 'package:fh_assignment/core/network/network_info.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';
import 'package:fh_assignment/features/top-up/data/data_source/top_up_data_source.dart';
import 'package:fh_assignment/features/top-up/domain/repository/top_up_repository.dart';

class TopUpRepositoryImpl extends TopUpRepository {
  final NetworkInfo networkInfo;
  final TopUpDataSource topUpDataSource;

  TopUpRepositoryImpl({
    required this.networkInfo,
    required this.topUpDataSource,
  });

  @override
  Future<Either<Exception, Transaction>> topUp(Transaction transaction) async {
    if (networkInfo.isConnected) {
      try {
        final response = await topUpDataSource.topUp(transaction);

        return Right(Transaction.fromJson(response));
      } on ServerException catch (exception) {
        return Left(
          ServerException(
            dioException: DioException(
              error: exception.dioException,
              requestOptions: RequestOptions(),
            ),
          ),
        );
      }
    } else {
      return Left(NoInternetException(message: 'No Internet Connection'));
    }
  }
}
