import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/asset_action/asset_actions_stream.dart';

abstract class DashboardAssetActionRepository {
  ///Gets stream of all actions for choosen locations.
  ///
  ///Returns [AssetActionsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, AssetActionsStream>> getDashboardAssetActionsStream(
    ItemsInLocationsParams params,
  );

  ///Gets stream of the last five actions for choosen locations.
  ///
  ///Returns [AssetActionsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, AssetActionsStream>>
      getDashboardLastFiveAssetActionsStream(
    ItemsInLocationsParams params,
  );
}
