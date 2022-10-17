import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/asset_action/asset_actions_stream.dart';
import '../../domain/repositories/asset_action_repository.dart';
import '../models/asset_action/asset_action_model.dart';
import '../models/asset_model.dart';

@LazySingleton(as: AssetActionRepository)
class AssetActionRepositoryImpl extends AssetActionRepository {
  final FirebaseFirestore firebaseFirestore;

  AssetActionRepositoryImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, String>> addAssetAction(
      AssetActionParams params) async {
    try {
      // asset
      final assetReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assets')
          .doc(params.updatedAsset.id);
      final assetMap = (params.updatedAsset as AssetModel).toMap();

      // action
      final actionsReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assetsActions');
      final actionMap = (params.assetAction as AssetActionModel).toMap();

      // get action reference
      final actionReference = await actionsReference.add({'name': ''});

      // batch
      final batch = firebaseFirestore.batch();

      // add action
      batch.set(actionsReference.doc(actionReference.id), actionMap);
      // update item
      batch.update(assetReference, assetMap);

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
  Future<Either<Failure, VoidResult>> deleteAssetAction(
      AssetActionParams params) async {
    try {
      // asset
      final assetReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assets')
          .doc(params.updatedAsset.id);
      final assetMap = (params.updatedAsset as AssetModel).toMap();

      // action
      final actionReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assetsActions')
          .doc(params.assetAction.id);

      // batch
      final batch = firebaseFirestore.batch();

      // delete action
      batch.delete(actionReference);

      // update item
      batch.update(assetReference, assetMap);

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
  Future<Either<Failure, AssetActionsStream>> getAssetActionsStream(
      AssetParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assetsActions')
          .where('assetId', isEqualTo: params.asset.id)
          .orderBy('date', descending: true)
          .snapshots();

      return Right(AssetActionsStream(allAssetActions: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, AssetActionsStream>> getLastFiveAssetActionsStream(
      AssetParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assetsActions')
          .where('assetId', isEqualTo: params.asset.id)
          .orderBy('date', descending: true)
          .limit(5)
          .snapshots();

      return Right(AssetActionsStream(allAssetActions: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateAssetAction(
      AssetActionParams params) async {
    try {
      // item
      final assetReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assets')
          .doc(params.updatedAsset.id);
      final itemMap = (params.updatedAsset as AssetModel).toMap();

      // action
      final actionReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assetsActions')
          .doc(params.assetAction.id);
      final actionMap = (params.assetAction as AssetActionModel).toMap();

      // batch
      final batch = firebaseFirestore.batch();

      // update item
      batch.update(assetReference, itemMap);

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
}
