import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/error/exceptions.dart';

import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart';
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart';
import 'package:under_control_v2/features/locations/domain/entities/locations.dart';
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl extends LocationRepository {
  final LocationLocalDataSource locationLocalDataSource;
  final LocationRemoteDataSource locationRemoteDataSource;

  LocationRepositoryImpl({
    required this.locationLocalDataSource,
    required this.locationRemoteDataSource,
  });

  @override
  Future<Either<Failure, String>> addLocation(LocationParams params) {
    // TODO: implement addLocation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, VoidResult>> deleteLocation(LocationParams params) {
    // TODO: implement deleteLocation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Locations>> fetchAllLocations(String companyId) {
    // TODO: implement fetchAllLocations
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> tryToGetCachedLocation() {
    // TODO: implement tryToGetCachedLocation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, VoidResult>> updateLocation(LocationParams params) {
    // TODO: implement updateLocation
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, VoidResult>> cacheLocation(
      LocationParams params) async {
    try {
      locationLocalDataSource.cacheLocation(params.location.id);
      return Right(VoidResult());
    } on CacheException catch (e) {
      return const Left(CacheFailure());
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }
}
