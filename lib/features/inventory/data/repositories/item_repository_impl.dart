import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/items_stream.dart';
import '../../domain/repositories/item_repository.dart';
import '../models/item_model.dart';

@LazySingleton(as: ItemRepository)
class ItemRepositoryImpl extends ItemRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ItemRepositoryImpl({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
  Future<Either<Failure, String>> addItem(ItemParams params) async {
    try {
      final itemsReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('items');

      // batch
      final batch = firebaseFirestore.batch();

      // link to stored documents
      List<String> documents = [];

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('items');

      // get action reference
      final itemReference = await itemsReference.add({'name': ''});

      // save documents
      if (params.documents != null && params.documents!.isNotEmpty) {
        for (var document in params.documents!) {
          final fileName =
              '${itemReference.id}-${DateTime.now().toIso8601String()}.pdf';

          final fileReference = storageReference.child(fileName);
          await fileReference.putFile(document);
          final documentUrl = await fileReference.getDownloadURL();
          documents.add(documentUrl);
        }
      }

      // update item
      final updatedItem = ItemModel.fromItem(params.item).copyWith(
        documents: documents,
      );

      final itemMap = updatedItem.toMap();

      batch.set(itemReference, itemMap);

      batch.commit();

      // final itemMap = (params.item as ItemModel).toMap();
      // final documentReference = await itemsReference.add(itemMap);
      // final String generatedId = documentReference.id;

      return Right(itemReference.id);
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
      final List<String> itemActionsToDelete = [];

      // item
      final itemReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('items')
          .doc(params.item.id);

      // actions
      final actionsReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('actions');

      final itemActions = await actionsReference
          .where('itemId', isEqualTo: params.item.id)
          .get();

      itemActionsToDelete.addAll(itemActions.docs.map((e) => e.id));

      // batch
      final batch = firebaseFirestore.batch();

      // deletes item actions
      for (var actionId in itemActionsToDelete) {
        batch.delete(actionsReference.doc(actionId));
      }

      // deletes item
      batch.delete(itemReference);

      // commit batch
      batch.commit();

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
      final itemReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('items')
          .doc(params.item.id);

      // link to stored documents
      List<String> documents = [];

      // batch
      final batch = firebaseFirestore.batch();

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('items');

      // save documents
      if (params.documents != null && params.documents!.isNotEmpty) {
        for (var document in params.documents!) {
          final fileName =
              '${params.item.id}-${DateTime.now().toIso8601String()}.pdf';

          final fileReference = storageReference.child(fileName);
          await fileReference.putFile(document);
          final documentUrl = await fileReference.getDownloadURL();
          documents.add(documentUrl);
        }
      }

      // all files in folder
      final filesList = (await storageReference.listAll())
          .items
          .where((file) => file.name.contains(params.item.id))
          .toList();

      // remove old files
      for (var file in filesList) {
        if (!documents.contains(file.name)) {
          storageReference.child(file.name).delete();
        }
      }

      // update item
      final updatedItem =
          ItemModel.fromItem(params.item).copyWith(documents: documents);

      final itemMap = updatedItem.toMap();

      batch.update(
        itemReference,
        itemMap,
      );

      batch.commit();

      // final map = (params.item as ItemModel).toMap();
      // await collectionReference.update(map);
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
