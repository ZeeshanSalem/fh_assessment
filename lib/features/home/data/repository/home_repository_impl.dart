import 'package:dartz/dartz.dart';
import 'package:fh_assignment/core/error/exception.dart';
import 'package:fh_assignment/core/network/network_info.dart';
import 'package:fh_assignment/features/home/data/data_source/home_local_data_source.dart';
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
    if (networkInfo.isConnected) {
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
    } else {
      return Left(NoInternetException(
        message: "No internet connection",
      ));
    }
  }
}
