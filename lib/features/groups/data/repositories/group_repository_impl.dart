import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/groups_stream.dart';
import '../../domain/repositories/group_repository.dart';
import '../datasources/group_local_data_source.dart';
import '../datasources/group_remote_data_source.dart';

@LazySingleton(as: GroupRepository)
class GroupRepositoryImpl extends GroupRepository {
  final GroupRemoteDataSource groupRemoteDataSource;
  final GroupLocalDataSource groupLocalDataSource;

  GroupRepositoryImpl({
    required this.groupRemoteDataSource,
    required this.groupLocalDataSource,
  });

  @override
  Future<Either<Failure, String>> addGroup(GroupParams params) =>
      groupRemoteDataSource.addGroup(params);

  @override
  Future<Either<Failure, VoidResult>> deleteGroup(GroupParams params) =>
      groupRemoteDataSource.deleteGroup(params);

  @override
  Future<Either<Failure, GroupsStream>> getGroupsStream(String companyId) =>
      groupRemoteDataSource.getGroupsStream(companyId);

  @override
  Future<Either<Failure, VoidResult>> updateGroup(GroupParams params) =>
      groupRemoteDataSource.updateGroup(params);

  @override
  Future<Either<Failure, VoidResult>> cacheSelectedGroups(
      SelectedGroupsParams params) async {
    try {
      groupLocalDataSource.cacheGroups(params);
      return Right(VoidResult());
    } on CacheException {
      return const Left(CacheFailure());
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, SelectedGroupsParams>> tryToGetCachedgroups() async {
    try {
      final cachedGroups = await groupLocalDataSource.getCachedGroups();
      return Right(cachedGroups);
    } on CacheException {
      return const Left(CacheFailure());
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }
}
