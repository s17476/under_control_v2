import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/item_files_repository.dart';

@lazySingleton
class AddItemPhoto extends FutureUseCase<String, ItemParams> {
  final ItemFilesRepository repository;

  AddItemPhoto({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(ItemParams params) async =>
      repository.addItemPhoto(params);
}
