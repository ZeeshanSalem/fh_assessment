import 'package:dartz/dartz.dart';
import 'package:fh_assignment/features/top-up/data/models/beneficiary.dart';

abstract class BeneficiaryRepository {
  Future<Either<Exception, List<Beneficiary>>> getBeneficiaries() ;
  Future<Either<Exception, bool>> addBeneficiary(Beneficiary beneficiary) ;
  Future<Either<Exception, bool>> updateBeneficiary(Beneficiary beneficiary) ;
  Future<Either<Exception, bool>> deleteBeneficiary(String id) ;
}