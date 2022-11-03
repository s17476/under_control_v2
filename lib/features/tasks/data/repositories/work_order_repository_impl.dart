import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/work_order/work_orders_stream.dart';
import '../../domain/repositories/work_order_repository.dart';
import '../models/work_order/work_order_model.dart';

@LazySingleton(as: WorkOrdersRepository)
class WorkOrdersRepositoryImpl extends WorkOrdersRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  WorkOrdersRepositoryImpl({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
  Future<Either<Failure, String>> addWorkOrder(WorkOrderParams params) async {
    try {
      final workOrdersReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('workOrders');

      // batch
      final batch = firebaseFirestore.batch();

      // link to stored images
      List<String> images = [];
      String videoUrl = '';

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('tasks');

      // get workOrder reference
      final workOrderReference = await workOrdersReference.add({'name': ''});

      // save documents
      if (params.images != null && params.images!.isNotEmpty) {
        for (var image in params.images!) {
          final fileName =
              '${workOrderReference.id}-${DateTime.now().toIso8601String()}.jpg';

          final fileReference = storageReference.child(fileName);
          await fileReference.putFile(image);
          final imageUrl = await fileReference.getDownloadURL();
          images.add(imageUrl);
        }
      }

      if (params.video != null) {
        final fileName =
            '${workOrderReference.id}-${DateTime.now().toIso8601String()}.mp4';

        final fileReference = storageReference.child(fileName);
        await fileReference.putFile(params.video!);
        videoUrl = await fileReference.getDownloadURL();
      }

      // increment work orders counter
      int counterValue = 0;
      final companyReference =
          firebaseFirestore.collection('companies').doc(params.companyId);

      firebaseFirestore.runTransaction((transaction) async {
        final companySnapshot = await transaction.get(companyReference);

        if (!companySnapshot.exists) {
          throw Exception("Comapny does not exist!");
        }

        counterValue = companySnapshot.data()!['workOrdersCounter'] + 1 ?? 1;

        transaction
            .update(companyReference, {'workOrdersCounter': counterValue});
      });

      // update work order
      final updatedWorkOrder =
          WorkOrderModel.fromWorkOrder(params.workOrder).copyWith(
        images: images,
        video: videoUrl,
        count: counterValue,
      );

      final workOrderMap = updatedWorkOrder.toMap();

      batch.set(workOrderReference, workOrderMap);

      batch.commit();

      return Right(workOrderReference.id);
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
  Future<Either<Failure, VoidResult>> deleteWorkOrder(
      WorkOrderParams params) async {
    try {
      final workOrderReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('workOrders')
          .doc(params.workOrder.id);

      // batch
      final batch = firebaseFirestore.batch();

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('tasks');

      final allFilesInDirectory = await storageReference.listAll();

      final filesForWorkOrder = allFilesInDirectory.items.where(
        (file) => file.name.contains(
          params.workOrder.id,
        ),
      );

      for (var file in filesForWorkOrder) {
        storageReference.child(file.name).delete();
      }

      // deletes item
      batch.delete(workOrderReference);

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
  Future<Either<Failure, WorkOrdersStream>> getWorkOrdersStream(
      ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('workOrders')
          .where('locationId', whereIn: params.locations)
          .snapshots();

      return Right(WorkOrdersStream(allWorkOrders: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateWorkOrder(
      WorkOrderParams params) async {
    try {
      final workOrderReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('workOrders')
          .doc(params.workOrder.id);

      // link to stored images
      List<String> images = [];
      List<String> filesNames = [];
      String videoUrl = '';

      // batch
      final batch = firebaseFirestore.batch();

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('tasks');

      // save documents
      if (params.images != null && params.images!.isNotEmpty) {
        for (var image in params.images!) {
          final fileName =
              '${params.workOrder.id}-${DateTime.now().toIso8601String()}.pdf';

          final fileReference = storageReference.child(fileName);
          await fileReference.putFile(image);
          final imageUrl = await fileReference.getDownloadURL();
          images.add(imageUrl);
          filesNames.add(fileName);
        }
      }

      if (params.video != null) {
        final fileName =
            '${params.workOrder.id}-${DateTime.now().toIso8601String()}.pdf';

        final fileReference = storageReference.child(fileName);
        await fileReference.putFile(params.video!);
        videoUrl = await fileReference.getDownloadURL();
        filesNames.add(fileName);
      }

      // update work order
      final updatedWorkOrder =
          WorkOrderModel.fromWorkOrder(params.workOrder).copyWith(
        images: images,
        video: videoUrl,
      );

      // all files in folder
      final filesList = (await storageReference.listAll())
          .items
          .where((file) => file.name.contains(params.workOrder.id))
          .toList();

      // remove old files
      for (var file in filesList) {
        if (!filesNames.contains(file.name)) {
          storageReference.child(file.name).delete();
        }
      }

      final workOrderMap = updatedWorkOrder.toMap();

      batch.update(
        workOrderReference,
        workOrderMap,
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
