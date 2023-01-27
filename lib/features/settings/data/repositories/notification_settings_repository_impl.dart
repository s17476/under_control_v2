import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/notification_settings.dart';
import '../../domain/repositories/notification_settings_repository.dart';
import '../models/notification_settings_model.dart';

@LazySingleton(as: NotificationSettingsRepository)
class NotificationSettingsImpl extends NotificationSettingsRepository {
  final FirebaseFirestore firebaseFirestore;

  NotificationSettingsImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, NotificationSettings>> getNotificationSettings(
    UserProfileParams params,
  ) async {
    try {
      final documentSnapshot = await firebaseFirestore
          .collection('users')
          .doc(params.userProfile.id)
          .collection('settings')
          .doc('notifications')
          .get();

      if (documentSnapshot.exists) {
        final documentMap = documentSnapshot as Map<String, dynamic>;
        final notificationSettings =
            NotificationSettingsModel.fromMap(documentMap);
        return Right(notificationSettings);
      } else {
        return Right(NotificationSettingsModel.initial());
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
  Future<Either<Failure, VoidResult>> updateNotificationSettings(
    NotificationSettingsParams params,
  ) async {
    try {
      final documentReference = firebaseFirestore
          .collection('users')
          .doc(params.userId)
          .collection('settings')
          .doc('notifications');

      Map<String, bool> updatedValueMap = {params.type.name: params.value};

      final settings = await documentReference.get();

      if (settings.exists) {
        documentReference.update(updatedValueMap);
      } else {
        documentReference.set(updatedValueMap);
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
