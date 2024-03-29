import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/item_action/item_actions_stream.dart';

abstract class DashboardItemActionRepository {
  ///Gets stream of all actions for choosen locations.
  ///
  ///Returns [ItemActionsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, ItemActionsStream>> getDashboardItemActionsStream(
    ItemsInLocationsParams params,
  );

  ///Gets stream of the last five actions for choosen locations.
  ///
  ///Returns [ItemActionsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, ItemActionsStream>>
      getDashboardLastFiveItemActionsStream(
    ItemsInLocationsParams params,
  );
}
