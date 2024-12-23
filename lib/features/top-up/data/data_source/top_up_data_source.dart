import 'package:dio/dio.dart';
import 'package:fh_assignment/core/error/exception.dart';
import 'package:fh_assignment/core/network/network_client.dart';
import 'package:fh_assignment/core/network/network_constant.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';

abstract class TopUpDataSource {
  Future<dynamic> topUp(Transaction transaction);
}

class TopUpDataSourceImpl extends TopUpDataSource {
  final NetworkClient networkClient;

  TopUpDataSourceImpl({required this.networkClient});

  @override
  Future<dynamic> topUp(Transaction transaction) async {
    final response = await networkClient.invoke(
      transactionAPI, // Here we assume same api.
      RequestType.post,
      requestBody: transaction.toJson(),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data;
    } else {
      throw ServerException(
        dioException: DioException(
          requestOptions: response.requestOptions,
          error: response,
          type: DioExceptionType.badResponse,
        ),
      );
    }
  }
}
