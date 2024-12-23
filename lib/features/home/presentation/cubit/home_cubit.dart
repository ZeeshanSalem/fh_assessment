import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fh_assignment/core/cubit/base_cubit.dart';
import 'package:fh_assignment/core/error/model/error_response_model.dart';
import 'package:fh_assignment/core/utils/constants.dart';
import 'package:fh_assignment/core/utils/enums.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';
import 'package:fh_assignment/features/home/data/model/user.dart';
import 'package:fh_assignment/features/home/domain/repository/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit({required this.homeRepository})
      : super(
          HomeState(
            status: HomeStatus.initial,
          ),
        ) {
    getMyProfile();
  }

  /// Get My Profile
  Future<void> getMyProfile() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final result = await homeRepository.getProfile();
      result.fold(
        (exception) {
          emit(state.copyWith(
            status: HomeStatus.failure,
            errorModel: handleException(exception),
          ));
        },
        (user) {
          emit(state.copyWith(
            status: HomeStatus.success,
            user: user,
          ));
        },
      );
    } catch (e, stackTrace) {
      logger.e('$e', stackTrace);
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorModel: ErrorModel(message: 'Unexpected error occurred'),
      ));
    }
  }

  onAccountVerification(bool isVerify) async {
    try {
      emit(
        state.copyWith(
          status: HomeStatus.loading,
        ),
      );
      User user = User.fromJson(state.user!.toJson());
      user.accountStatus = isVerify;
      preferences.setPreferencesData(
          Constant.kProfile, jsonEncode(user.toJson()));

      emit(state.copyWith(status: HomeStatus.success, user: user));
    } catch (e, stackTrace) {
      logger.e('$e', stackTrace);
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorModel: ErrorModel(message: 'Unexpected error occurred'),
      ));
    }
  }

  /*
  * When Transaction is successfully added we checked is it recharge our account.
  *  if yes we will update over balance here.
  * */
  Future<void> updateMyBalance(Transaction? transaction) async {
    try {
      emit(
        state.copyWith(
          status: HomeStatus.loading,
        ),
      );

      User user = User.fromJson(state.user!.toJson());
      num balance = user.totalBalance ?? 0;
      num chargedAmount = num.tryParse('${transaction?.amount}') ?? 0;

      print(" state.user?.id${state.user?.id} == transaction?.id${transaction?.accountNumber}");

      // here it's mean we add credit in our own account.
      if (state.user?.id == transaction?.accountNumber &&
          transaction?.type == TransactionType.credit) {

        num totalBalance = balance + chargedAmount;
        user.totalBalance = totalBalance;
      }

      // it's mean this transaction happened on topUp screen for beneficiary.
      // Here will also do deduction of transaction fee
      if (state.user?.id != transaction?.accountNumber &&
          transaction?.type == TransactionType.debt) {
        num totalBalance = balance - (chargedAmount + Constant.transactionFee);
        user.totalBalance = totalBalance;
      }

      preferences.setPreferencesData(
          Constant.kProfile, jsonEncode(user.toJson()));
      emit(state.copyWith(status: HomeStatus.success, user: user));
    } catch (e, stackTrace) {
      logger.e('$e', stackTrace);
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorModel: ErrorModel(message: 'Unexpected error occurred'),
      ));
    }
  }
}
