import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/repositories/notification_repository.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl extends NotificationRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseMessaging firebaseMessaging;

  NotificationRepositoryImpl({
    required this.firebaseFirestore,
    required this.firebaseMessaging,
  });

  @override
  Future<Either<Failure, VoidResult>> registerDeviceToken(
    UserProfileParams params,
  ) async {
    try {
      final token = await _getDeviceToken();

      if (token == null) {
        throw Exception('Device Token can\'t be null');
      }

      if (!params.userProfile.deviceTokens.contains(token)) {
        final deviceTokens = [...params.userProfile.deviceTokens, token];
        final deviceTokensMap = {'deviceTokens': deviceTokens};
        await firebaseFirestore
            .collection('users')
            .doc(params.userProfile.id)
            .update(deviceTokensMap);
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

  @override
  Future<Either<Failure, VoidResult>> removeDeviceToken(
      UserProfileParams params) async {
    try {
      final token = await _getDeviceToken();

      if (token == null) {
        throw Exception('Device Token can\'t be null');
      }

      if (params.userProfile.deviceTokens.contains(token)) {
        final deviceTokens = params.userProfile.deviceTokens;
        deviceTokens.remove(token);

        final deviceTokensMap = {'deviceTokens': deviceTokens};
        await firebaseFirestore
            .collection('users')
            .doc(params.userProfile.id)
            .update(deviceTokensMap);
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

  Future<String?> _getDeviceToken() async => await firebaseMessaging.getToken();
}
