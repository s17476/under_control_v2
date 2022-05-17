import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

@lazySingleton
class UpdateCompany extends FutureUseCase<VoidResult, Company> {
  final CompanyRepository companyRepository;

  UpdateCompany({
    required this.companyRepository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(Company params) async {
    return companyRepository.updateCompany(params);
  }
}
