import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/location.dart';
import '../entities/locations.dart';

abstract class LocationRepository {
  Future<Either<Failure, String>> addLocation(Location location);
  Future<Either<Failure, VoidResult>> updateLocation(Location location);
  Future<Either<Failure, VoidResult>> deleteLocation(String locationId);
  Future<Either<Failure, String>> tryToGetCachedLocation();
  Future<Either<Failure, Locations>> fetchAllLocations();
}
