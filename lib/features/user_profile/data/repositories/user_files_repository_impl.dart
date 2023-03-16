import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/repositories/user_files_repository.dart';

@LazySingleton(as: UserFilesRepository)
class UserFilesRepositoryImpl extends UserFilesRepository {
  final FirebaseStorage firebaseStorage;

  UserFilesRepositoryImpl({
    required this.firebaseStorage,
  });

  @override
  Future<Either<Failure, String>> addUserAvatar(AvatarParams params) async {
    try {
      final avatarReference =
          firebaseStorage.ref().child('avatars').child('${params.id}.jpg');

      if (kIsWeb) {
        PickedFile file = PickedFile(params.avatar.path);
        await avatarReference.putData(
          await file.readAsBytes(),
          SettableMetadata(contentType: 'image/jpeg'),
        );
      } else {
        await avatarReference.putFile(params.avatar);
      }

      final avatarUrl = await avatarReference.getDownloadURL();
      return Right(avatarUrl);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return Left(
        UnsuspectedFailure(message: e.toString()),
      );
    }
  }
}
