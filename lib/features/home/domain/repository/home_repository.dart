import 'package:dartz/dartz.dart';
import 'package:fh_assignment/features/home/data/model/transaction.dart';
import 'package:fh_assignment/features/home/data/model/user.dart';

abstract class HomeRepository {
  Future<Either<Exception, User>> getProfile();
  Future<Either<Exception, List<Transaction>>> getTransactions();
  Future<Either<Exception, Transaction>> addTransaction(Transaction transaction);
}