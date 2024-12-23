import 'package:dartz/dartz.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';

abstract class TopUpRepository {
  Future<Either<Exception, Transaction>> topUp(Transaction transaction);
}
