import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/asset_repository.dart';

@lazySingleton
class AddAsset extends FutureUseCase<String, AssetParams> {
  final AssetRepository repository;

  AddAsset({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(AssetParams params) async =>
      repository.addAsset(params);
}
