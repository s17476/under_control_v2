import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/item_repository.dart';

@lazySingleton
class DeleteItem extends FutureUseCase<VoidResult, ItemParams> {
  final ItemRepository repository;

  DeleteItem({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(ItemParams params) async =>
      repository.deleteItem(params);
}
