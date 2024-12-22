import 'package:equatable/equatable.dart';
import 'package:fh_assignment/core/cubit/base_cubit.dart';
import 'package:fh_assignment/core/error/model/error_response_model.dart';
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
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        errorModel: ErrorModel(message: 'Unexpected error occurred'),
      ));
    }
  }

  onAccountVerification(bool isVerify) async {
    emit(state.copyWith(status: HomeStatus.loading,),);
    User user  = User.fromJson(state.user!.toJson());
    user.accountStatus = isVerify;
    emit(state.copyWith(status: HomeStatus.success,
    user: user));
  }
}
