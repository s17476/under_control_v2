import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/asset_category/assets_categories_stream.dart';
import '../../domain/repositories/asset_category_repository.dart';
import '../models/asset_category/asset_category_model.dart';

@LazySingleton(as: AssetCategoryRepository)
class AssetCategoryRepositoryImpl extends AssetCategoryRepository {
  final FirebaseFirestore firebaseFirestore;

  AssetCategoryRepositoryImpl({
    required this.firebaseFirestore,
  });
  @override
  Future<Either<Failure, String>> addAssetCategory(
      AssetCategoryParams params) async {
    try {
      final categoryReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assetsCategories');
      final assetCategoryMap =
          (params.assetCategory as AssetCategoryModel).toMap();
      final documentReferance = await categoryReference.add(assetCategoryMap);
      final String generatedAssetCategoryId = documentReferance.id;
      return Right(generatedAssetCategoryId);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> deleteAssetCategory(
      AssetCategoryParams params) async {
    try {
      // checks if there is no assets in given category
      final assetsInCategory = await firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assets')
          .where('category', isEqualTo: params.assetCategory.id)
          .get();

      if (assetsInCategory.docs.isEmpty) {
        firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('assetsCategories')
            .doc(params.assetCategory.id)
            .delete();
      } else {
        return const Left(
          CategoryNotEmptyFailure(message: 'Unsuspected error'),
        );
      }

      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, AssetsCategoriesStream>> getAssetsCategoriesStream(
      String params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params)
          .collection('assetsCategories')
          .snapshots();

      return Right(
        AssetsCategoriesStream(
          allAssetsCategories: querySnapshot,
        ),
      );
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateAssetCategory(
      AssetCategoryParams params) async {
    try {
      final categoryReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('assetsCategories')
          .doc(params.assetCategory.id);
      final categoryMap = (params.assetCategory as AssetCategoryModel).toMap();
      await categoryReference.update(categoryMap);
      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }
}
