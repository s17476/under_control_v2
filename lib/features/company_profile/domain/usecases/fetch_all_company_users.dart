import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/company_users.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/company_repository.dart';

@lazySingleton
class FetchAllCompanyUsers extends FutureUseCase<CompanyUsers, String> {
  final CompanyRepository companyRepository;

  FetchAllCompanyUsers({
    required this.companyRepository,
  });

  @override
  Future<Either<Failure, CompanyUsers>> call(String params) async {
    return companyRepository.fetchAllCompanyUsers(params);
  }
}
