import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

abstract class ItemFilesRepository {
  Future<Either<Failure, String>> addItemPhoto(ItemParams params);
  Future<Either<Failure, VoidResult>> updateItemPhoto(ItemParams params);
  Future<Either<Failure, VoidResult>> deleteItemPhoto(ItemParams params);
}
