import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/task/tasks_stream.dart';
import '../../domain/repositories/task_templates_repository.dart';
import '../models/task/task_model.dart';

@LazySingleton(as: TaskTemplatesRepository)
class TaskTemplatesRepositoryImpl extends TaskTemplatesRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  TaskTemplatesRepositoryImpl({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
  Future<Either<Failure, String>> addTaskTemplate(TaskParams params) async {
    try {
      final tasksReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('tasksTemplates');

      // batch
      final batch = firebaseFirestore.batch();

      // link to stored images
      List<String> images = [];
      String videoUrl = '';

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('tasksTemplates');

      // get task reference
      // final taskReference = await tasksReference.add({'name': ''});
      final taskReference = tasksReference.doc(const Uuid().v1());

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

      // update task
      final updatedtask = TaskModel.fromTask(params.task).copyWith(
        images: images,
        video: videoUrl,
      );

      final taskMap = updatedtask.toMap();

      batch.set(taskReference, taskMap);

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
  Future<Either<Failure, VoidResult>> deleteTaskTemplate(
      TaskParams params) async {
    try {
      final taskReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('tasksTemplates')
          .doc(params.task.id);

      // batch
      final batch = firebaseFirestore.batch();

      if (params.task.images.isNotEmpty || params.task.video.isNotEmpty) {
        // storage reference
        final storageReference = firebaseStorage
            .ref()
            .child(params.companyId)
            .child('tasksTemplates');

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
  Future<Either<Failure, TasksStream>> getTasksTemplatesStream(
      IdParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('tasksTemplates')
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
  Future<Either<Failure, VoidResult>> updateTaskTemplate(
      TaskParams params) async {
    try {
      final taskReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('tasksTemplates')
          .doc(params.task.id);

      // link to stored images
      List<String> images = [];
      List<String> filesNames = [];
      String videoUrl = '';

      // batch
      final batch = firebaseFirestore.batch();

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('tasksTemplates');

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
}
