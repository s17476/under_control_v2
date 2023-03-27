import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/error/exceptions.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/locations.dart';
import '../models/location_model.dart';

abstract class LocationRemoteDataSource {
  Future<Either<Failure, String>> addLocation(LocationParams params);
  Future<Either<Failure, VoidResult>> updateLocation(LocationParams params);
  Future<Either<Failure, VoidResult>> deleteLocation(LocationParams params);
  Future<Either<Failure, Locations>> fetchAllLocations(String companyId);
}

@LazySingleton(as: LocationRemoteDataSource)
class LocationRemoteDataSourceImpl extends LocationRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  LocationRemoteDataSourceImpl({
    required this.firebaseFirestore,
  });

  @override
  Future<Either<Failure, String>> addLocation(LocationParams params) async {
    try {
      final locationsreference = firebaseFirestore
          .collection('companies')
          .doc(params.comapnyId)
          .collection('locations');
      final locationMap = (params.location as LocationModel).toMap();
      final documentReference = await locationsreference.add(locationMap);
      final String generatedLocationId = documentReference.id;
      return Right(generatedLocationId);
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> deleteLocation(
      LocationParams params) async {
    try {
      // checks assets in location
      final assetsInlocation = await firebaseFirestore
          .collection('companies')
          .doc(params.comapnyId)
          .collection('assets')
          .where('locationId', isEqualTo: params.location.id)
          .get();

      if (assetsInlocation.docs.isNotEmpty) {
        throw const DeleteException(message: 'assets');
      }
      // checks tasks in location
      final tasksInlocation = await firebaseFirestore
          .collection('companies')
          .doc(params.comapnyId)
          .collection('tasks')
          .where('locationId', isEqualTo: params.location.id)
          .get();

      if (tasksInlocation.docs.isNotEmpty) {
        throw const DeleteException(message: 'tasks');
      }
      // checks work requests in location
      final workRequestsInlocation = await firebaseFirestore
          .collection('companies')
          .doc(params.comapnyId)
          .collection('workRequests')
          .where('locationId', isEqualTo: params.location.id)
          .get();

      if (workRequestsInlocation.docs.isNotEmpty) {
        throw const DeleteException(message: 'tasks');
      }
      // checks items in location
      final itemsInlocation = await firebaseFirestore
          .collection('companies')
          .doc(params.comapnyId)
          .collection('items')
          .where('locations', arrayContains: params.location.id)
          .get();

      if (itemsInlocation.docs.isNotEmpty) {
        throw const DeleteException(message: 'items');
      }

      firebaseFirestore
          .collection('companies')
          .doc(params.comapnyId)
          .collection('locations')
          .doc(params.location.id)
          .delete();

      return Right(VoidResult());
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } on DeleteException catch (e) {
      return Left(
        DeleteFailure(message: e.message),
      );
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, Locations>> fetchAllLocations(String companyId) async {
    try {
      final Stream<QuerySnapshot> querySnapshot;
      querySnapshot = firebaseFirestore
          .collection('companies')
          .doc(companyId)
          .collection('locations')
          .snapshots();

      return Right(Locations(allLocations: querySnapshot));
    } on FirebaseException catch (e) {
      return Left(DatabaseFailure(message: e.message ?? 'DataBase Failure'));
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateLocation(
      LocationParams params) async {
    try {
      final documentReference = firebaseFirestore
          .collection('companies')
          .doc(params.comapnyId)
          .collection('locations')
          .doc(params.location.id);
      final locationMap = (params.location as LocationModel).toMap();
      await documentReference.update(locationMap);
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
