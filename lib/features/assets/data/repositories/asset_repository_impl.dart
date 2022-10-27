import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import 'package:under_control_v2/features/assets/domain/entities/assets_stream.dart';
import 'package:under_control_v2/features/assets/domain/repositories/asset_repository.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

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

      // instruction reference
      final assetReference = await assetsReference.add({'name': ''});
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

      // add asset to DB
      batch.set(
        assetsReference.doc(assetReference.id),
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

      // batch
      final batch = firebaseFirestore.batch();

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
          // .orderBy('producer', descending: true)
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

      // batch
      final batch = firebaseFirestore.batch();

      // collection reference
      final assetReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assets')
          .doc(params.asset.id);

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
        }
      }

      // all files in folder
      final filesList = (await storageReference.listAll())
          .items
          .where((file) => file.name.contains(params.asset.id))
          .toList();

      // remove old files
      for (var file in filesList) {
        if (!photos.contains(file.name) && documents.contains(file.name)) {
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
}
