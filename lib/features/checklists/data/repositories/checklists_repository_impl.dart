import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/checklists/data/models/checklist_model.dart';

import 'package:under_control_v2/features/checklists/domain/entities/checklists_stream.dart';
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

@LazySingleton(as: CheckListsRepository)
class ChecklistsRepositoryImpl extends CheckListsRepository {
  final FirebaseFirestore firebaseFirestore;

  ChecklistsRepositoryImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, String>> addChecklist(ChecklistParams params) async {
    try {
      final checklistsReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('checklists');

      final checklistMap = (params.checklist as ChecklistModel).toMap();
      final documentReference = await checklistsReference.add(checklistMap);
      final String generatedChecklistId = documentReference.id;

      return Right(generatedChecklistId);
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
  Future<Either<Failure, VoidResult>> deleteChecklist(
      ChecklistParams params) async {
    try {
      firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('checklists')
          .doc(params.checklist.id)
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
  Future<Either<Failure, ChecklistsStream>> getChecklistsStream(
      String params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params)
          .collection('checklists')
          .snapshots();

      return Right(ChecklistsStream(allChecklists: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateChecklist(
      ChecklistParams params) async {
    try {
      final checklistsReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('checklists')
          .doc(params.checklist.id);
      final checklistMap = (params.checklist as ChecklistModel).toMap();
      await checklistsReference.update(checklistMap);
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
