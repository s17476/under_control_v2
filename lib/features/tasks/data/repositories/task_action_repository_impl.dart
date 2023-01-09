import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../assets/data/models/asset_action/asset_action_model.dart';
import '../../../assets/data/models/asset_model.dart';
import '../../../assets/utils/asset_status.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../inventory/data/models/item_action/item_action_model.dart';
import '../../../inventory/data/models/item_amount_in_location_model.dart';
import '../../../inventory/data/models/item_model.dart';
import '../../../inventory/domain/entities/item_action/item_action.dart';
import '../../domain/entities/task_action/task_actions_stream.dart';
import '../../domain/repositories/task_action_repository.dart';
import '../models/task/spare_part_item_model.dart';
import '../models/task/task_model.dart';
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

      final assetActionsReference = firebaseFirestore
          .collection('companies')
          .doc(params.userProfile.companyId)
          .collection('assetsActions');

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

      // update connected task
      final taskReference = firebaseFirestore
          .collection('companies')
          .doc(params.userProfile.companyId)
          .collection('tasks')
          .doc(params.task.id);

      final updatedTask = TaskModel.fromTask(params.task).copyWith(
        assetStatus: params.task.assetId.isNotEmpty
            ? params.taskAction.replacedAssetStatus
            : null,
        isInProgress: true,
      );

      final updatedTaskMap = updatedTask.toMap();

      batch.update(taskReference, updatedTaskMap);

      // replace connected asset
      if (updatedTaskAction.replacedAssetLocationId.isNotEmpty) {
        // get connected asset
        final assetsReference = firebaseFirestore
            .collection('companies')
            .doc(params.userProfile.companyId)
            .collection('assets');

        // replaced asset
        final replacedAssetSnapshot =
            await assetsReference.doc(params.task.assetId).get();
        final replacedAsset = AssetModel.fromMap(
          replacedAssetSnapshot.data() as Map<String, dynamic>,
          replacedAssetSnapshot.id,
        );

        final updatedReplacedAsset = replacedAsset.copyWith(
          locationId: updatedTaskAction.replacedAssetLocationId,
          currentStatus: updatedTaskAction.replacedAssetStatus,
        );

        final replacedAssetMap = updatedReplacedAsset.toMap();

        final replacedAssetAction = AssetActionModel(
          id: '',
          assetId: replacedAsset.id,
          dateTime: updatedTaskAction.stopTime,
          userId: params.userProfile.id,
          locationId: updatedReplacedAsset.locationId,
          isAssetInUse: false,
          isCreate: false,
          assetStatus: updatedReplacedAsset.currentStatus,
          connectedTask: updatedTaskAction.taskId,
          connectedWorkRequest: '',
        );
        final replacedAssetActionMap = replacedAssetAction.toMap();

        // get action reference
        final replacedAssetActionReference =
            await assetActionsReference.add({'name': ''});

        // add action
        batch.set(replacedAssetActionReference, replacedAssetActionMap);
        // update replaced asset
        batch.update(
          assetsReference.doc(updatedReplacedAsset.id),
          replacedAssetMap,
        );

        // repplacement asset
        final replacementAssetSnapshot = await assetsReference
            .doc(params.taskAction.replacementAssetId)
            .get();
        final replacementAsset = AssetModel.fromMap(
          replacementAssetSnapshot.data() as Map<String, dynamic>,
          replacementAssetSnapshot.id,
        );

        final updatedReplacementAsset = replacementAsset.copyWith(
          locationId: params.task.locationId,
        );

        final replacementAssetMap = updatedReplacementAsset.toMap();

        final replacementAssetAction = AssetActionModel(
          id: '',
          assetId: replacementAsset.id,
          dateTime: updatedTaskAction.stopTime,
          userId: params.userProfile.id,
          locationId: params.task.locationId,
          isAssetInUse: true,
          isCreate: false,
          assetStatus: updatedReplacementAsset.currentStatus,
          connectedTask: updatedTaskAction.taskId,
          connectedWorkRequest: '',
        );
        final replacementAssetActionMap = replacementAssetAction.toMap();

        // get action reference
        final replacementAssetActionReference =
            await assetActionsReference.add({'name': ''});

        // add action
        batch.set(replacementAssetActionReference, replacementAssetActionMap);
        // update replacement asset
        batch.update(
          assetsReference.doc(updatedReplacementAsset.id),
          replacementAssetMap,
        );
        // update asset status
      } else if (params.task.assetId.isNotEmpty) {
        // get connected asset
        final assetsReference = firebaseFirestore
            .collection('companies')
            .doc(params.userProfile.companyId)
            .collection('assets');

        // replaced asset
        final assetSnapshot =
            await assetsReference.doc(params.task.assetId).get();
        final asset = AssetModel.fromMap(
          assetSnapshot.data() as Map<String, dynamic>,
          assetSnapshot.id,
        );

        final updatedAsset = asset.copyWith(
          currentStatus: params.taskAction.replacedAssetStatus,
        );

        final updatedAssetMap = updatedAsset.toMap();

        final assetAction = AssetActionModel(
          id: '',
          assetId: asset.id,
          dateTime: updatedTaskAction.stopTime,
          userId: params.userProfile.id,
          locationId: updatedAsset.locationId,
          isAssetInUse: updatedAsset.isInUse,
          isCreate: false,
          assetStatus: updatedAsset.currentStatus,
          connectedTask: updatedTaskAction.taskId,
          connectedWorkRequest: '',
        );
        final assetActionMap = assetAction.toMap();

        // get action reference
        final assetActionReference =
            await assetActionsReference.add({'name': ''});

        // add action
        batch.set(assetActionReference, assetActionMap);
        // update replaced asset
        batch.update(
          assetsReference.doc(updatedAsset.id),
          updatedAssetMap,
        );
      }

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
          final actionReference = await assetActionsReference.add({'name': ''});

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
          // item
          final itemReference = firebaseFirestore
              .collection('companies')
              .doc(params.userProfile.companyId)
              .collection('items')
              .doc(addedItem.itemId);

          final itemSnapshot = await itemReference.get();
          final fetchedItem = ItemModel.fromMap(
            itemSnapshot.data() as Map<String, dynamic>,
            itemSnapshot.id,
          );

          final amountInLocation = fetchedItem.amountInLocations.firstWhere(
              (element) => element.locationId == addedItem.locationId);
          final updatedAmountInLocation = ItemAmountInLocationModel(
              amount: amountInLocation.amount - addedItem.quantity,
              locationId: addedItem.locationId);
          final updatedAmountInLocations = [...fetchedItem.amountInLocations]
            ..removeWhere(
                (element) => element.locationId == addedItem.locationId)
            ..add(updatedAmountInLocation);

          final updatedItem = fetchedItem.copyWith(
            amountInLocations: updatedAmountInLocations,
          );

          // update item in DB
          final itemMap = updatedItem.toMap();
          batch.update(itemReference, itemMap);

          // add item action
          final actionsReference = firebaseFirestore
              .collection('companies')
              .doc(params.userProfile.companyId)
              .collection('actions');

          final itemAction = ItemActionModel(
            id: '',
            type: ItemActionType.remove,
            description: 'TASK#${params.task.count}',
            ammount: addedItem.quantity,
            itemUnit: updatedItem.itemUnit,
            locationId: params.task.locationId,
            date: params.taskAction.stopTime,
            itemId: addedItem.itemId,
            userId: params.userProfile.id,
            taskId: params.task.id,
          );

          final actionMap = itemAction.toMap();

          // get action reference
          final actionReference = await actionsReference.add({'name': ''});

          batch.set(actionReference, actionMap);
        }
      }

      batch.commit();

      print('poszło');

      return Right(taskActionReference.id);
    } on FirebaseException catch (e) {
      print('nie poszło');
      return Left(
        DatabaseFailure(message: e.message ?? 'Database Failure'),
      );
    } catch (e) {
      print('nie poszło');
      print(e);
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> deleteTaskAction(
      TaskActionParams params) async {
    try {
      // batch
      final batch = firebaseFirestore.batch();

      // task action reference
      final taskActionReference = firebaseFirestore
          .collection('companies')
          .doc(params.userProfile.companyId)
          .collection('taskActions')
          .doc(params.taskAction.id);

      // delete files
      if (params.taskAction.images.isNotEmpty) {
        // storage reference
        final storageReference = firebaseStorage
            .ref()
            .child(params.userProfile.id)
            .child('taskActions');

        final allFilesInDirectory = await storageReference.listAll();

        final filesForTask = allFilesInDirectory.items.where(
          (file) => file.name.contains(
            params.taskAction.id,
          ),
        );

        for (var file in filesForTask) {
          storageReference.child(file.name).delete();
        }
      }

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
            currentStatus: AssetStatus.ok,
            locationId: params.task.locationId,
          );
          final assetMap = updatedAssetModel.toMap();

          // asset action
          final actionsReference = firebaseFirestore
              .collection('companies')
              .doc(params.userProfile.companyId)
              .collection('assetsActions');

          final assetAction = AssetActionModel(
            id: '',
            assetId: updatedAssetModel.id,
            dateTime: DateTime.now(),
            userId: params.userProfile.id,
            locationId: updatedAssetModel.locationId,
            isAssetInUse: true,
            isCreate: false,
            assetStatus: updatedAssetModel.currentStatus,
            connectedTask: params.task.id,
            connectedWorkRequest: '',
          );
          final actionMap = assetAction.toMap();

          // get action reference
          final actionReference = await actionsReference.add({'name': ''});

          // add action
          batch.set(actionReference, actionMap);
          // update asset
          batch.update(assetReference, assetMap);
        }
      }

      // update added items
      final addedItems = params.taskAction.sparePartsItems;
      if (addedItems.isNotEmpty) {
        for (var addedItem in addedItems) {
          // item
          final itemReference = firebaseFirestore
              .collection('companies')
              .doc(params.userProfile.companyId)
              .collection('items')
              .doc(addedItem.itemId);

          final itemSnapshot = await itemReference.get();
          final fetchedItem = ItemModel.fromMap(
            itemSnapshot.data() as Map<String, dynamic>,
            itemSnapshot.id,
          );

          final amountInLocation = fetchedItem.amountInLocations.firstWhere(
              (element) => element.locationId == addedItem.locationId);
          final updatedAmountInLocation = ItemAmountInLocationModel(
              amount: amountInLocation.amount + addedItem.quantity,
              locationId: addedItem.locationId);
          final updatedAmountInLocations = [...fetchedItem.amountInLocations]
            ..removeWhere(
                (element) => element.locationId == addedItem.locationId)
            ..add(updatedAmountInLocation);

          final updatedItem = fetchedItem.copyWith(
            amountInLocations: updatedAmountInLocations,
          );

          // update item in DB
          final itemMap = updatedItem.toMap();
          batch.update(itemReference, itemMap);

          // add item action
          final actionsReference = firebaseFirestore
              .collection('companies')
              .doc(params.userProfile.companyId)
              .collection('actions');

          final itemAction = ItemActionModel(
            id: '',
            type: ItemActionType.remove,
            description: '',
            ammount: addedItem.quantity,
            itemUnit: updatedItem.itemUnit,
            locationId: addedItem.locationId,
            date: params.taskAction.stopTime,
            itemId: addedItem.itemId,
            userId: params.userProfile.id,
            taskId: params.task.id,
          );

          final actionMap = itemAction.toMap();

          // get action reference
          final actionReference = await actionsReference.add({'name': ''});

          batch.set(actionReference, actionMap);
        }
      }

      // delete task action
      batch.delete(taskActionReference);

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
  Future<Either<Failure, TaskActionsStream>> getLatestTaskActionsStream(
      ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('taskActions')
          .where('locationId', whereIn: params.locations)
          .limit(5)
          .snapshots();

      return Right(TaskActionsStream(allTaskActions: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, TaskActionsStream>> getTaskActionsForTaskStream(
      TaskParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('taskActions')
          .where('taskId', isEqualTo: params.task.id)
          .snapshots();

      return Right(TaskActionsStream(allTaskActions: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

// TODO update replaced/replacement asset
  @override
  Future<Either<Failure, VoidResult>> updateTaskAction(
      TaskActionParams params) async {
    try {
      // batch
      final batch = firebaseFirestore.batch();

      // task action reference
      final taskActionReference = firebaseFirestore
          .collection('companies')
          .doc(params.userProfile.companyId)
          .collection('taskActions')
          .doc(params.taskAction.id);

      final taskActionSnapshot = await taskActionReference.get();
      final oldTaskAction = TaskActionModel.fromMap(
        taskActionSnapshot.data() as Map<String, dynamic>,
        taskActionSnapshot.id,
      );

      // storage reference
      final storageReference = firebaseStorage
          .ref()
          .child(params.userProfile.id)
          .child('taskActions');

      // delete files
      final isImagesListEqual = const DeepCollectionEquality.unordered()
          .equals(params.taskAction.images, oldTaskAction.images);
      if (params.taskAction.images.isNotEmpty && !isImagesListEqual) {
        final allFilesInDirectory = await storageReference.listAll();

        final filesForTask = allFilesInDirectory.items.where(
          (file) => file.name.contains(
            params.taskAction.id,
          ),
        );

        for (var file in filesForTask) {
          storageReference.child(file.name).delete();
        }
      }

      // link to stored images
      List<String> images = [];

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
      List<AssetModel> assetsToReturn = [];
      for (var asset in oldTaskAction.removedPartsAssets) {
        if (!params.taskAction.removedPartsAssets.contains(asset)) {
          assetsToReturn.add(asset);
        }
      }

      for (var asset in assetsToReturn) {
        final assetReference = firebaseFirestore
            .collection('companies')
            .doc(params.userProfile.companyId)
            .collection('assets')
            .doc(asset.id);

        final updatedAssetModel = asset.copyWith(
          currentStatus: AssetStatus.ok,
          locationId: params.task.locationId,
        );
        final assetMap = updatedAssetModel.toMap();

        // asset action
        final actionsReference = firebaseFirestore
            .collection('companies')
            .doc(params.userProfile.companyId)
            .collection('assetsActions');

        final assetAction = AssetActionModel(
          id: '',
          assetId: updatedAssetModel.id,
          dateTime: params.taskAction.stopTime,
          userId: params.userProfile.id,
          locationId: updatedAssetModel.locationId,
          isAssetInUse: true,
          isCreate: false,
          assetStatus: updatedAssetModel.currentStatus,
          connectedTask: params.task.id,
          connectedWorkRequest: '',
        );
        final actionMap = assetAction.toMap();

        // get action reference
        final actionReference = await actionsReference.add({'name': ''});

        // add action
        batch.set(actionReference, actionMap);
        // update asset
        batch.update(assetReference, assetMap);
      }

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
            dateTime: params.taskAction.stopTime,
            userId: params.userProfile.id,
            locationId: updatedAssetModel.locationId,
            isAssetInUse: false,
            isCreate: false,
            assetStatus: updatedAssetModel.currentStatus,
            connectedTask: params.task.id,
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

      // update added assets to return
      List<String> addedAssetsToReturn = [];
      for (var asset in oldTaskAction.addedPartsAssets) {
        if (!params.taskAction.addedPartsAssets.contains(asset)) {
          addedAssetsToReturn.add(asset);
        }
      }

      for (var assetId in addedAssetsToReturn) {
        final assetReference = firebaseFirestore
            .collection('comapnies')
            .doc(params.userProfile.companyId)
            .collection('assets')
            .doc(assetId);

        // fetch asset
        final assetSnapshot = await assetReference.get();
        final fetchedAsset = AssetModel.fromMap(
          assetSnapshot.data() as Map<String, dynamic>,
          assetSnapshot.id,
        );
        // fetch asset last location
        final assetActionQuerySnapshot = await firebaseFirestore
            .collection('comapnies')
            .doc(params.userProfile.companyId)
            .collection('assetsActions')
            .where('connectedTask', isEqualTo: fetchedAsset.id)
            .where('locationId', isNotEqualTo: fetchedAsset.locationId)
            .limit(1)
            .get();

        String locationId = '';
        if (assetActionQuerySnapshot.docs.isNotEmpty) {
          final documentSnapshot =
              assetActionQuerySnapshot.docs[0] as Map<String, dynamic>;
          locationId = documentSnapshot['locationId'] ?? params.task.locationId;
        }

        final updatedAssetModel = fetchedAsset.copyWith(
          locationId: locationId,
        );
        final assetMap = updatedAssetModel.toMap();

        // asset action
        final actionsReference = firebaseFirestore
            .collection('companies')
            .doc(params.userProfile.companyId)
            .collection('assetsActions');

        final assetAction = AssetActionModel(
          id: '',
          assetId: updatedAssetModel.id,
          dateTime: params.taskAction.stopTime,
          userId: params.userProfile.id,
          locationId: locationId,
          isAssetInUse: true,
          isCreate: false,
          assetStatus: updatedAssetModel.currentStatus,
          connectedTask: params.task.id,
          connectedWorkRequest: '',
        );
        final actionMap = assetAction.toMap();

        // get action reference
        final actionReference = await actionsReference.add({'name': ''});

        // add action
        batch.set(actionReference, actionMap);
        // update asset
        batch.update(assetReference, assetMap);
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

      //
      //
      //

      List<SparePartItemModel> itemsToReturn = [];
      List<SparePartItemModel> itemsToUpdate = [];

      for (var item in oldTaskAction.sparePartsItems) {
        if (params.taskAction.sparePartsItems
            .where((element) =>
                element.itemId == item.itemId &&
                element.locationId == item.locationId)
            .toList()
            .isEmpty) {
          itemsToReturn.add(item);
        } else {
          itemsToUpdate.add(item);
        }
      }

      for (var item in itemsToReturn) {
        // item
        final itemReference = firebaseFirestore
            .collection('companies')
            .doc(params.userProfile.companyId)
            .collection('items')
            .doc(item.itemId);

        final itemSnapshot = await itemReference.get();
        final fetchedItem = ItemModel.fromMap(
          itemSnapshot.data() as Map<String, dynamic>,
          itemSnapshot.id,
        );

        final amountInLocation = fetchedItem.amountInLocations
            .firstWhere((element) => element.locationId == item.locationId);
        final updatedAmountInLocation = ItemAmountInLocationModel(
          amount: amountInLocation.amount + item.quantity,
          locationId: item.locationId,
        );
        final updatedAmountInLocations = [...fetchedItem.amountInLocations]
          ..removeWhere((element) => element.locationId == item.locationId)
          ..add(updatedAmountInLocation);

        final updatedItem = fetchedItem.copyWith(
          amountInLocations: updatedAmountInLocations,
        );

        // update item in DB
        final itemMap = updatedItem.toMap();
        batch.update(itemReference, itemMap);

        // add item action
        final actionsReference = firebaseFirestore
            .collection('companies')
            .doc(params.userProfile.companyId)
            .collection('actions');

        final itemAction = ItemActionModel(
          id: '',
          type: ItemActionType.add,
          description: '',
          ammount: item.quantity,
          itemUnit: updatedItem.itemUnit,
          locationId: item.locationId,
          date: params.taskAction.stopTime,
          itemId: item.itemId,
          userId: params.userProfile.id,
          taskId: params.task.id,
        );

        final actionMap = itemAction.toMap();

        // get action reference
        final actionReference = await actionsReference.add({'name': ''});

        batch.set(actionReference, actionMap);
      }

      for (var item in itemsToUpdate) {
        // item
        final itemReference = firebaseFirestore
            .collection('companies')
            .doc(params.userProfile.companyId)
            .collection('items')
            .doc(item.itemId);

        final itemSnapshot = await itemReference.get();
        final fetchedItem = ItemModel.fromMap(
          itemSnapshot.data() as Map<String, dynamic>,
          itemSnapshot.id,
        );

        final newQuantity = params.taskAction.sparePartsItems
            .firstWhere((element) =>
                element.itemId == item.itemId &&
                element.locationId == item.locationId)
            .quantity;

        final quantityDifference = newQuantity - item.quantity;

        if (quantityDifference != 0) {
          final amountInLocation = fetchedItem.amountInLocations
              .firstWhere((element) => element.locationId == item.locationId);
          final updatedAmountInLocation = ItemAmountInLocationModel(
            amount: amountInLocation.amount + quantityDifference,
            locationId: item.locationId,
          );
          final updatedAmountInLocations = [...fetchedItem.amountInLocations]
            ..removeWhere((element) => element.locationId == item.locationId)
            ..add(updatedAmountInLocation);

          final updatedItem = fetchedItem.copyWith(
            amountInLocations: updatedAmountInLocations,
          );

          // update item in DB
          final itemMap = updatedItem.toMap();
          batch.update(itemReference, itemMap);

          // add item action
          final actionsReference = firebaseFirestore
              .collection('companies')
              .doc(params.userProfile.companyId)
              .collection('actions');

          final itemAction = ItemActionModel(
            id: '',
            type: quantityDifference > 0
                ? ItemActionType.add
                : ItemActionType.remove,
            description: '',
            ammount: item.quantity,
            itemUnit: updatedItem.itemUnit,
            locationId: item.locationId,
            date: params.taskAction.stopTime,
            itemId: item.itemId,
            userId: params.userProfile.id,
            taskId: params.task.id,
          );

          final actionMap = itemAction.toMap();

          // get action reference
          final actionReference = await actionsReference.add({'name': ''});

          batch.set(actionReference, actionMap);
        }
      }

      // add new items
      List<SparePartItemModel> itemsToAdd = [];
      for (var item in params.taskAction.sparePartsItems) {
        if (oldTaskAction.sparePartsItems
            .where((element) =>
                element.itemId == item.itemId &&
                element.locationId == item.locationId)
            .toList()
            .isEmpty) {
          itemsToAdd.add(item);
        }
      }

      for (var addedItem in itemsToAdd) {
        // item
        final itemReference = firebaseFirestore
            .collection('companies')
            .doc(params.userProfile.companyId)
            .collection('items')
            .doc(addedItem.itemId);

        final itemSnapshot = await itemReference.get();
        final fetchedItem = ItemModel.fromMap(
          itemSnapshot.data() as Map<String, dynamic>,
          itemSnapshot.id,
        );

        final amountInLocation = fetchedItem.amountInLocations.firstWhere(
            (element) => element.locationId == addedItem.locationId);
        final updatedAmountInLocation = ItemAmountInLocationModel(
            amount: amountInLocation.amount - addedItem.quantity,
            locationId: addedItem.locationId);
        final updatedAmountInLocations = [...fetchedItem.amountInLocations]
          ..removeWhere((element) => element.locationId == addedItem.locationId)
          ..add(updatedAmountInLocation);

        final updatedItem = fetchedItem.copyWith(
          amountInLocations: updatedAmountInLocations,
        );

        // update item in DB
        final itemMap = updatedItem.toMap();
        batch.update(itemReference, itemMap);

        // add item action
        final actionsReference = firebaseFirestore
            .collection('companies')
            .doc(params.userProfile.companyId)
            .collection('actions');

        final itemAction = ItemActionModel(
          id: '',
          type: ItemActionType.remove,
          description: '',
          ammount: addedItem.quantity,
          itemUnit: updatedItem.itemUnit,
          locationId: addedItem.locationId,
          date: params.taskAction.stopTime,
          itemId: addedItem.itemId,
          userId: params.userProfile.id,
          taskId: params.task.id,
        );

        final actionMap = itemAction.toMap();

        // get action reference
        final actionReference = await actionsReference.add({'name': ''});

        batch.set(actionReference, actionMap);
      }

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
