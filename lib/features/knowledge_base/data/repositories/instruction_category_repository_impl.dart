import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/instruction_category/instructions_categories_stream.dart';
import '../../domain/repositories/instruction_category_repository.dart';
import '../models/inventory_category/instruction_category_model.dart';

@LazySingleton(as: InstructionCategoryRepository)
class InstructionCategoryRepositoryImpl extends InstructionCategoryRepository {
  final FirebaseFirestore firebaseFirestore;

  InstructionCategoryRepositoryImpl({
    required this.firebaseFirestore,
  });
  @override
  Future<Either<Failure, String>> addInstructionCategory(
      InstructionCategoryParams params) async {
    try {
      final categoryReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('instructionsCategories');
      final instructionsCategoryMap =
          (params.instructionCategory as InstructionCategoryModel).toMap();
      final documentReferance =
          await categoryReference.add(instructionsCategoryMap);
      final String generatedInstructionCategoryId = documentReferance.id;
      return Right(generatedInstructionCategoryId);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> deleteInstructionCategory(
      InstructionCategoryParams params) async {
    try {
      // checks if there is no instructions in given category
      final instructionsInCategory = await firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('instructions')
          .where('category', isEqualTo: params.instructionCategory.id)
          .get();

      if (instructionsInCategory.docs.isEmpty) {
        firebaseFirestore
            .collection('companies')
            .doc(params.companyId)
            .collection('instructionsCategories')
            .doc(params.instructionCategory.id)
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
  Future<Either<Failure, InstructionsCategoriesStream>>
      getInstructionsCategoriesStream(String params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params)
          .collection('instructionsCategories')
          .snapshots();

      return Right(
        InstructionsCategoriesStream(
          allInstructionsCategories: querySnapshot,
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
  Future<Either<Failure, VoidResult>> updateInstructionCategory(
      InstructionCategoryParams params) async {
    try {
      final categoryReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('instructionsCategories')
          .doc(params.instructionCategory.id);
      final categoryMap =
          (params.instructionCategory as InstructionCategoryModel).toMap();
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
