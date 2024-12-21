import 'package:dartz/dartz.dart';

abstract class TopUpRepository {
   Future<Either<Exception, dynamic>> topUp();
 }