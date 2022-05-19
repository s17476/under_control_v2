import 'package:dartz/dartz.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/companies.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

import '../../../core/error/failures.dart';
import '../entities/company.dart';

abstract class CompanyRepository {
  Future<Either<Failure, String>> addCompany(Company company);

  Future<Either<Failure, VoidResult>> updateCompany(Company company);

  Future<Either<Failure, Companies>> fetchAllCompanies();

  Future<Either<Failure, Company>> getCompanyById(String id);
}
