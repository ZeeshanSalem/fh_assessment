import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fh_assignment/core/di/injection_container_common.dart';
import 'package:fh_assignment/core/error/exception.dart';
import 'package:fh_assignment/core/network/network_info.dart';
import 'package:fh_assignment/core/utils/constants.dart';
import 'package:fh_assignment/core/utils/preferences_utils.dart';
import 'package:fh_assignment/features/top-up/data/data_source/top_up_data_source.dart';
import 'package:fh_assignment/features/top-up/data/models/beneficiary.dart';
import 'package:fh_assignment/features/top-up/domain/repository/beneficiary_repository.dart';
import 'package:flutter/cupertino.dart';

class BeneficiaryRepositoryImpl extends BeneficiaryRepository {
  final NetworkInfo networkInfo;
  final TopUpDataSource topUpDataSource;
  PreferencesUtil preferences = serviceLocator<PreferencesUtil>();

  BeneficiaryRepositoryImpl({
    required this.networkInfo,
    required this.topUpDataSource,
  });

  @override
  Future<Either<Exception, List<Beneficiary>>> getBeneficiaries() async {
    try {
      // Retrieve the current list of beneficiaries
      List<String>? beneficiaryStrings =
          preferences.getPreferencesListData(Constant.kBeneficiaries);

      if ((beneficiaryStrings ?? []).isNotEmpty) {
        // Deserialize the strings into Beneficiary objects
        List<Beneficiary> beneficiaries = beneficiaryStrings!
            .map((beneficiaryString) =>
                Beneficiary.fromJson(jsonDecode(beneficiaryString)))
            .toList();
        return Right(beneficiaries);
      } else {
        return Right([]);
      }
    } catch (e, s) {
      debugPrint('Exception : $e');
      debugPrint('StackTrace : $s');

      return Left(GeneralException(
        message: 'Error: Failed to get beneficiaries',
      ));
    }
  }

  @override
  Future<Either<Exception, bool>> addBeneficiary(
      Beneficiary beneficiary) async {
    try {
      // Retrieve the current list of beneficiaries
      List<String>? beneficiaryStrings =
          preferences.getPreferencesListData(Constant.kBeneficiaries);

      List<Beneficiary> beneficiaries = beneficiaryStrings != null
          ? beneficiaryStrings
              .map((beneficiaryString) =>
                  Beneficiary.fromJson(jsonDecode(beneficiaryString)))
              .toList()
          : [];

      // Add the new beneficiary to the list
      beneficiaries.add(beneficiary);

      // Serialize the updated list back to strings
      List<String> updatedBeneficiaryStrings = beneficiaries
          .map((beneficiary) => jsonEncode(beneficiary.toJson()))
          .toList();

      // Save the updated list to preferences
      preferences.setPreferencesListData(
          Constant.kBeneficiaries, updatedBeneficiaryStrings);

      // Return success
      return Right(true);
    } catch (e, s) {
      debugPrint('Exception : $e');
      debugPrint('StackTrace : $s');

      // Return failure with exception
      return Left(GeneralException(
        message: 'Error: Failed to add beneficiary',
      ));
    }
  }

  @override
  Future<Either<Exception, bool>> updateBeneficiary(
      Beneficiary beneficiary) async {
    try {
      // Retrieve the current list of beneficiaries
      List<String>? beneficiaryStrings =
          preferences.getPreferencesListData(Constant.kBeneficiaries);

      List<Beneficiary> beneficiaries = beneficiaryStrings != null
          ? beneficiaryStrings
              .map((beneficiaryString) =>
                  Beneficiary.fromJson(jsonDecode(beneficiaryString)))
              .toList()
          : [];

      // Find the index of the beneficiary to update
      int index = beneficiaries
          .indexWhere((beneficiary) => beneficiary.id == beneficiary.id);

      if (index != -1) {
        // Replace the old beneficiary with the updated one
        beneficiaries[index] = beneficiary;

        // Serialize the updated list
        List<String> updatedBeneficiaryStrings = beneficiaries
            .map((beneficiary) => jsonEncode(beneficiary.toJson()))
            .toList();

        // Save the updated list to preferences
        preferences.setPreferencesListData(
            Constant.kBeneficiaries, updatedBeneficiaryStrings);

        // Return success
        return Right(true);
      } else {
        // Beneficiary not found
        return Left(GeneralException(message: 'Error: Beneficiary not found'));
      }
    } catch (e, s) {
      debugPrint('Exception : $e');
      debugPrint('StackTrace : $s');

      // Return failure with exception
      return Left(GeneralException(
        message: 'Error: Failed to update beneficiary',
      ));
    }
  }

  @override
  Future<Either<Exception, bool>> deleteBeneficiary(String id) async {
    try {
      // Retrieve the current list of beneficiaries
      List<String>? beneficiaryStrings =
          preferences.getPreferencesListData(Constant.kBeneficiaries);

      List<Beneficiary> beneficiaries = beneficiaryStrings != null
          ? beneficiaryStrings
              .map((beneficiaryString) =>
                  Beneficiary.fromJson(jsonDecode(beneficiaryString)))
              .toList()
          : [];

      // Remove the beneficiary with the matching id
      beneficiaries.removeWhere((beneficiary) => beneficiary.id == id);

      // Serialize the updated list
      List<String> updatedBeneficiaryStrings = beneficiaries
          .map((beneficiary) => jsonEncode(beneficiary.toJson()))
          .toList();

      // Save the updated list to preferences
      preferences.setPreferencesListData(
          Constant.kBeneficiaries, updatedBeneficiaryStrings);

      // Return success
      return Right(true);
    } catch (e, s) {
      debugPrint('Exception : $e');
      debugPrint('StackTrace : $s');

      // Return failure with exception
      return Left(GeneralException(
        message: 'Error: Failed to delete beneficiary',
      ));
    }
  }
}
