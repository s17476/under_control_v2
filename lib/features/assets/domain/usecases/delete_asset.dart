import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/asset_repository.dart';

@lazySingleton
class DeleteAsset extends FutureUseCase<VoidResult, AssetParams> {
  final AssetRepository repository;

  DeleteAsset({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(AssetParams params) async =>
      repository.deleteAsset(params);
}
