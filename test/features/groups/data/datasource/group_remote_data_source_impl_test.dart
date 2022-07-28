import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/groups/data/datasources/group_remote_data_source.dart';
import 'package:under_control_v2/features/groups/data/models/feature_model.dart';
import 'package:under_control_v2/features/groups/data/models/group_model.dart';
import 'package:under_control_v2/features/groups/domain/entities/feature.dart';
import 'package:under_control_v2/features/groups/domain/entities/groups_stream.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badFirebaseFirestore;
  late CollectionReference mockCollectionReferance;
  late GroupRemoteDataSourceImpl dataSource;
  late GroupRemoteDataSourceImpl badDataSource;

  const String companyId = 'companyId';

  setUp(() {
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    badFirebaseFirestore = MockFirebaseFirestore();
    mockCollectionReferance = fakeFirebaseFirestore
        .collection('companies')
        .doc(companyId)
        .collection('groups');
    dataSource =
        GroupRemoteDataSourceImpl(firebaseFirestore: fakeFirebaseFirestore);
    badDataSource =
        GroupRemoteDataSourceImpl(firebaseFirestore: badFirebaseFirestore);
  });

  final tGroup = GroupModel(
    id: 'id',
    name: 'name',
    description: 'description',
    groupAdministrators: const [],
    locations: const ['locations'],
    features: [
      FeatureModel(
        type: FeatureType.assets,
        create: true,
        read: true,
        edit: true,
        delete: true,
      ),
    ],
  );

  final tGroupParams = GroupParams(group: tGroup, companyId: companyId);

  group('Group RemoteDataSource', () {
    group('successful database response', () {
      test(
        'should return [String] containing group id when addGroup is called',
        () async {
          // act
          final result = await dataSource.addGroup(tGroupParams);
          // assert
          expect(result, isA<Right<Failure, String>>());
        },
      );
      test(
        'should return [VoidResult] when updateGroup is called',
        () async {
          // act
          final result = await dataSource.updateGroup(tGroupParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [VoidResult] when deleteGroup is called',
        () async {
          // act
          final result = await dataSource.deleteGroup(tGroupParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [GroupsStream] when getGroupsStream is called',
        () async {
          // arrange
          await mockCollectionReferance.add(tGroup.toMap());
          // act
          final result = await dataSource.getGroupsStream(companyId);
          // assert
          expect(result, isA<Right<Failure, GroupsStream>>());
        },
      );
    });

    group('unsuccessful database response', () {
      test(
        'should return a [DatabaseFailure] when addGroup is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badDataSource.addGroup(tGroupParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return a [DatabaseFailure] when updateGroup is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badDataSource.updateGroup(tGroupParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return a [DatabaseFailure] when deleteGroup is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badDataSource.deleteGroup(tGroupParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return a [DatabaseFailure] when getGroupsStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(FirebaseException(plugin: 'Bad Firebase'));
          // act
          final result = await badDataSource.getGroupsStream(companyId);
          // assert
          expect(result, isA<Left<Failure, GroupsStream>>());
        },
      );
    });

    group('unsuspected error', () {
      test(
        'should return a [UnsuspectedFailure] when addGroup is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(Exception());
          // act
          final result = await badDataSource.addGroup(tGroupParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );
      test(
        'should return a [UnsuspectedFailure] when updateGroup is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(Exception());
          // act
          final result = await badDataSource.updateGroup(tGroupParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return a [UnsuspectedFailure] when deleteGroup is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(Exception());
          // act
          final result = await badDataSource.deleteGroup(tGroupParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return a [UnsuspectedFailure] when getGroupsStream is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(Exception());
          // act
          final result = await badDataSource.getGroupsStream(companyId);
          // assert
          expect(result, isA<Left<Failure, GroupsStream>>());
        },
      );
    });
  });
}
