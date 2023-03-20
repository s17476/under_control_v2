import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/showcase_settings.dart';
import '../../domain/repositories/showcase_settings_repository.dart';
import '../models/showcase_settings_model.dart';

@LazySingleton(as: ShowcaseSettingsRepository)
class ShowcaseSettingsImpl extends ShowcaseSettingsRepository {
  final FirebaseFirestore firebaseFirestore;

  ShowcaseSettingsImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, ShowcaseSettings>> getShowcaseSettings(
    UserProfileParams params,
  ) async {
    try {
      final documentSnapshot = await firebaseFirestore
          .collection('users')
          .doc(params.userProfile.id)
          .collection('settings')
          .doc('showcase')
          .get();

      if (documentSnapshot.exists) {
        final documentMap = documentSnapshot.data() as Map<String, dynamic>;
        final notificationSettings = ShowcaseSettingsModel.fromMap(documentMap);
        return Right(notificationSettings);
      } else {
        return Right(ShowcaseSettingsModel.initial());
      }
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
  Future<Either<Failure, VoidResult>> updateShowcaseSettings(
    ShowcaseSettingsParams params,
  ) async {
    try {
      final documentReference = firebaseFirestore
          .collection('users')
          .doc(params.userId)
          .collection('settings')
          .doc('showcase');

      final settingsReference = await documentReference.get();
      final settingsMap =
          ShowcaseSettingsModel.fromDomain(params.settings).toMap();

      if (settingsReference.exists) {
        documentReference.update(settingsMap);
      } else {
        documentReference.set(settingsMap);
      }

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
