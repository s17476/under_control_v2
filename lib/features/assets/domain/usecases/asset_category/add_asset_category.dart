import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/asset_category_repository.dart';

@lazySingleton
class AddAssetCategory extends FutureUseCase<String, AssetCategoryParams> {
  final AssetCategoryRepository repository;

  AddAssetCategory({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(AssetCategoryParams params) async =>
      repository.addAssetCategory(params);
}
