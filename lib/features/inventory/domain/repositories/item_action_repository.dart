import 'package:dartz/dartz.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

import '../../../core/error/failures.dart';
import '../entities/item_action/item_actions_stream.dart';

abstract class ItemActionRepository {
  ///Gets stream of actions for choosen item.
  ///
  ///Returns [ItemActionsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, ItemActionsStream>> getItemActionsStream(
    ItemParams params,
  );

  ///Adds new action to the DB.
  ///
  ///Returns [String] containing generated by DB item id.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, String>> addItemAction(ItemActionParams params);

  ///Updates action in the DB.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> updateItemAction(ItemActionParams params);

  ///Deletes action from the DB.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> deleteItemAction(ItemActionParams params);

  ///Moves items between locations in the DB.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> moveItemAction(
    MoveItemActionParams params,
  );
}
