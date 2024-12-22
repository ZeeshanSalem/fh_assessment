import 'package:dartz/dartz.dart';
import 'package:fh_assignment/features/home/data/model/user.dart';

abstract class HomeRepository {
  Future<Either<Exception, User>> getProfile();
}