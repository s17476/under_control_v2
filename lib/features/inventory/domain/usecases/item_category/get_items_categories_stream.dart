import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/item_category/items_categories_stream.dart';
import '../../repositories/item_category_repository.dart';

@lazySingleton
class GetItemsCategoriesStream
    extends FutureUseCase<ItemsCategoriesStream, String> {
  final ItemCategoryRepository repository;

  GetItemsCategoriesStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, ItemsCategoriesStream>> call(
    String params,
  ) async =>
      repository.getItemsCategoriesStream(params);
}
