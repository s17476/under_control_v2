import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/item_action_repository.dart';

@lazySingleton
class MoveItemAction extends FutureUseCase<VoidResult, MoveItemActionParams> {
  final ItemActionRepository repository;

  MoveItemAction({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(MoveItemActionParams params) async =>
      repository.moveItemAction(params);
}
