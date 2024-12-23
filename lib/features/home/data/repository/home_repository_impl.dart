import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fh_assignment/core/error/exception.dart';
import 'package:fh_assignment/core/network/network_info.dart';
import 'package:fh_assignment/features/home/data/data_source/home_local_data_source.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';
import 'package:fh_assignment/features/home/data/model/user.dart';
import 'package:fh_assignment/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final NetworkInfo networkInfo;
  final HomeLocalDataSource homeRemoteDataSource;

  HomeRepositoryImpl({
    required this.networkInfo,
    required this.homeRemoteDataSource,
  });

  @override
  Future<Either<Exception, User>> getProfile() async {
    try {
      final response = await homeRemoteDataSource.getProfile();
      return Right(
        User.fromJson(
          response,
        ),
      );
    } on Exception catch (exception) {
      return Left(
        exception,
      );
    }
  }

  @override
  Future<Either<Exception, List<Transaction>>> getTransactions() async {
    if (networkInfo.isConnected) {
      try {
        final response = await homeRemoteDataSource.getTransactions();
        final transactions = (response as List<dynamic>)
            .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
            .toList();


        return Right(transactions);
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

  @override
  Future<Either<Exception, Transaction>> addTransaction(
      Transaction transaction) async {
    if (networkInfo.isConnected) {
      try {
        final response = await homeRemoteDataSource.addTransaction(transaction);

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
