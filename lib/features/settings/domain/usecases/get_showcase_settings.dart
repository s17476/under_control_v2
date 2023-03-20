import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/showcase_settings.dart';
import '../repositories/showcase_settings_repository.dart';

@lazySingleton
class GetShowcaseSettings
    extends FutureUseCase<ShowcaseSettings, UserProfileParams> {
  final ShowcaseSettingsRepository repository;

  GetShowcaseSettings({
    required this.repository,
  });

  @override
  Future<Either<Failure, ShowcaseSettings>> call(
    UserProfileParams params,
  ) async =>
      repository.getShowcaseSettings(params);
}
