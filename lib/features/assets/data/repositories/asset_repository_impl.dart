import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import 'package:under_control_v2/features/assets/domain/entities/assets_stream.dart';
import 'package:under_control_v2/features/assets/domain/repositories/asset_repository.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

import '../models/asset_action/asset_action_model.dart';

@LazySingleton(as: AssetRepository)
class AssetRepositoryImpl extends AssetRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  AssetRepositoryImpl({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });
  @override
  Future<Either<Failure, String>> addAsset(AssetParams params) async {
    try {
      // links to stored images
      List<String> photos = [];

      // link to stored documents
      List<String> documents = [];

      // batch
      final batch = firebaseFirestore.batch();

      // collection reference
      final assetsReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assets');

      // action
      final actionsReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assetsActions');

      // get action reference
      final actionReference = await actionsReference.add({'name': ''});

      // instruction reference
      final assetReference = await assetsReference.add({'name': ''});

      final assetAction = AssetActionModel(
        id: actionReference.id,
        assetId: assetReference.id,
        dateTime: DateTime.now(),
        userId: params.userId ?? '',
        locationId: params.asset.locationId,
        isAssetInUse: params.asset.isInUse,
        isCreate: true,
        assetStatus: params.asset.currentStatus,
        connectedTask: '',
        connectedWorkRequest: '',
      );

      final actionMap = assetAction.toMap();

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('assets');

      // save photos
      if (params.images != null && params.images!.isNotEmpty) {
        for (var photo in params.images!) {
          final fileName =
              '${assetReference.id}-${DateTime.now().toIso8601String()}.jpg';

          final fileReference = storageReference.child(fileName);
          await fileReference.putFile(photo);
          final photoUrl = await fileReference.getDownloadURL();
          photos.add(photoUrl);
        }
      }

      // save documents
      if (params.documents != null && params.documents!.isNotEmpty) {
        for (var document in params.documents!) {
          final fileName =
              '${assetReference.id}-${DateTime.now().toIso8601String()}.pdf';

          final fileReference = storageReference.child(fileName);
          await fileReference.putFile(document);
          final documentUrl = await fileReference.getDownloadURL();
          documents.add(documentUrl);
        }
      }

      // update asset
      final updatedAsset = params.asset.copyWith(
        images: photos,
        documents: documents,
      );

      // asset map
      final assetMap = updatedAsset.toMap();

      // add action
      batch.set(
        actionReference,
        actionMap,
      );

      // add asset to DB
      batch.set(
        assetReference,
        assetMap,
      );

      // commit the batch
      batch.commit();

      return Right(assetReference.id);
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
  Future<Either<Failure, VoidResult>> deleteAsset(AssetParams params) async {
    try {
// collection reference
      final assetReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assets')
          .doc(params.asset.id);

      final actionsReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assetsActions');

      final assetActions = await actionsReference
          .where('assetId', isEqualTo: params.asset.id)
          .get();

      // batch
      final batch = firebaseFirestore.batch();

      // deletes connected actions
      for (var doc in assetActions.docs) {
        final documentReference = actionsReference.doc(doc.id);
        batch.delete(documentReference);
      }

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('assets');

      final allFilesInDirectory = await storageReference.listAll();

      final filesForAsset = allFilesInDirectory.items.where(
        (file) => file.name.contains(
          params.asset.id,
        ),
      );

      for (var file in filesForAsset) {
        storageReference.child(file.name).delete();
      }

      batch.delete(assetReference);

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
  Future<Either<Failure, AssetsStream>> getAssetsStream(
      AssetsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assets')
          .where('locationId', whereIn: params.locations)
          .snapshots();

      return Right(AssetsStream(allAssets: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateAsset(AssetParams params) async {
    try {
      // links to stored images
      List<String> photos = [];

      // link to stored documents
      List<String> documents = [];
      List<String> documentsNames = [];

      // batch
      final batch = firebaseFirestore.batch();

      // collection reference
      final assetReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assets')
          .doc(params.asset.id);

      // action
      final actionsReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assetsActions');

      // get action reference
      final actionReference = await actionsReference.add({'name': ''});

      final assetAction = AssetActionModel(
        id: actionReference.id,
        assetId: params.asset.id,
        dateTime: DateTime.now(),
        userId: params.userId ?? '',
        locationId: params.asset.locationId,
        isAssetInUse: params.asset.isInUse,
        isCreate: false,
        assetStatus: params.asset.currentStatus,
        connectedTask: '',
        connectedWorkRequest: '',
      );

      final actionMap = assetAction.toMap();

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('assets');

      // save photos
      if (params.images != null && params.images!.isNotEmpty) {
        for (var photo in params.images!) {
          final fileName =
              '${params.asset.id}-${DateTime.now().toIso8601String()}.jpg';

          final fileReference = storageReference.child(fileName);
          await fileReference.putFile(photo);
          final photoUrl = await fileReference.getDownloadURL();
          photos.add(photoUrl);
          documentsNames.add(fileName);
        }
      }

      // save documents
      if (params.documents != null && params.documents!.isNotEmpty) {
        for (var document in params.documents!) {
          final fileName =
              '${params.asset.id}-${DateTime.now().toIso8601String()}.pdf';

          final fileReference = storageReference.child(fileName);
          await fileReference.putFile(document);
          final documentUrl = await fileReference.getDownloadURL();
          documents.add(documentUrl);
          documentsNames.add(fileName);
        }
      }

      // all files in folder
      final filesList = (await storageReference.listAll())
          .items
          .where((file) => file.name.contains(params.asset.id))
          .toList();

      // remove old files
      for (var file in filesList) {
        if (!documentsNames.contains(file.name)) {
          storageReference.child(file.name).delete();
        }
      }

      // update asset
      final updatedAsset = params.asset.copyWith(
        images: photos,
        documents: documents,
      );

      // asset map
      final assetMap = updatedAsset.toMap();

      // add action
      batch.set(
        actionReference,
        actionMap,
      );

      // add asset to DB
      batch.update(
        assetReference,
        assetMap,
      );

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
  Future<Either<Failure, bool>> checkCodeAvailability(CodeParams params) async {
    try {
      final assetsList = await firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assets')
          .where(
            'internalCodeLowerCase',
            isEqualTo: params.internalCode.toLowerCase().trim(),
          )
          .get();

      final isCodeAvailable = assetsList.size == 0;

      return Right(isCodeAvailable);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, AssetsStream>> getAssetPartsForParent(
      AssetParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assets')
          .where('currentParentId', isEqualTo: params.asset.id)
          .snapshots();

      return Right(AssetsStream(allAssets: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }
}
