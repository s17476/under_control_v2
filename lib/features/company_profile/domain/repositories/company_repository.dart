import 'package:dartz/dartz.dart';

import '../entities/company_users.dart';
import '../../../core/usecases/usecase.dart';
import '../../../core/error/failures.dart';
import '../entities/company.dart';

abstract class CompanyRepository {
  Future<Either<Failure, VoidResult>> updateCompany(Company company);

  Future<Either<Failure, Company>> getCompanyById(String id);

  Future<Either<Failure, CompanyUsers>> fetchAllCompanyUsers(String id);
}
