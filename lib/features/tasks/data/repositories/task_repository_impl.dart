import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/assets/utils/get_next_date.dart';

import '../../../assets/data/models/asset_action/asset_action_model.dart';
import '../../../assets/data/models/asset_model.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/task/tasks_stream.dart';
import '../../domain/repositories/task_repository.dart';
import '../models/task/task_model.dart';
import '../models/work_request/work_request_model.dart';

@LazySingleton(as: TaskRepository)
class TaskRepositoryImpl extends TaskRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  TaskRepositoryImpl({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
  Future<Either<Failure, String>> addTask(TaskParams params) async {
    try {
      final tasksReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('tasks');

      // batch
      final batch = firebaseFirestore.batch();

      // link to stored images
      List<String> images = [];
      String videoUrl = '';

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('tasks');

      // get task reference
      final taskReference = await tasksReference.add({'name': ''});

      // save images
      if (params.images != null && params.images!.isNotEmpty) {
        for (var image in params.images!) {
          final fileName =
              '${taskReference.id}-${DateTime.now().toIso8601String()}.jpg';

          final fileReference = storageReference.child(fileName);
          await fileReference.putFile(image);
          final imageUrl = await fileReference.getDownloadURL();
          images.add(imageUrl);
        }
      }

      if (params.video != null) {
        final fileName =
            '${taskReference.id}-${DateTime.now().toIso8601String()}.mp4';

        final fileReference = storageReference.child(fileName);
        await fileReference.putFile(params.video!);
        videoUrl = await fileReference.getDownloadURL();
      }

      // increment counter
      int counterValue = 0;
      final companyReference =
          firebaseFirestore.collection('companies').doc(params.companyId);

      await firebaseFirestore.runTransaction((transaction) async {
        final companySnapshot = await transaction.get(companyReference);

        if (!companySnapshot.exists) {
          throw Exception("Comapny does not exist!");
        }

        counterValue = companySnapshot.data()!['tasksCounter'] ?? 0;
        counterValue++;

        transaction.update(companyReference, {'tasksCounter': counterValue});
      });

      // update task
      final updatedtask = TaskModel.fromTask(params.task).copyWith(
        images: images,
        video: videoUrl,
        count: counterValue,
      );

      final taskMap = updatedtask.toMap();

      batch.set(taskReference, taskMap);

      //
      //
      if (params.task.assetId.isNotEmpty) {
        // asset
        final assetReference = firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('assets')
            .doc(params.task.assetId);

        final assetSnapshot = await assetReference.get();
        final asset = AssetModel.fromMap(
          assetSnapshot.data() as Map<String, dynamic>,
          assetSnapshot.id,
        );
        final updatedModel = asset.copyWith(
          currentStatus: params.task.assetStatus,
        );
        final assetMap = updatedModel.toMap();

        // action
        final actionsReference = firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('assetsActions');

        final assetAction = AssetActionModel(
          id: '',
          assetId: params.task.assetId,
          dateTime: params.task.date,
          userId: params.task.userId,
          locationId: params.task.locationId,
          isAssetInUse: asset.isInUse,
          isCreate: false,
          assetStatus: params.task.assetStatus,
          connectedTask: taskReference.id,
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

      // if task is converted from work request
      if (params.task.workOrderId.isNotEmpty) {
        final workRequestReference = firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('workRequests')
            .doc(params.task.workOrderId);

        final workRequestInArchiveReference = firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('workRequestsArchive')
            .doc(params.task.workOrderId);

        //
        WorkRequestModel workRequestModel;
        final workRequestSnapshot = await workRequestReference.get();
        if (workRequestSnapshot.exists) {
          workRequestModel = WorkRequestModel.fromMap(
            workRequestSnapshot.data() as Map<String, dynamic>,
            workRequestSnapshot.id,
          );
        } else {
          throw Exception('Work request not found');
        }

        // update work Request
        final updatedWorkRequest = workRequestModel.copyWith(
          taskId: taskReference.id,
        );

        final workRequestMap = updatedWorkRequest.toMap();

        batch.set(
          workRequestInArchiveReference,
          workRequestMap,
        );

        batch.delete(workRequestReference);
      }

      //
      //

      batch.commit();

      return Right(taskReference.id);
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
  Future<Either<Failure, VoidResult>> deleteTask(TaskParams params) async {
    try {
      final taskReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('tasks')
          .doc(params.task.id);

      // batch
      final batch = firebaseFirestore.batch();

      if (params.task.images.isNotEmpty || params.task.video.isNotEmpty) {
        // storage reference
        final storageReference =
            firebaseStorage.ref().child(params.companyId).child('tasks');

        final allFilesInDirectory = await storageReference.listAll();

        final filesForTask = allFilesInDirectory.items.where(
          (file) => file.name.contains(
            params.task.id,
          ),
        );

        for (var file in filesForTask) {
          storageReference.child(file.name).delete();
        }
      }

      // deletes item
      batch.delete(taskReference);

      // commit batch
      batch.commit();

      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, TasksStream>> getTasksStream(
      ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('tasks')
          .where('locationId', whereIn: params.locations)
          .snapshots();

      return Right(TasksStream(allTasks: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, TasksStream>> getArchiveTasksStream(
      ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('tasksArchive')
          .where('locationId', whereIn: params.locations)
          .snapshots();

      return Right(TasksStream(allTasks: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateTask(TaskParams params) async {
    try {
      final taskReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('tasks')
          .doc(params.task.id);

      // link to stored images
      List<String> images = [];
      List<String> filesNames = [];
      String videoUrl = '';

      // batch
      final batch = firebaseFirestore.batch();

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('tasks');

      // save images
      if (params.images != null && params.images!.isNotEmpty) {
        for (var image in params.images!) {
          final fileName =
              '${params.task.id}-${DateTime.now().toIso8601String()}.pdf';

          final fileReference = storageReference.child(fileName);
          await fileReference.putFile(image);
          final imageUrl = await fileReference.getDownloadURL();
          images.add(imageUrl);
          filesNames.add(fileName);
        }
      }

      if (params.video != null) {
        final fileName =
            '${params.task.id}-${DateTime.now().toIso8601String()}.pdf';

        final fileReference = storageReference.child(fileName);
        await fileReference.putFile(params.video!);
        videoUrl = await fileReference.getDownloadURL();
        filesNames.add(fileName);
      }

      // update work Request
      final updatedTask = TaskModel.fromTask(params.task).copyWith(
        images: images,
        video: videoUrl,
      );

      // all files in folder
      final filesList = (await storageReference.listAll())
          .items
          .where((file) => file.name.contains(params.task.id))
          .toList();

      // remove old files
      for (var file in filesList) {
        if (!filesNames.contains(file.name)) {
          storageReference.child(file.name).delete();
        }
      }

      final taskMap = updatedTask.toMap();

      batch.update(
        taskReference,
        taskMap,
      );

      //
      if (params.task.assetId.isNotEmpty) {
        // asset
        final assetReference = firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('assets')
            .doc(params.task.assetId);

        final assetSnapshot = await assetReference.get();
        final asset = AssetModel.fromMap(
          assetSnapshot.data() as Map<String, dynamic>,
          assetSnapshot.id,
        );
        final updatedModel = asset.copyWith(
          currentStatus: params.task.assetStatus,
        );
        final assetMap = updatedModel.toMap();

        // action
        final actionsReference = firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('assetsActions');

        final assetAction = AssetActionModel(
          id: '',
          assetId: params.task.assetId,
          dateTime: params.task.date,
          userId: params.task.userId,
          locationId: params.task.locationId,
          isAssetInUse: asset.isInUse,
          isCreate: false,
          assetStatus: params.task.assetStatus,
          connectedTask: '',
          connectedWorkRequest: taskReference.id,
        );
        final actionMap = assetAction.toMap();

        // get action reference
        final actionReference = await actionsReference.add({'name': ''});

        // add action
        batch.set(actionReference, actionMap);
        // update item
        batch.update(assetReference, assetMap);
      }
      //

      batch.commit();

      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> cancelTask(TaskParams params) async {
    try {
      final taskReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('tasks')
          .doc(params.task.id);

      final taskInArchiveReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('tasksArchive')
          .doc(params.task.id);

      // batch
      final batch = firebaseFirestore.batch();

      // update task
      final updatedTask = TaskModel.fromTask(params.task).copyWith(
        isCancelled: true,
      );

      final taskMap = updatedTask.toMap();

      batch.set(
        taskInArchiveReference,
        taskMap,
      );

      batch.delete(taskReference);

      //
      if (params.task.assetId.isNotEmpty) {
        // asset
        final assetReference = firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('assets')
            .doc(params.task.assetId);

        final assetSnapshot = await assetReference.get();
        final asset = AssetModel.fromMap(
          assetSnapshot.data() as Map<String, dynamic>,
          assetSnapshot.id,
        );
        final updatedModel = asset.copyWith(
          currentStatus: params.task.assetStatus,
        );
        final assetMap = updatedModel.toMap();

        // action
        final actionsReference = firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('assetsActions');

        final assetAction = AssetActionModel(
          id: '',
          assetId: params.task.assetId,
          dateTime: DateTime.now(),
          userId: params.task.userId,
          locationId: params.task.locationId,
          isAssetInUse: asset.isInUse,
          isCreate: false,
          assetStatus: params.task.assetStatus,
          connectedTask: taskReference.id,
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
      //

      batch.commit();

      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> completeTask(TaskParams params) async {
    try {
      final taskReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('tasks')
          .doc(params.task.id); 

      final taskInArchiveReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('tasksArchive')
          .doc(params.task.id);

      // batch
      final batch = firebaseFirestore.batch();

      // update task
      final updatedTask = TaskModel.fromTask(params.task).copyWith(
        isFinished: true,
        executionDate: DateTime.now(),
      );
      final taskMap = updatedTask.toMap();

      batch.set(
        taskInArchiveReference,
        taskMap,
      );

      batch.delete(taskReference);

      // cyclic task
      if (params.task.isCyclictask) {
        // increment counter
        int counterValue = 0;
        final companyReference =
            firebaseFirestore.collection('companies').doc(params.companyId);

        await firebaseFirestore.runTransaction((transaction) async {
          final companySnapshot = await transaction.get(companyReference);

          if (!companySnapshot.exists) {
            throw Exception("Comapny does not exist!");
          }

          counterValue = companySnapshot.data()!['tasksCounter'] ?? 0;
          counterValue++;

          transaction.update(companyReference, {'tasksCounter': counterValue});
        });

        final nextTask = TaskModel.fromTask(params.task).copyWith(
          assetId: '',
          count: counterValue,
          date: DateTime.now(),
          isCancelled: false,
          isFinished: false,
          isInProgress: false,
          isSuccessful: false,
          parentId: updatedTask.id,
          executionDate: getNextDate(
            updatedTask.executionDate,
            updatedTask.durationUnit,
            updatedTask.duration,
          ),
        );
        final nextTaskMap = nextTask.toMap();

        final nextTaskReference = await firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('tasks')
            .add({'name': ''});

        batch.set(nextTaskReference, nextTaskMap);
      }

      //
      // if (params.task.assetId.isNotEmpty) {
      //   // asset
      //   final assetReference = firebaseFirestore
      //       .collection('companies')
      //       .doc(params.companyId)
      //       .collection('assets')
      //       .doc(params.task.assetId);

      //   final assetSnapshot = await assetReference.get();
      //   final asset = AssetModel.fromMap(
      //     assetSnapshot.data() as Map<String, dynamic>,
      //     assetSnapshot.id,
      //   );
      //   final updatedModel = asset.copyWith(
      //     currentStatus: params.task.assetStatus,
      //   );
      //   final assetMap = updatedModel.toMap();

      //   // action
      //   final actionsReference = firebaseFirestore
      //       .collection('companies')
      //       .doc(params.companyId)
      //       .collection('assetsActions');

      //   final assetAction = AssetActionModel(
      //     id: '',
      //     assetId: params.task.assetId,
      //     dateTime: DateTime.now(),
      //     userId: params.task.userId,
      //     locationId: params.task.locationId,
      //     isAssetInUse: asset.isInUse,
      //     isCreate: false,
      //     assetStatus: params.task.assetStatus,
      //     connectedTask: taskReference.id,
      //     connectedWorkRequest: '',
      //   );
      //   final actionMap = assetAction.toMap();

      //   // get action reference
      //   final actionReference = await actionsReference.add({'name': ''});

      //   // add action
      //   batch.set(actionReference, actionMap);
      //   // update item
      //   batch.update(assetReference, assetMap);
      // }
      //

      batch.commit();

      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, TasksStream>> getArchiveLatestTasksStream(
      ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('tasksArchive')
          .where('locationId', whereIn: params.locations)
          .limit(5)
          .snapshots();

      return Right(TasksStream(allTasks: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }
}
