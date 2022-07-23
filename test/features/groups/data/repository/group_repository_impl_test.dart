import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/groups/data/datasources/group_local_data_source.dart';
import 'package:under_control_v2/features/groups/data/datasources/group_remote_data_source.dart';
import 'package:under_control_v2/features/groups/data/models/group_model.dart';
import 'package:under_control_v2/features/groups/data/repositories/group_repository_impl.dart';
import 'package:under_control_v2/features/groups/domain/entities/groups_stream.dart';

class MockGroupLocalDataSource extends Mock implements GroupLocalDataSource {}

class MockGroupRemoteDataSource extends Mock implements GroupRemoteDataSource {}

void main() {
  late MockGroupLocalDataSource mockGroupLocalDataSource;
  late MockGroupRemoteDataSource mockGroupRemoteDataSource;
  late GroupRepositoryImpl mockGroupRepository;

  setUp(() {
    mockGroupLocalDataSource = MockGroupLocalDataSource();
    mockGroupRemoteDataSource = MockGroupRemoteDataSource();
    mockGroupRepository = GroupRepositoryImpl(
        groupRemoteDataSource: mockGroupRemoteDataSource,
        groupLocalDataSource: mockGroupLocalDataSource);
  });

  setUpAll(() {
    registerFallbackValue(
      GroupParams(
        group: GroupModel.inital(),
        companyId: 'companyId',
      ),
    );
  });

  const tGroup = GroupModel(
    id: 'id',
    description: 'description',
    name: 'name',
    locations: [],
    features: [],
  );

  const tGroupParams = GroupParams(
    group: tGroup,
    companyId: 'companyId',
  );

  group('Group RepositoryImpl', () {
    group('AddGroup', () {
      test(
        'should add group to DB and return generated group id',
        () async {
          // arrange
          when(() => mockGroupRemoteDataSource.addGroup(any()))
              .thenAnswer((_) async => const Right(''));
          // act
          final result = await mockGroupRepository.addGroup(tGroupParams);
          // assert
          expect(result, isA<Right<Failure, String>>());
        },
      );
      test(
        'should return [Failure]',
        () async {
          // arrange
          when(() => mockGroupRemoteDataSource.addGroup(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          // act
          final result = await mockGroupRepository.addGroup(tGroupParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
    });

    group('UpdateGroup', () {
      test(
        'should update group in the DB and return VoidResult',
        () async {
          // arrange
          when(() => mockGroupRemoteDataSource.updateGroup(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          // act
          final result = await mockGroupRepository.updateGroup(tGroupParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [Failure]',
        () async {
          // arrange
          when(() => mockGroupRemoteDataSource.updateGroup(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          // act
          final result = await mockGroupRepository.updateGroup(tGroupParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
    });

    group('DeleteGroup', () {
      test(
        'should delete group from the DB and return VoidResult',
        () async {
          // arrange
          when(() => mockGroupRemoteDataSource.deleteGroup(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          // act
          final result = await mockGroupRepository.deleteGroup(tGroupParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [Failure]',
        () async {
          // arrange
          when(() => mockGroupRemoteDataSource.deleteGroup(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          // act
          final result = await mockGroupRepository.deleteGroup(tGroupParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
    });

    group('GetGroupsStream', () {
      test(
        'should return GroupsStream',
        () async {
          // arrange
          when(() => mockGroupRemoteDataSource.getGroupsStream(any()))
              .thenAnswer(
            (_) async => Right(
              GroupsStream(
                allGroups: Stream.fromIterable([tGroup]),
              ),
            ),
          );
          // act
          final result = await mockGroupRepository.getGroupsStream('companyId');
          // assert
          expect(result, isA<Right<Failure, GroupsStream>>());
        },
      );
      test(
        'should return [Failure]',
        () async {
          // arrange
          when(() => mockGroupRemoteDataSource.getGroupsStream(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          // act
          final result = await mockGroupRepository.getGroupsStream('companyId');
          // assert
          expect(result, isA<Left<Failure, GroupsStream>>());
        },
      );
    });
  });
}
