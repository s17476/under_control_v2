import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../tasks/domain/entities/work_request/work_requests_stream.dart';
import '../../domain/repositories/work_request_status_repository.dart';

@LazySingleton(as: WorkRequestsStatusRepository)
class WorkRequestsStatusRepositoryImpl extends WorkRequestsStatusRepository {
  final FirebaseFirestore firebaseFirestore;

  WorkRequestsStatusRepositoryImpl({
    required this.firebaseFirestore,
  });

  final startDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).subtract(
    const Duration(days: 30),
  );

  @override
  Future<Either<Failure, WorkRequestsStream>> getAwaitingWorkRequestsCount(
      ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('workRequests')
          .where('date', isGreaterThan: startDate)
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
  Future<Either<Failure, WorkRequestsStream>> getCancelledWorkRequestsCount(
      ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('workRequestsArchive')
          .where('date', isGreaterThan: startDate)
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
  Future<Either<Failure, WorkRequestsStream>> getConvertedWorkRequestsCount(
      ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('workRequests')
          .where('taskId', isNotEqualTo: '')
          .where('date', isGreaterThan: startDate)
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
}
