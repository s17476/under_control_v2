import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/company.dart';
import '../repositories/company_management_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@lazySingleton
class AddCompany extends FutureUseCase<String, Company> {
  final CompanyManagementRepository companyManagementRepository;

  AddCompany({
    required this.companyManagementRepository,
  });

  @override
  Future<Either<Failure, String>> call(Company params) async {
    return companyManagementRepository.addCompany(params);
  }
}
