import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../core/utils/get_cached_firebase_storage_file.dart';
import '../../domain/entities/content_type.dart';
import '../../domain/entities/instructions_stream.dart';
import '../../domain/repositories/instruction_repository.dart';
import '../models/instruction_step_model.dart';

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
        // file name
        final fileName =
            '${instructionReference.id}-${step.id}-${DateTime.now().toIso8601String()}';
        switch (step.contentType) {

          // image
          case ContentType.image:
            if (step.file != null) {
              // filereference
              final fileReference = storageReference.child('$fileName.jpg');
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
              final fileReference = storageReference.child('$fileName.mp4');
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
              final fileReference = storageReference.child('$fileName.pdf');
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
      // collection reference
      final instructionReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('instructions')
          .doc(params.instruction.id);

      // batch
      final batch = firebaseFirestore.batch();

      // storage reference
      final storageReference =
          firebaseStorage.ref().child(params.companyId).child('instructions');

      final allFilesInDirectory = await storageReference.listAll();
      final filesForStep = allFilesInDirectory.items.where(
        (file) => file.name.contains(
          params.instruction.id,
        ),
      );

      for (var file in filesForStep) {
        storageReference.child(file.name).delete();
      }

      // delete instruction
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

      // updated file list
      List<String> addedFiles = [];

      // update steps
      for (var step in params.instruction.steps) {
        //filename without extension
        final fileNameWithoutExtension =
            '${params.instruction.id}-${step.id}-${DateTime.now().toIso8601String()}';

        // save updated files
        switch (step.contentType) {
          // image
          case ContentType.image:
            // filereference
            final fileReference =
                storageReference.child('$fileNameWithoutExtension.jpg');
            File? file;
            if (step.file != null) {
              file = step.file!;
            } else {
              file = await getCachedFirebaseStorageFile(step.contentUrl!);
            }
            // save file
            await fileReference.putFile(file!);
            addedFiles.add('$fileNameWithoutExtension.jpg');
            // get file url
            final fileUrl = await fileReference.getDownloadURL();
            steps.add(step.copyWith(contentUrl: fileUrl));
            break;
          // video
          case ContentType.video:
            // filereference
            final fileReference =
                storageReference.child('$fileNameWithoutExtension.mp4');
            File? file;
            if (step.file != null) {
              file = step.file!;
            } else {
              file = await getCachedFirebaseStorageFile(step.contentUrl!);
            }
            // save file
            await fileReference.putFile(file!);
            addedFiles.add('$fileNameWithoutExtension.mp4');
            // get file url
            final fileUrl = await fileReference.getDownloadURL();
            steps.add(step.copyWith(contentUrl: fileUrl));
            break;
          // pdf
          case ContentType.pdf:
            // filereference
            final fileReference =
                storageReference.child('$fileNameWithoutExtension.pdf');
            File? file;
            if (step.file != null) {
              file = step.file!;
            } else {
              file = await getCachedFirebaseStorageFile(step.contentUrl!);
            }
            // save file
            await fileReference.putFile(file!);
            addedFiles.add('$fileNameWithoutExtension.pdf');
            // get file url
            final fileUrl = await fileReference.getDownloadURL();
            steps.add(step.copyWith(contentUrl: fileUrl));
            break;
          default:
            steps.add(step);
            break;
        }

        // all files in folder
        final filesList = (await storageReference.listAll())
            .items
            .where((file) => file.name.contains(params.instruction.id))
            .toList();

        // remove old files
        for (var file in filesList) {
          if (!addedFiles.contains(file.name)) {
            storageReference.child(file.name).delete();
          }
        }
      }

      // final all file = filesList.

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
