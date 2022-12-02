import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_action/task_actions_stream.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/error/failures.dart';

import '../../../assets/data/models/asset_action/asset_action_model.dart';
import '../../../assets/data/models/asset_model.dart';
import '../../domain/repositories/task_action_repository.dart';
import '../models/task_action/task_action_model.dart';

@LazySingleton(as: TaskActionRepository)
class TaskActionRepositoryImpl extends TaskActionRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  TaskActionRepositoryImpl({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
  Future<Either<Failure, String>> addTaskAction(TaskActionParams params) async {
    try {
      final taskActionsReference = firebaseFirestore
          .collection('companies')
          .doc(params.userProfile.companyId)
          .collection('taskActions');

      // start batch
      final batch = firebaseFirestore.batch();

      // link to stored images
      List<String> images = [];

      // storage reference
      final storageReference = firebaseStorage
          .ref()
          .child(params.userProfile.companyId)
          .child('taskActions');

      // get task action reference
      final taskActionReference = await taskActionsReference.add({'name': ''});

      // save images
      if (params.images != null && params.images!.isNotEmpty) {
        for (var image in params.images!) {
          final fileName =
              '${taskActionReference.id}-${DateTime.now().toIso8601String()}.jpg';

          final fileReference = storageReference.child(fileName);
          await fileReference.putFile(image);
          final imageUrl = await fileReference.getDownloadURL();
          images.add(imageUrl);
        }
      }

      // update task action
      final updatedTaskAction =
          TaskActionModel.fromTaskAction(params.taskAction).copyWith(
        images: images,
      );

      final taskActionMap = updatedTaskAction.toMap();

      batch.set(taskActionReference, taskActionMap);

      // update replaced assets
      final replacedAssets = params.taskAction.removedPartsAssets;
      if (replacedAssets.isNotEmpty) {
        for (var asset in replacedAssets) {
          final assetReference = firebaseFirestore
              .collection('companies')
              .doc(params.userProfile.companyId)
              .collection('assets')
              .doc(asset.id);

          final assetSnapshot = await assetReference.get();
          final fetchedAsset = AssetModel.fromMap(
            assetSnapshot.data() as Map<String, dynamic>,
            assetSnapshot.id,
          );
          final updatedAssetModel = fetchedAsset.copyWith(
            currentStatus: asset.currentStatus,
            locationId: asset.locationId,
          );
          final assetMap = updatedAssetModel.toMap();

          // action
          final actionsReference = firebaseFirestore
              .collection('companies')
              .doc(params.userProfile.companyId)
              .collection('assetsActions');

          final assetAction = AssetActionModel(
            id: '',
            assetId: updatedAssetModel.id,
            dateTime: updatedTaskAction.stopTime,
            userId: params.userProfile.id,
            locationId: updatedAssetModel.locationId,
            isAssetInUse: false,
            isCreate: false,
            assetStatus: updatedAssetModel.currentStatus,
            connectedTask: updatedTaskAction.taskId,
            connectedWorkRequest: '',
          );
          final actionMap = assetAction.toMap();

          // get action reference
          final actionReference = await actionsReference.add({'name': ''});

          // add action
          batch.set(actionReference, actionMap);
          // update item
          batch.update(assetReference, assetMap);
        }
      }

      // update added assets
      final addedAssetsIds = params.taskAction.addedPartsAssets;
      if (addedAssetsIds.isNotEmpty) {
        for (var addedAssetId in addedAssetsIds) {
          final assetReference = firebaseFirestore
              .collection('companies')
              .doc(params.userProfile.companyId)
              .collection('assets')
              .doc(addedAssetId);

          final assetSnapshot = await assetReference.get();
          final fetchedAsset = AssetModel.fromMap(
            assetSnapshot.data() as Map<String, dynamic>,
            assetSnapshot.id,
          );

          final updatedAssetModel = fetchedAsset.copyWith(
            locationId: params.task.locationId,
            isInUse: true,
          );
          final assetMap = updatedAssetModel.toMap();

          // action
          final actionsReference = firebaseFirestore
              .collection('companies')
              .doc(params.userProfile.companyId)
              .collection('assetsActions');

          final assetAction = AssetActionModel(
            id: '',
            assetId: updatedAssetModel.id,
            dateTime: updatedTaskAction.stopTime,
            userId: params.userProfile.id,
            locationId: updatedAssetModel.locationId,
            isAssetInUse: true,
            isCreate: false,
            assetStatus: updatedAssetModel.currentStatus,
            connectedTask: updatedTaskAction.taskId,
            connectedWorkRequest: '',
          );
          final actionMap = assetAction.toMap();

          // get action reference
          final actionReference = await actionsReference.add({'name': ''});

          // add action
          batch.set(actionReference, actionMap);
          // update item
          batch.update(assetReference, assetMap);
        }
      }

      // update added items
      final addedItems = params.taskAction.sparePartsItems;
      if (addedItems.isNotEmpty) {
        for (var addedItem in addedItems) {
          //
          //
          //
        }
      }

      batch.commit();

      return Right(taskActionReference.id);
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
  Future<Either<Failure, VoidResult>> deleteTaskAction(
      TaskActionParams params) {
    // TODO: implement deleteTaskAction
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TaskActionsStream>> getLatestTaskActionsStream(
      NoParams params) {
    // TODO: implement getLatestTaskActionsStream
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TaskActionsStream>> getTaskActionsForTaskStream(
      TaskParams params) {
    // TODO: implement getTaskActionsForTaskStream
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, VoidResult>> updateTaskAction(
      TaskActionParams params) {
    // TODO: implement updateTaskAction
    throw UnimplementedError();
  }
}
