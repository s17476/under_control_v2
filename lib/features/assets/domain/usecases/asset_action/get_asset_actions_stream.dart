import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/asset_action/asset_actions_stream.dart';
import '../../repositories/asset_action_repository.dart';

@lazySingleton
class GetAssetActionsStream
    extends FutureUseCase<AssetActionsStream, AssetParams> {
  final AssetActionRepository repository;

  GetAssetActionsStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, AssetActionsStream>> call(
    AssetParams params,
  ) async =>
      repository.getAssetActionsStream(params);
}
