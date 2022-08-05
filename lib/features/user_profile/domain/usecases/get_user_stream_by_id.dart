import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/error/failures.dart';

import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_stream.dart';
import 'package:under_control_v2/features/user_profile/domain/repositories/user_profile_repository.dart';

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
