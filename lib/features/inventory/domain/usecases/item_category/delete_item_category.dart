import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/item_category_repository.dart';

@lazySingleton
class DeleteItemCategory extends FutureUseCase<VoidResult, CategoryParams> {
  final ItemCategoryRepository repository;

  DeleteItemCategory({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(CategoryParams params) async =>
      repository.deleteItemCategory(params);
}
