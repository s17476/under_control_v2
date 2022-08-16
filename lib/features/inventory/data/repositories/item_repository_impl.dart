import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/items_stream.dart';
import '../../domain/repositories/item_repository.dart';

@LazySingleton(as: ItemRepository)
class ItemRepositoryImpl extends ItemRepository {
  @override
  Future<Either<Failure, String>> addItem(ItemParams params) {
    // TODO: implement addItem
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, VoidResult>> deleteItem(ItemParams params) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ItemsStream>> getItemsStream(
      ItemsInLocationsParams params) {
    // TODO: implement getItemsStream
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, VoidResult>> updateItem(ItemParams params) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }
}
