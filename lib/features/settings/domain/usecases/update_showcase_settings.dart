import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/showcase_settings_repository.dart';

@lazySingleton
class UpdateShowcaseSettings
    extends FutureUseCase<VoidResult, ShowcaseSettingsParams> {
  final ShowcaseSettingsRepository repository;

  UpdateShowcaseSettings({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(
    ShowcaseSettingsParams params,
  ) async =>
      repository.updateShowcaseSettings(params);
}
