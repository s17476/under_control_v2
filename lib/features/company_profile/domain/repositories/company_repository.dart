import 'package:dartz/dartz.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

import '../../../core/error/failures.dart';
import '../entities/company.dart';

abstract class CompanyRepository {
  Future<Either<Failure, VoidResult>> addCompany(Company company);

  Future<Either<Failure, VoidResult>> updateCompany(Company company);

  Future<Either<Failure, List<Company>>> fetchAllCompanies();

  Future<Either<Failure, Company>> getCompanyById(String id);
}
