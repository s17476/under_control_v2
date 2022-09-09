import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/item_action/item_actions_stream.dart';
import '../../repositories/item_action_repository.dart';

@lazySingleton
class GetItemsActionsStream
    extends FutureUseCase<ItemActionsStream, ItemParams> {
  final ItemActionRepository repository;

  GetItemsActionsStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, ItemActionsStream>> call(
    ItemParams params,
  ) async =>
      repository.getItemActionsStream(params);
}
