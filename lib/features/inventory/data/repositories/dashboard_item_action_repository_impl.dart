import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_actions_stream.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:under_control_v2/features/inventory/domain/repositories/dashboard_item_action_repository.dart';
import 'package:injectable/injectable.dart';

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
