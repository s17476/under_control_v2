import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/item_action/item_actions_stream.dart';
import '../../repositories/dashboard_item_action_repository.dart';

@lazySingleton
class GetDashboardItemsActionsStream
    extends FutureUseCase<ItemActionsStream, ItemsInLocationsParams> {
  final DashboardItemActionRepository repository;

  GetDashboardItemsActionsStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, ItemActionsStream>> call(
    ItemsInLocationsParams params,
  ) async =>
      repository.getDashboardItemActionsStream(params);
}
