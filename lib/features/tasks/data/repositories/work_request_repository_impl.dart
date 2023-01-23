import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/assets/data/models/asset_action/asset_action_model.dart';
import 'package:under_control_v2/features/assets/data/models/asset_model.dart';
import 'package:uuid/uuid.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/work_request/work_requests_stream.dart';
import '../../domain/repositories/work_request_repository.dart';
import '../models/work_request/work_request_model.dart';

@LazySingleton(as: WorkRequestsRepository)
class WorkRequestsRepositoryImpl extends WorkRequestsRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  WorkRequestsRepositoryImpl({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
  Future<Either<Failure, String>> addWorkRequest(
      WorkRequestParams params) async {
    try {
      final workRequestsReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('workRequests');

      // batch
      final batch = firebaseFirestore.batch();

      // link to stored images
      List<String> images = [];
      String videoUrl = '';

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('tasks');

      // get workRequest reference
      final workRequestReference = workRequestsReference.doc(const Uuid().v1());

      // save documents
      if (params.images != null && params.images!.isNotEmpty) {
        for (var image in params.images!) {
          final fileName =
              '${workRequestReference.id}-${DateTime.now().toIso8601String()}.jpg';

          final fileReference = storageReference.child(fileName);
          await fileReference.putFile(image);
          final imageUrl = await fileReference.getDownloadURL();
          images.add(imageUrl);
        }
      }

      if (params.video != null) {
        final fileName =
            '${workRequestReference.id}-${DateTime.now().toIso8601String()}.mp4';

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

        counterValue = companySnapshot.data()!['workRequestsCounter'] ?? 0;
        counterValue++;

        transaction
            .update(companyReference, {'workRequestsCounter': counterValue});
      });

      // update work Request
      final updatedWorkRequest =
          WorkRequestModel.fromWorkRequest(params.workRequest).copyWith(
        images: images,
        video: videoUrl,
        count: counterValue,
      );

      final workRequestMap = updatedWorkRequest.toMap();

      batch.set(workRequestReference, workRequestMap);

      //
      //
      if (params.workRequest.assetId.isNotEmpty) {
        // asset
        final assetReference = firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('assets')
            .doc(params.workRequest.assetId);

        final assetSnapshot = await assetReference.get();
        final asset = AssetModel.fromMap(
          assetSnapshot.data() as Map<String, dynamic>,
          assetSnapshot.id,
        );
        final updatedModel = asset.copyWith(
          currentStatus: params.workRequest.assetStatus,
        );
        final assetMap = updatedModel.toMap();

        // action
        final actionsReference = firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('assetsActions');

        final assetAction = AssetActionModel(
          id: '',
          assetId: params.workRequest.assetId,
          dateTime: params.workRequest.date,
          userId: params.workRequest.userId,
          locationId: params.workRequest.locationId,
          isAssetInUse: asset.isInUse,
          isCreate: false,
          assetStatus: params.workRequest.assetStatus,
          connectedTask: '',
          connectedWorkRequest: workRequestReference.id,
        );
        final actionMap = assetAction.toMap();

        // get action reference
        final actionReference = actionsReference.doc(const Uuid().v1());

        // add action
        batch.set(actionReference, actionMap);
        // update item
        batch.update(assetReference, assetMap);
      }
      //
      //

      batch.commit();

      return Right(workRequestReference.id);
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
  Future<Either<Failure, VoidResult>> deleteWorkRequest(
      WorkRequestParams params) async {
    try {
      final workRequestReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('workRequests')
          .doc(params.workRequest.id);

      // batch
      final batch = firebaseFirestore.batch();

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('tasks');

      final allFilesInDirectory = await storageReference.listAll();

      final filesForWorkRequest = allFilesInDirectory.items.where(
        (file) => file.name.contains(
          params.workRequest.id,
        ),
      );

      for (var file in filesForWorkRequest) {
        storageReference.child(file.name).delete();
      }

      // deletes item
      batch.delete(workRequestReference);

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
  Future<Either<Failure, WorkRequestsStream>> getWorkRequestsStream(
      ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('workRequests')
          .where('locationId', whereIn: params.locations)
          .snapshots();

      return Right(WorkRequestsStream(allWorkRequests: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, WorkRequestsStream>> getArchiveWorkRequestsStream(
      ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('workRequestsArchive')
          .where('locationId', whereIn: params.locations)
          .snapshots();

      return Right(WorkRequestsStream(allWorkRequests: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateWorkRequest(
      WorkRequestParams params) async {
    try {
      final workRequestReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('workRequests')
          .doc(params.workRequest.id);

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
              '${params.workRequest.id}-${DateTime.now().toIso8601String()}.pdf';

          final fileReference = storageReference.child(fileName);
          await fileReference.putFile(image);
          final imageUrl = await fileReference.getDownloadURL();
          images.add(imageUrl);
          filesNames.add(fileName);
        }
      }

      if (params.video != null) {
        final fileName =
            '${params.workRequest.id}-${DateTime.now().toIso8601String()}.pdf';

        final fileReference = storageReference.child(fileName);
        await fileReference.putFile(params.video!);
        videoUrl = await fileReference.getDownloadURL();
        filesNames.add(fileName);
      }

      // update work Request
      final updatedWorkRequest =
          WorkRequestModel.fromWorkRequest(params.workRequest).copyWith(
        images: images,
        video: videoUrl,
      );

      // all files in folder
      final filesList = (await storageReference.listAll())
          .items
          .where((file) => file.name.contains(params.workRequest.id))
          .toList();

      // remove old files
      for (var file in filesList) {
        if (!filesNames.contains(file.name)) {
          storageReference.child(file.name).delete();
        }
      }

      final workRequestMap = updatedWorkRequest.toMap();

      batch.update(
        workRequestReference,
        workRequestMap,
      );

      //
      if (params.workRequest.assetId.isNotEmpty) {
        // asset
        final assetReference = firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('assets')
            .doc(params.workRequest.assetId);

        final assetSnapshot = await assetReference.get();
        final asset = AssetModel.fromMap(
          assetSnapshot.data() as Map<String, dynamic>,
          assetSnapshot.id,
        );
        final updatedModel = asset.copyWith(
          currentStatus: params.workRequest.assetStatus,
        );
        final assetMap = updatedModel.toMap();

        // action
        final actionsReference = firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('assetsActions');

        final assetAction = AssetActionModel(
          id: '',
          assetId: params.workRequest.assetId,
          dateTime: params.workRequest.date,
          userId: params.workRequest.userId,
          locationId: params.workRequest.locationId,
          isAssetInUse: asset.isInUse,
          isCreate: false,
          assetStatus: params.workRequest.assetStatus,
          connectedTask: '',
          connectedWorkRequest: workRequestReference.id,
        );
        final actionMap = assetAction.toMap();

        // get action reference
        final actionReference = actionsReference.doc(const Uuid().v1());

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
  Future<Either<Failure, VoidResult>> cancelWorkRequest(
      WorkRequestParams params) async {
    try {
      final workRequestReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('workRequests')
          .doc(params.workRequest.id);

      final workRequestInArchiveReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('workRequestsArchive')
          .doc(params.workRequest.id);

      // batch
      final batch = firebaseFirestore.batch();

      // update work Request
      final updatedWorkRequest =
          WorkRequestModel.fromWorkRequest(params.workRequest).copyWith(
        cancelled: true,
      );

      final workRequestMap = updatedWorkRequest.toMap();

      batch.set(
        workRequestInArchiveReference,
        workRequestMap,
      );

      batch.delete(workRequestReference);

      //
      if (params.workRequest.assetId.isNotEmpty) {
        // asset
        final assetReference = firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('assets')
            .doc(params.workRequest.assetId);

        final assetSnapshot = await assetReference.get();
        final asset = AssetModel.fromMap(
          assetSnapshot.data() as Map<String, dynamic>,
          assetSnapshot.id,
        );
        final updatedModel = asset.copyWith(
          currentStatus: params.workRequest.assetStatus,
        );
        final assetMap = updatedModel.toMap();

        // action
        final actionsReference = firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('assetsActions');

        final assetAction = AssetActionModel(
          id: '',
          assetId: params.workRequest.assetId,
          dateTime: DateTime.now(),
          userId: params.workRequest.userId,
          locationId: params.workRequest.locationId,
          isAssetInUse: asset.isInUse,
          isCreate: false,
          assetStatus: params.workRequest.assetStatus,
          connectedTask: '',
          connectedWorkRequest: workRequestReference.id,
        );
        final actionMap = assetAction.toMap();

        // get action reference
        final actionReference = actionsReference.doc(const Uuid().v1());

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
}
