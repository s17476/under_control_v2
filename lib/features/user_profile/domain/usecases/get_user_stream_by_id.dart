import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/user_stream.dart';
import '../repositories/user_profile_repository.dart';

@lazySingleton
class GetUserStreamById extends FutureUseCase<UserStream, String> {
  final UserProfileRepository userRepository;
  GetUserStreamById({
    required this.userRepository,
  });

  @override
  Future<Either<Failure, UserStream>> call(String params) async =>
      userRepository.getUserStreamById(params);
}
