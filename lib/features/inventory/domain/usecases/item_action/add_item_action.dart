import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/item_action_repository.dart';

@lazySingleton
class AddItemAction extends FutureUseCase<String, ItemActionParams> {
  final ItemActionRepository repository;

  AddItemAction({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(ItemActionParams params) async =>
      repository.addItemAction(params);
}
