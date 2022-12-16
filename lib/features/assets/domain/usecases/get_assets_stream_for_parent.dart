import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/assets_stream.dart';
import '../repositories/asset_repository.dart';

@lazySingleton
class GetAssetsStreamForParent
    extends FutureUseCase<AssetsStream, AssetParams> {
  final AssetRepository repository;

  GetAssetsStreamForParent({
    required this.repository,
  });

  @override
  Future<Either<Failure, AssetsStream>> call(AssetParams params) async =>
      repository.getAssetPartsForParent(params);
}
