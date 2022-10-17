import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/asset_action_repository.dart';

@lazySingleton
class AddAssetAction extends FutureUseCase<String, AssetActionParams> {
  final AssetActionRepository repository;

  AddAssetAction({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(AssetActionParams params) async =>
      repository.addAssetAction(params);
}
