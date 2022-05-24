import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

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
