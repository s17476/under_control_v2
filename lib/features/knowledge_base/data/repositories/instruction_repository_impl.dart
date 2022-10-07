import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/knowledge_base/data/models/instruction_step_model.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/content_type.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instructions_stream.dart';
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_repository.dart';

@LazySingleton(as: InstructionRepository)
class InstructionRepositoryImpl extends InstructionRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  InstructionRepositoryImpl({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  @override
  Future<Either<Failure, String>> addInstruction(
      InstructionParams params) async {
    try {
      List<InstructionStepModel> steps = [];
      // batch
      final batch = firebaseFirestore.batch();

      // collection reference
      final instructionsReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('instructions');

      // instruction reference
      final instructionReference =
          await instructionsReference.add({'name': ''});

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('instructions');

      // save steps
      for (var step in params.instruction.steps) {
        switch (step.contentType) {
          // image
          case ContentType.image:
            if (step.file != null) {
              // filereference
              final fileReference = storageReference
                  .child('${instructionReference.id}-${step.id}.jpg');
              // save file
              await fileReference.putFile(step.file!);
              // get file url
              final fileUrl = await fileReference.getDownloadURL();
              steps.add(step.copyWith(contentUrl: fileUrl));
            }
            break;
          case ContentType.video:
            if (step.file != null) {
              // filereference
              final fileReference = storageReference
                  .child('${instructionReference.id}-${step.id}.mp4');
              // save file
              await fileReference.putFile(step.file!);
              // get file url
              final fileUrl = await fileReference.getDownloadURL();
              steps.add(step.copyWith(contentUrl: fileUrl));
            }
            break;
          case ContentType.pdf:
            if (step.file != null) {
              // filereference
              final fileReference = storageReference
                  .child('${instructionReference.id}-${step.id}.pdf');
              // save file
              await fileReference.putFile(step.file!);
              // get file url
              final fileUrl = await fileReference.getDownloadURL();
              steps.add(step.copyWith(contentUrl: fileUrl));
            }
            break;
          default:
            steps.add(step);
            break;
        }
      }

      // update instruction
      final updatedInstruction = params.instruction.copyWith(
        steps: steps,
      );

      // instruction map
      final instructionMap = updatedInstruction.toMap();

      // adds instruction to DB
      batch.set(
        instructionsReference.doc(instructionReference.id),
        instructionMap,
      );

      // commit the batch
      batch.commit();

      return Right(instructionReference.id);
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
  Future<Either<Failure, VoidResult>> deleteInstruction(
      InstructionParams params) async {
    try {
      // batch
      final batch = firebaseFirestore.batch();

      // collection reference
      final instructionReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('instructions')
          .doc(params.instruction.id);

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('instructions');

      // save steps
      for (var step in params.instruction.steps) {
        if (step.contentType == ContentType.image ||
            step.contentType == ContentType.video) {
          // file reference
          final fileReference =
              storageReference.child('${params.instruction.id}-${step.id}.jpg');
          // save file
          await fileReference.delete();
        }
      }

      // adds instruction to DB
      batch.delete(instructionReference);

      // commit the batch
      batch.commit();

      return Right(VoidResult());
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
  Future<Either<Failure, InstructionsStream>> getInstructionsStream(
      InstructionsInLocationsParams params) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('instructions')
          .where('locations', arrayContainsAny: params.locations)
          .orderBy('name', descending: true)
          .snapshots();

      return Right(InstructionsStream(allInstructions: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateInstruction(
      InstructionParams params) async {
    try {
      List<InstructionStepModel> steps = [];
      // batch
      final batch = firebaseFirestore.batch();

      // collection reference
      final instructionReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('instructions')
          .doc(params.instruction.id);

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('instructions');

      // save steps
      for (var step in params.instruction.steps) {
        switch (step.contentType) {
          // image
          case ContentType.image:
            if (step.file != null) {
              // filereference
              final fileReference = storageReference
                  .child('${params.instruction.id}-${step.id}.jpg');
              // save file
              await fileReference.putFile(step.file!);
              // get file url
              final fileUrl = await fileReference.getDownloadURL();
              steps.add(step.copyWith(contentUrl: fileUrl));
            }
            break;
          default:
            steps.add(step);
            break;
        }
      }

      // update instruction
      final updatedInstruction = params.instruction.copyWith(
        steps: steps,
      );

      // instruction map
      final instructionMap = updatedInstruction.toMap();

      // adds instruction to DB
      batch.update(
        instructionReference,
        instructionMap,
      );

      // commit the batch
      batch.commit();

      return Right(VoidResult());
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
}
