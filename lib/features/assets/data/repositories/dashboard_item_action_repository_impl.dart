import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/asset_action/asset_actions_stream.dart';
import '../../domain/repositories/dashboard_asset_action_repository.dart';

@LazySingleton(as: DashboardAssetActionRepository)
class DashboardAssetActionRepositoryImpl
    extends DashboardAssetActionRepository {
  final FirebaseFirestore firebaseFirestore;

  DashboardAssetActionRepositoryImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, AssetActionsStream>> getDashboardAssetActionsStream(
      ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assetActions')
          .where('locationId', whereIn: params.locations)
          .orderBy('dateTime', descending: true)
          .snapshots();

      return Right(AssetActionsStream(allAssetActions: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, AssetActionsStream>>
      getDashboardLastFiveAssetActionsStream(
          ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assetActions')
          .where('locationId', whereIn: params.locations)
          .orderBy('dateTime', descending: true)
          .limit(5)
          .snapshots();

      return Right(AssetActionsStream(allAssetActions: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }
}
