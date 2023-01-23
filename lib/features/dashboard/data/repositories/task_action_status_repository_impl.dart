import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../tasks/domain/entities/task_action/task_actions_stream.dart';
import '../../domain/repositories/task_action_status_repository.dart';

@LazySingleton(as: TaskActionStatusRepository)
class TaskActionStatusRepositoryImpl extends TaskActionStatusRepository {
  final FirebaseFirestore firebaseFirestore;

  TaskActionStatusRepositoryImpl({
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
  Future<Either<Failure, TaskActionsStream>> getLatestTaskActions(
      ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('taskActions')
          .where('stopTime', isGreaterThan: startDate)
          .where('locationId', whereIn: params.locations)
          .snapshots();

      return Right(TaskActionsStream(allTaskActions: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }
}
