import 'package:dartz/dartz.dart';
import 'package:fh_assignment/core/network/network_info.dart';
import 'package:fh_assignment/features/top-up/data/data_source/top_up_data_source.dart';
import 'package:fh_assignment/features/top-up/domain/repository/top_up_repository.dart';

class TopUpRepositoryImpl extends TopUpRepository {
  final NetworkInfo networkInfo;
  final TopUpDataSource topUpDataSource;

  TopUpRepositoryImpl({
    required this.networkInfo,
    required this.topUpDataSource,
  });

  @override
  Future<Either<Exception, dynamic>> topUp() {
    // TODO: implement topUp
    throw UnimplementedError();
  }
}
