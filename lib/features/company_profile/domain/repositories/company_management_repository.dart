import 'package:dartz/dartz.dart';

import '../../../core/usecases/usecase.dart';
import '../entities/companies.dart';
import '../../../core/error/failures.dart';
import '../entities/company.dart';

abstract class CompanyManagementRepository {
  Future<Either<Failure, String>> addCompany(Company company);

  Future<Either<Failure, String>> addCompanyLogo(AvatarParams params);

  Future<Either<Failure, Companies>> fetchAllCompanies();
}
