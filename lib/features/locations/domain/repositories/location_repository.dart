import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/locations.dart';

abstract class LocationRepository {
  Future<Either<Failure, String>> addLocation(LocationParams params);
  Future<Either<Failure, VoidResult>> updateLocation(LocationParams params);
  Future<Either<Failure, VoidResult>> deleteLocation(LocationParams params);
  Future<Either<Failure, VoidResult>> cacheLocation(LocationParams params);
  Future<Either<Failure, String>> tryToGetCachedLocation();
  Future<Either<Failure, Locations>> fetchAllLocations(String companyId);
}
