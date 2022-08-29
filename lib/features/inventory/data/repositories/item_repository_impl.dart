import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/items_stream.dart';
import '../../domain/repositories/item_repository.dart';
import '../models/item_model.dart';

@LazySingleton(as: ItemRepository)
class ItemRepositoryImpl extends ItemRepository {
  final FirebaseFirestore firebaseFirestore;

  ItemRepositoryImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, String>> addItem(ItemParams params) async {
    try {
      final itemsReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('items');

      final itemMap = (params.item as ItemModel).toMap();
      final documentReference = await itemsReference.add(itemMap);
      final String generatedId = documentReference.id;

      return Right(generatedId);
    } on FirebaseException catch (e) {
      return Left(
        DatabaseFailure(message: e.message ?? 'Database Failure'),
      );
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> deleteItem(ItemParams params) async {
    try {
      firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('items')
          .doc(params.item.id)
          .delete();

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
  Future<Either<Failure, ItemsStream>> getItemsStream(
      ItemsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('items')
          // TODO
          // max items <= 10!
          // .where('locations', arrayContainsAny: params.locations)
          .snapshots();

      return Right(ItemsStream(allItems: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateItem(ItemParams params) async {
    try {
      final collectionReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('items')
          .doc(params.item.id);
      final map = (params.item as ItemModel).toMap();
      await collectionReference.update(map);
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
