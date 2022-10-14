import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/asset_category_repository.dart';

@lazySingleton
class DeleteAssetCategory
    extends FutureUseCase<VoidResult, AssetCategoryParams> {
  final AssetCategoryRepository repository;

  DeleteAssetCategory({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(AssetCategoryParams params) async =>
      repository.deleteAssetCategory(params);
}
