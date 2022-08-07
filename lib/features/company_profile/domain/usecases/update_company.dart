import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/company.dart';
import '../repositories/company_management_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@lazySingleton
class UpdateCompany extends FutureUseCase<VoidResult, Company> {
  final CompanyManagementRepository companyRepository;

  UpdateCompany({
    required this.companyRepository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(Company params) async {
    return companyRepository.updateCompanyData(params);
  }
}
