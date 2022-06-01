import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/user_files_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@lazySingleton
class AddUserAvatar extends FutureUseCase<String, AvatarParams> {
  final UserFilesRepository repository;

  AddUserAvatar({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(AvatarParams params) async {
    return repository.addUserAvatar(params);
  }
}
