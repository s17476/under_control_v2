import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../domain/entities/locations.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_local_data_source.dart';
import '../datasources/location_remote_data_source.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl extends LocationRepository {
  final LocationLocalDataSource locationLocalDataSource;
  final LocationRemoteDataSource locationRemoteDataSource;

  LocationRepositoryImpl({
    required this.locationLocalDataSource,
    required this.locationRemoteDataSource,
  });

  @override
  Future<Either<Failure, String>> addLocation(LocationParams params) =>
      locationRemoteDataSource.addLocation(params);

  @override
  Future<Either<Failure, VoidResult>> deleteLocation(LocationParams params) =>
      locationRemoteDataSource.deleteLocation(params);

  @override
  Future<Either<Failure, Locations>> fetchAllLocations(String companyId) =>
      locationRemoteDataSource.fetchAllLocations(companyId);

  @override
  Future<Either<Failure, String>> tryToGetCachedLocation() async {
    try {
      final cachedLocation = await locationLocalDataSource.getCachedLocation();
      return Right(cachedLocation);
    } on CacheException {
      return const Left(CacheFailure());
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }

  @override
  Future<Either<Failure, VoidResult>> updateLocation(LocationParams params) =>
      locationRemoteDataSource.updateLocation(params);

  @override
  Future<Either<Failure, VoidResult>> cacheLocation(
      LocationParams params) async {
    try {
      locationLocalDataSource.cacheLocation(params.location.id);
      return Right(VoidResult());
    } on CacheException {
      return const Left(CacheFailure());
    } catch (e) {
      return const Left(
        UnsuspectedFailure(message: 'Unsuspected error'),
      );
    }
  }
}
