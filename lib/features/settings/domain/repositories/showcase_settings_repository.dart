import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/showcase_settings.dart';

abstract class ShowcaseSettingsRepository {
  ///Gets showcase settings.
  ///
  ///Returns [ShowcaseSettings] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, ShowcaseSettings>> getShowcaseSettings(
    UserProfileParams params,
  );

  ///Updates showcase settings is DB.
  ///
  ///Returns [Voidresult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> updateShowcaseSettings(
    ShowcaseSettingsParams params,
  );
}
