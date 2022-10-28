import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/asset_action/asset_actions_stream.dart';
import '../../repositories/dashboard_asset_action_repository.dart';

@lazySingleton
class GetDashboardLastFiveAssetActionsStream
    extends FutureUseCase<AssetActionsStream, ItemsInLocationsParams> {
  final DashboardAssetActionRepository repository;

  GetDashboardLastFiveAssetActionsStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, AssetActionsStream>> call(
    ItemsInLocationsParams params,
  ) async =>
      repository.getDashboardLastFiveAssetActionsStream(params);
}
