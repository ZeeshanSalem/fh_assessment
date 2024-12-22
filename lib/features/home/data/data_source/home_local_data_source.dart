import 'dart:convert';

import 'package:fh_assignment/core/di/injection_container_common.dart';
import 'package:fh_assignment/core/error/exception.dart';
import 'package:fh_assignment/core/network/network_client.dart';
import 'package:fh_assignment/core/utils/constants.dart';
import 'package:fh_assignment/core/utils/preferences_utils.dart';
import 'package:flutter/services.dart';

abstract class HomeLocalDataSource {
  Future<dynamic> getProfile();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  final NetworkClient networkClient;
  PreferencesUtil preferences = serviceLocator<PreferencesUtil>();

  HomeLocalDataSourceImpl({required this.networkClient});

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

  Future<dynamic> _loadJsonData() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/profile.json');
    Map<String, dynamic> profileJson =
        jsonDecode(jsonString) as Map<String, dynamic>;
    preferences.setPreferencesData(Constant.kProfile, jsonEncode(profileJson));
    return profileJson;
  }
}
