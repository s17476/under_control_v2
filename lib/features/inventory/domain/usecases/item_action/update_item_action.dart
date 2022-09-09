import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/item_action_repository.dart';

@lazySingleton
class UpdateItemAction extends FutureUseCase<VoidResult, ItemActionParams> {
  final ItemActionRepository repository;

  UpdateItemAction({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(ItemActionParams params) async =>
      repository.updateItemAction(params);
}
