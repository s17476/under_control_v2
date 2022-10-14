import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/asset_category/assets_categories_stream.dart';
import '../../repositories/asset_category_repository.dart';

@lazySingleton
class GetAssetsCategoriesStream
    extends FutureUseCase<AssetsCategoriesStream, String> {
  final AssetCategoryRepository repository;

  GetAssetsCategoriesStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, AssetsCategoriesStream>> call(
    String params,
  ) async =>
      repository.getAssetsCategoriesStream(params);
}
