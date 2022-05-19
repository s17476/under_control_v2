import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/companies.dart';

import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

@lazySingleton
class FetchAllCompanies extends FutureUseCase<Companies, NoParams> {
  final CompanyRepository companyRepository;

  FetchAllCompanies({
    required this.companyRepository,
  });

  @override
  Future<Either<Failure, Companies>> call(NoParams params) async {
    return companyRepository.fetchAllCompanies();
  }
}
