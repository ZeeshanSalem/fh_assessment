import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fh_assignment/core/di/domain_container.dart';
import 'package:fh_assignment/core/di/injection_container_cache.dart';
import 'package:fh_assignment/core/di/presentation_container.dart';
import 'package:fh_assignment/core/di/remote_container.dart';
import 'package:fh_assignment/core/logger/app_logger.dart';
import 'package:fh_assignment/core/logger/pretty_dio_logger.dart';
import 'package:fh_assignment/core/network/network_client.dart';
import 'package:fh_assignment/core/network/network_constant.dart';
import 'package:fh_assignment/core/network/network_info.dart';
import 'package:fh_assignment/core/utils/preferences_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';


import '../utils/constants.dart';

final serviceLocator = GetIt.I;

Future<void> initDi() async {
  try{
    serviceLocator.allowReassignment = true;

    serviceLocator.registerLazySingleton(
          () => Logger(
        printer: PrettyPrinter(
          methodCount: 0,
          errorMethodCount: 5,
          lineLength: 50,
          colors: true,
          printEmojis: true,
          printTime: true,
        ),
      ),
    );

    serviceLocator
        .registerLazySingleton(() => AppLogger(logger: serviceLocator()));

    serviceLocator.registerLazySingleton(
          () => NetworkInfo(),
    );

    await initCacheDI();
    await initDio();

    initPresentationDI();
    initRemoteDI();
    initDomainDI();


    serviceLocator.registerLazySingleton(
          () => NetworkClient(
        dio: serviceLocator(),
        logger: serviceLocator(),
      ),
    );

    serviceLocator.registerLazySingleton(() => NetworkInfo());
  }catch(e,s){
    debugPrint("Exception in  initDI $e");
    debugPrint("$s");
  }
}

Future<void> initDio() async {
  try {
    Dio dio = Dio();

    BaseOptions baseOptions = BaseOptions(
      receiveTimeout: const Duration(seconds: 3),
      connectTimeout: const Duration(seconds: 3),
      headers: {
        HttpHeaders.userAgentHeader: 'dio',
        'api': '1.0,0',
      },
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      baseUrl: baseUrl,
      maxRedirects: 2,
    );
    dio.options = baseOptions;

    dio.interceptors.clear();

    dio.interceptors.add(PrettyDioLogger(
      requestBody: kDebugMode,
      error: kDebugMode,
      request: kDebugMode,
      compact: kDebugMode,
      maxWidth: 90,
      requestHeader: kDebugMode,
      responseBody: kDebugMode,
      responseHeader: kDebugMode,
      // logPrint: (o) {},
    ));

    PreferencesUtil preferences = serviceLocator<PreferencesUtil>();

    dio.interceptors.add(
        QueuedInterceptorsWrapper(onError: (DioException error, handler) async {
      return handler.next(error);
    }, onRequest: (RequestOptions requestOptions, handler) async {
      var accessToken =
          preferences.getPreferencesData(Constant.kAccessTokenPref);

      if (accessToken != "" || accessToken != null) {
        var authHeader = {'Authorization': 'Bearer $accessToken'};
        requestOptions.headers.addAll(authHeader);
      }
      return handler.next(requestOptions);
    }, onResponse: (response, handler) async {
      return handler.next(response);
    }));
    if (serviceLocator.isRegistered<Dio>()) {
      await serviceLocator.unregister<Dio>();
    }

    serviceLocator.registerLazySingleton(() => dio);
  } catch (e, s) {
    debugPrint("Exception in  initDIO $e");
    debugPrint("$s");
  }
}
