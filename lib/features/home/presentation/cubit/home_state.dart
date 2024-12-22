part of 'home_cubit.dart';


enum HomeStatus {
  initial,
  loading,
  success,
  failure,
  optionSelection,
  optionSelected,
}

class HomeState extends Equatable {
  final HomeStatus? status;
  final ErrorModel? errorModel;

  final User? user;

  const HomeState({
    this.errorModel,
    this.status,
    this.user,
  });

  HomeState copyWith({
    HomeStatus? status,
    ErrorModel? errorModel,
    User? user,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorModel: errorModel ?? this.errorModel,
      user: user,
    );
  }

  factory HomeState.fromJson(json) {
    return HomeState(
      status: HomeStatus.values[json['status'] ?? 0],
      errorModel: json['errorModel'] != null
          ? ErrorModel.fromJson(json['errorModel'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'status': status,
        'errorModel': errorModel?.toJson(),
        'user': user?.toJson(),
      };

  @override
  List<Object?> get props => [
        errorModel,
        status,
        user,
      ];
}
