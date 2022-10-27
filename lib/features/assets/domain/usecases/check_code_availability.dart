import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/asset_repository.dart';

@lazySingleton
class CheckCodeAvailability extends FutureUseCase<bool, CodeParams> {
  final AssetRepository repository;

  CheckCodeAvailability({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(CodeParams params) async =>
      repository.checkCodeAvailability(params);
}
