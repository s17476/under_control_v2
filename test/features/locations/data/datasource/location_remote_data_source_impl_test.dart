import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart';
import 'package:under_control_v2/features/locations/data/models/location_model.dart';
import 'package:under_control_v2/features/locations/domain/entities/locations.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late MockFirebaseFirestore badFirebaseFirestore;
  late LocationRemoteDataSourceImpl dataSource;
  late LocationRemoteDataSourceImpl badDataSource;
  late CollectionReference mockCollectionReference;
  late LocationParams tLocationParams;

  const String companyId = 'companyId';

  const tLocation = LocationModel(
    id: 'id',
    name: 'name',
    parentId: 'parentId',
  );

  setUp(
    () async {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      badFirebaseFirestore = MockFirebaseFirestore();
      dataSource = LocationRemoteDataSourceImpl(
        firebaseFirestore: fakeFirebaseFirestore,
      );
      badDataSource = LocationRemoteDataSourceImpl(
        firebaseFirestore: badFirebaseFirestore,
      );
      mockCollectionReference = fakeFirebaseFirestore
          .collection('companies')
          .doc(companyId)
          .collection('locations');
      final documentReference =
          await mockCollectionReference.add(tLocation.toMap());
      tLocationParams = LocationParams(
        location: tLocation.copyWith(id: documentReference.id),
        comapnyId: companyId,
      );
    },
  );

  group('LocationRemoteDatasource', () {
    group('successful database response', () {
      test(
        'should return [String] when AddLocation is called',
        () async {
          // act
          final result = await dataSource.addLocation(tLocationParams);
          // assert
          expect(result, isA<Right<Failure, String>>());
        },
      );

      test(
        'should return [VoidResult] when DeleteLocation is called',
        () async {
          // act
          final result = await dataSource.deleteLocation(tLocationParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );
      test(
        'should return [VoidResult] when UpdateLocation is called',
        () async {
          // act
          final result = await dataSource.updateLocation(tLocationParams);
          // assert
          expect(result, isA<Right<Failure, VoidResult>>());
        },
      );

      test(
        'should return [Locations] when FetchAllUsers is called',
        () async {
          // arrange
          await mockCollectionReference.add(tLocation.toMap());
          // act
          final result = await dataSource.fetchAllLocations(companyId);
          // assert
          expect(result, isA<Right<Failure, Locations>>());
        },
      );
    });

    group('unsuccessful database response', () {
      test(
        'should return [DatabaseFailure] when AddLocation is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(FirebaseException(plugin: 'test'));
          // act
          final result = await badDataSource.addLocation(tLocationParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );

      test(
        'should return [DatabaseFailure] when DeleteLocation is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(FirebaseException(plugin: 'test'));
          // act
          final result = await badDataSource.deleteLocation(tLocationParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );
      test(
        'should return [DatabaseFailure] when UpdateLocation is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(FirebaseException(plugin: 'test'));
          // act
          final result = await badDataSource.updateLocation(tLocationParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return [DatabaseFailure] when FetchAllLocations is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(FirebaseException(plugin: 'test'));
          // act
          final result = await badDataSource.fetchAllLocations(companyId);
          // assert
          expect(result, isA<Left<Failure, Locations>>());
        },
      );
    });

    group('unsuspected failure', () {
      test(
        'should return [UnsuspectedFailure] when AddLocation is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(Exception());
          // act
          final result = await badDataSource.addLocation(tLocationParams);
          // assert
          expect(result, isA<Left<Failure, String>>());
        },
      );

      test(
        'should return [UnsuspectedFailure] when DeleteLocation is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(Exception());
          // act
          final result = await badDataSource.deleteLocation(tLocationParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return [UnsuspectedFailure] when UpdateLocation is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(Exception());
          // act
          final result = await badDataSource.updateLocation(tLocationParams);
          // assert
          expect(result, isA<Left<Failure, VoidResult>>());
        },
      );

      test(
        'should return [UnsuspectedFailure] when FetchAllLocations is called',
        () async {
          // arrange
          when(() => badFirebaseFirestore.collection(any()))
              .thenThrow(Exception());
          // act
          final result = await badDataSource.fetchAllLocations(companyId);
          // assert
          expect(result, isA<Left<Failure, Locations>>());
        },
      );
    });
  });
}
