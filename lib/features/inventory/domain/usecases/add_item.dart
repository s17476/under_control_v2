import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/item_repository.dart';

@lazySingleton
class AddItem extends FutureUseCase<String, ItemParams> {
  final ItemRepository repository;

  AddItem({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(ItemParams params) async =>
      repository.addItem(params);
}
