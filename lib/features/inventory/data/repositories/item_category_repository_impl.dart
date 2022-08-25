import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/inventory/data/models/item_category/item_category_model.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/item_category/items_categories_stream.dart';
import '../../domain/repositories/item_category_repository.dart';

@LazySingleton(as: ItemCategoryRepository)
class ItemCategoryRepositoryImpl extends ItemCategoryRepository {
  final FirebaseFirestore firebaseFirestore;

  ItemCategoryRepositoryImpl({
    required this.firebaseFirestore,
  });
  @override
  Future<Either<Failure, String>> addItemCategory(
      ItemCategoryParams params) async {
    try {
      final categoryReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('itemsCategories');
      final itemCategoryMap =
          (params.itemCategory as ItemCategoryModel).toMap();
      final documentReferance = await categoryReference.add(itemCategoryMap);
      final String generatedItemCategoryId = documentReferance.id;
      return Right(generatedItemCategoryId);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> deleteItemCategory(
      ItemCategoryParams params) async {
    try {
      // checks if there is no items in given category
      final itemsInCategory = await firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('items')
          .where('category', isEqualTo: params.itemCategory.id)
          .get();

      if (itemsInCategory.docs.isEmpty) {
        firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('itemsCategories')
            .doc(params.itemCategory.id)
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
  Future<Either<Failure, ItemsCategoriesStream>> getItemsCategoriesStream(
      String params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params)
          .collection('itemsCategories')
          .snapshots();

      return Right(ItemsCategoriesStream(allItemsCategories: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateItemCategory(
      ItemCategoryParams params) async {
    try {
      final categoryReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('itemsCategories')
          .doc(params.itemCategory.id);
      final categoryMap = (params.itemCategory as ItemCategoryModel).toMap();
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
