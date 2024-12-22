import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fh_assignment/core/di/injection_container_common.dart';
import 'package:fh_assignment/core/error/exception.dart';
import 'package:fh_assignment/core/network/network_client.dart';
import 'package:fh_assignment/core/network/network_constant.dart';
import 'package:fh_assignment/core/utils/constants.dart';
import 'package:fh_assignment/core/utils/preferences_utils.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';
import 'package:flutter/services.dart';

abstract class HomeLocalDataSource {
  Future<dynamic> getProfile();

  Future<dynamic> getTransactions();

  Future<dynamic> addTransaction(Transaction transactionData);
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  final NetworkClient networkClient;
  PreferencesUtil preferences = serviceLocator<PreferencesUtil>();

  HomeLocalDataSourceImpl({required this.networkClient});

  @override
  Future<dynamic> getTransactions() async {
    final response = await networkClient.invoke(transaction, RequestType.get);
    if (response.statusCode == 200) {
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

  @override
  Future<dynamic> getProfile() async {
    try {
      /// Here first time it's will be null at that time will get mock data from
      /// profile.json which is in asset folder
      String profileString = preferences.getPreferencesData(Constant.kProfile);
      if (profileString.isNotEmpty) {
        return jsonDecode(profileString) as Map<String, dynamic>;
      } else {
        return _loadJsonData();
      }
    } catch (e, s) {
      throw GeneralException(
        message: 'Failed: $e',
      );
    }
  }

  @override
  Future<dynamic> addTransaction(Transaction transactionData) async {
    final response = await networkClient.invoke(
      transaction,
      RequestType.post,
      requestBody: transactionData.toJson(),
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

  Future<dynamic> _loadJsonData() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/profile.json');
    Map<String, dynamic> profileJson =
        jsonDecode(jsonString) as Map<String, dynamic>;
    preferences.setPreferencesData(Constant.kProfile, jsonEncode(profileJson));
    return profileJson;
  }
}
