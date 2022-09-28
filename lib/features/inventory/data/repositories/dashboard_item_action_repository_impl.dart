import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/item_action/item_actions_stream.dart';
import '../../domain/repositories/dashboard_item_action_repository.dart';

@LazySingleton(as: DashboardItemActionRepository)
class DashboardItemActionRepositoryImpl extends DashboardItemActionRepository {
  final FirebaseFirestore firebaseFirestore;

  DashboardItemActionRepositoryImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, ItemActionsStream>> getDashboardItemActionsStream(
      ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('actions')
          .where('locationId', whereIn: params.locations)
          .orderBy('date', descending: true)
          .snapshots();

      return Right(ItemActionsStream(allItemActions: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, ItemActionsStream>>
      getDashboardLastFiveItemActionsStream(
          ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('actions')
          .where('locationId', whereIn: params.locations)
          .orderBy('date', descending: true)
          .limit(5)
          .snapshots();

      return Right(ItemActionsStream(allItemActions: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }
}
