import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/uc_notifications_stream.dart';
import '../../domain/repositories/uc_notification_repository.dart';

@LazySingleton(as: UcNotificationRepository)
class UcNotificationRepositoryImpl extends UcNotificationRepository {
  final FirebaseFirestore firebaseFirestore;

  UcNotificationRepositoryImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, VoidResult>> deleteNotification(
      UcNotificationParams params) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(params.userId)
          .collection('notifications')
          .doc(params.notificationId)
          .delete();
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
  Future<Either<Failure, UcNotificationsStream>> getNotifications(
      UserProfileParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('users')
          .doc(params.userProfile.id)
          .collection('notifications')
          .snapshots();
      return Right(UcNotificationsStream(allNotifications: querySnapshot));
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
  Future<Either<Failure, VoidResult>> markAsRead(
      UcNotificationParams params) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(params.userId)
          .collection('notifications')
          .doc(params.notificationId)
          .update({'read': false});
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
  Future<Either<Failure, VoidResult>> markAsUnread(
      UcNotificationParams params) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(params.userId)
          .collection('notifications')
          .doc(params.notificationId)
          .update({'read': true});
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
