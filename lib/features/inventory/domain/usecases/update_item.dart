import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/item_repository.dart';

@lazySingleton
class UpdateItem extends FutureUseCase<VoidResult, ItemParams> {
  final ItemRepository repository;

  UpdateItem({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(ItemParams params) async =>
      repository.updateItem(params);
}
