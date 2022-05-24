import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/companies.dart';
import '../repositories/company_management_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@lazySingleton
class FetchAllCompanies extends FutureUseCase<Companies, NoParams> {
  final CompanyManagementRepository companyManagementRepository;

  FetchAllCompanies({
    required this.companyManagementRepository,
  });

  @override
  Future<Either<Failure, Companies>> call(NoParams params) async {
    return companyManagementRepository.fetchAllCompanies();
  }
}
