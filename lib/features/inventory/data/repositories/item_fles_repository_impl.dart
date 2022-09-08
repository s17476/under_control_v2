import 'package:firebase_storage/firebase_storage.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/inventory/domain/repositories/item_files_repository.dart';

@LazySingleton(as: ItemFilesRepository)
class ItemFilesRepositoryImpl extends ItemFilesRepository {
  final FirebaseStorage firebaseStorage;

  ItemFilesRepositoryImpl({
    required this.firebaseStorage,
  });

  @override
  Future<Either<Failure, String>> addItemPhoto(ItemParams params) async {
    try {
      if (params.photo == null) {
        throw (Exception('Image can\'t be null'));
      }
      final imageReference = firebaseStorage
          .ref()
          .child(params.companyId)
          .child('items')
          .child(params.item.id)
          .child('photo.jpg');
      await imageReference.putFile(params.photo!);

      final imageUrl = await imageReference.getDownloadURL();
      return Right(imageUrl);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return Left(
        UnsuspectedFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> deleteItemPhoto(ItemParams params) async {
    try {
      final imageReference = firebaseStorage
          .ref()
          .child(params.companyId)
          .child('items')
          .child(params.item.id)
          .child('photo.jpg');
      await imageReference.delete();

      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return Left(
        UnsuspectedFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateItemPhoto(ItemParams params) async {
    try {
      if (params.photo == null) {
        throw (Exception('Image can\'t be null'));
      }
      final imageReference = firebaseStorage
          .ref()
          .child(params.companyId)
          .child('items')
          .child(params.item.id)
          .child('photo.jpg');
      await imageReference.putFile(params.photo!);

      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return Left(
        UnsuspectedFailure(message: e.toString()),
      );
    }
  }
}
