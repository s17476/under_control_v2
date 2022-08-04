import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/company_management_repository.dart';

@lazySingleton
class AddCompanyLogo extends FutureUseCase<String, AvatarParams> {
  final CompanyManagementRepository repository;

  AddCompanyLogo({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(AvatarParams params) async {
    return repository.addCompanyLogo(params);
  }
}
