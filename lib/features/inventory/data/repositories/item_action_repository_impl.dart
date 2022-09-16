import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/item_action/item_actions_stream.dart';
import '../../domain/repositories/item_action_repository.dart';
import '../models/item_action/item_action_model.dart';
import '../models/item_model.dart';

@LazySingleton(as: ItemActionRepository)
class ItemActionRepositoryImpl extends ItemActionRepository {
  final FirebaseFirestore firebaseFirestore;

  ItemActionRepositoryImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, String>> addItemAction(ItemActionParams params) async {
    try {
      // item
      final itemReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('items')
          .doc(params.updatedItem.id);
      final itemMap = (params.updatedItem as ItemModel).toMap();

      // action
      final actionsReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('actions');
      final actionMap = (params.itemAction as ItemActionModel).toMap();

      // get action reference
      final actionReference = await actionsReference.add({'name': ''});

      // batch
      final batch = firebaseFirestore.batch();

      // add action
      batch.set(actionsReference.doc(actionReference.id), actionMap);
      // update item
      batch.update(itemReference, itemMap);

      // commit the batch
      batch.commit();

      return Right(actionReference.id);
    } on FirebaseException catch (e) {
      return Left(
        DatabaseFailure(message: e.message ?? 'Database Failure'),
      );
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> deleteItemAction(
      ItemActionParams params) async {
    try {
      // item
      final itemReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('items')
          .doc(params.updatedItem.id);
      final itemMap = (params.updatedItem as ItemModel).toMap();

      // action
      final actionReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('actions')
          .doc(params.itemAction.id);

      // batch
      final batch = firebaseFirestore.batch();

      // delete action
      batch.delete(actionReference);

      // update item
      batch.update(itemReference, itemMap);

      // commit the batch
      batch.commit();

      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(
        DatabaseFailure(message: e.message ?? 'Database Failure'),
      );
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, ItemActionsStream>> getItemActionsStream(
      ItemParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('actions')
          .where('itemId', isEqualTo: params.item.id)
          .orderBy('date', descending: true)
          .snapshots();

      return Right(ItemActionsStream(allItemActions: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateItemAction(
      ItemActionParams params) async {
    try {
      // item
      final itemReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('items')
          .doc(params.updatedItem.id);
      final itemMap = (params.updatedItem as ItemModel).toMap();

      // action
      final actionReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('actions')
          .doc(params.itemAction.id);
      final actionMap = (params.itemAction as ItemActionModel).toMap();

      // batch
      final batch = firebaseFirestore.batch();

      // update item
      batch.update(itemReference, itemMap);

      // add action
      batch.update(actionReference, actionMap);

      // commit the batch
      batch.commit();

      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(
        DatabaseFailure(message: e.message ?? 'Database Failure'),
      );
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> moveItemAction(
      MoveItemActionParams params) async {
    try {
      // item
      final itemReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('items')
          .doc(params.updatedItem.id);
      final itemMap = (params.updatedItem as ItemModel).toMap();

      // action
      final actionsReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('actions');

      final moveFromActionMap =
          (params.moveFromItemAction as ItemActionModel).toMap();
      final moveToActionMap =
          (params.moveToItemAction as ItemActionModel).toMap();

      // get action reference
      final moveFromActionReference = await actionsReference.add({'name': ''});
      final moveToActionReference = await actionsReference.add({'name': ''});

      // batch
      final batch = firebaseFirestore.batch();

      // add actions
      batch.set(
          actionsReference.doc(moveFromActionReference.id), moveFromActionMap);
      batch.set(
          actionsReference.doc(moveToActionReference.id), moveToActionMap);
      // update item
      batch.update(itemReference, itemMap);

      // commit the batch
      batch.commit();

      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(
        DatabaseFailure(message: e.message ?? 'Database Failure'),
      );
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, ItemActionsStream>> getLastFiveItemActionsStream(
      ItemParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('actions')
          .where('itemId', isEqualTo: params.item.id)
          .orderBy('date', descending: true)
          .limit(5)
          .snapshots();

      return Right(ItemActionsStream(allItemActions: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }
}
