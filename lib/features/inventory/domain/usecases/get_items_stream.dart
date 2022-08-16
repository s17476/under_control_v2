import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/inventory/domain/entities/items_stream.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/item_repository.dart';

@lazySingleton
class GetItemsStream
    extends FutureUseCase<ItemsStream, ItemsInLocationsParams> {
  final ItemRepository repository;

  GetItemsStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, ItemsStream>> call(
    ItemsInLocationsParams params,
  ) async =>
      repository.getItemsStream(params);
}
