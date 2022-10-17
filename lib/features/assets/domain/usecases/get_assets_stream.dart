import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/assets/domain/entities/assets_stream.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/asset_repository.dart';

@lazySingleton
class GetAssetsStream
    extends FutureUseCase<AssetsStream, AssetsInLocationsParams> {
  final AssetRepository repository;

  GetAssetsStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, AssetsStream>> call(
          AssetsInLocationsParams params) async =>
      repository.getAssetsStream(params);
}
