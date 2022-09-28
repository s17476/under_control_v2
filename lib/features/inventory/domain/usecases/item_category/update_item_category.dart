import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/item_category_repository.dart';

@lazySingleton
class UpdateItemCategory extends FutureUseCase<VoidResult, CategoryParams> {
  final ItemCategoryRepository repository;

  UpdateItemCategory({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(CategoryParams params) async =>
      repository.updateItemCategory(params);
}
