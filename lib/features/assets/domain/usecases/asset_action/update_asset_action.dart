import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/asset_action_repository.dart';

@lazySingleton
class UpdateAssetAction extends FutureUseCase<VoidResult, AssetActionParams> {
  final AssetActionRepository repository;

  UpdateAssetAction({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(AssetActionParams params) async =>
      repository.updateAssetAction(params);
}
