import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/item_category_repository.dart';

@lazySingleton
class AddItemCategory extends FutureUseCase<String, ItemCategoryParams> {
  final ItemCategoryRepository repository;

  AddItemCategory({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(ItemCategoryParams params) async =>
      repository.addItemCategory(params);
}
