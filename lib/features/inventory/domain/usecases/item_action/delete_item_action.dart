import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/item_action_repository.dart';

@lazySingleton
class DeleteItemAction extends FutureUseCase<VoidResult, ItemActionParams> {
  final ItemActionRepository repository;

  DeleteItemAction({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(ItemActionParams params) async =>
      repository.deleteItemAction(params);
}
