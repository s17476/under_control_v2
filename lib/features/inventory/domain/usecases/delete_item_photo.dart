import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/item_files_repository.dart';

@lazySingleton
class DeleteItemPhoto extends FutureUseCase<VoidResult, ItemParams> {
  final ItemFilesRepository repository;

  DeleteItemPhoto({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(ItemParams params) async =>
      repository.deleteItemPhoto(params);
}
