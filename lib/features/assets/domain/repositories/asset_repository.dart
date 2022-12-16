import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/assets_stream.dart';

abstract class AssetRepository {
  ///Gets stream of asets in selected locations.
  ///
  ///Returns [AssetsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, AssetsStream>> getAssetsStream(
    AssetsInLocationsParams params,
  );

  ///Adds new asset to the DB.
  ///
  ///Returns [String] containing generated by DB asset id.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, String>> addAsset(AssetParams params);

  ///Updates asset in the DB.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> updateAsset(AssetParams params);

  ///Deletes asset from the DB.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> deleteAsset(AssetParams params);

  ///Checks if asset internal code is available.
  ///
  ///Returns [bool] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, bool>> checkCodeAvailability(CodeParams params);

  ///Gets stream of asset's being a part of parent asset.
  ///
  ///Returns [AssetsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, AssetsStream>> getAssetPartsForParent(
      AssetParams params);
}
