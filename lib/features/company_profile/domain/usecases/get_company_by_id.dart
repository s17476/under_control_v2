import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../entities/company.dart';
import '../repositories/company_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@lazySingleton
class GetCompanyById extends FutureUseCase<Company, String> {
  final CompanyRepository companyRepository;

  GetCompanyById({
    required this.companyRepository,
  });

  @override
  Future<Either<Failure, Company>> call(String params) async {
    return companyRepository.getCompanyById(params);
  }
}
