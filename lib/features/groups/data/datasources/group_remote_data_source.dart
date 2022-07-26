import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/groups_stream.dart';
import '../models/group_model.dart';

abstract class GroupRemoteDataSource {
  Future<Either<Failure, String>> addGroup(GroupParams params);
  Future<Either<Failure, VoidResult>> updateGroup(GroupParams params);
  Future<Either<Failure, VoidResult>> deleteGroup(GroupParams params);
  Future<Either<Failure, GroupsStream>> getGroupsStream(String companyId);
}

@LazySingleton(as: GroupRemoteDataSource)
class GroupRemoteDataSourceImpl extends GroupRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  GroupRemoteDataSourceImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, String>> addGroup(GroupParams params) async {
    try {
      final groupReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('groups');
      final groupMap = (params.group as GroupModel).toMap();
      final documentReferance = await groupReference.add(groupMap);
      final String generatedGroupId = documentReferance.id;
      return Right(generatedGroupId);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> deleteGroup(GroupParams params) async {
    try {
      firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('groups')
          .doc(params.group.id)
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
  Future<Either<Failure, GroupsStream>> getGroupsStream(
      String companyId) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(companyId)
          .collection('groups')
          .snapshots();

      return Right(GroupsStream(allGroups: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateGroup(GroupParams params) async {
    try {
      final groupReference = firebaseFirestore
          .collection('companies')
          .doc(params.companyId)
          .collection('groups')
          .doc(params.group.id);
      final groupMap = (params.group as GroupModel).toMap();
      await groupReference.update(groupMap);
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
