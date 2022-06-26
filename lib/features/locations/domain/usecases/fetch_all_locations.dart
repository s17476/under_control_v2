import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/locations.dart';
import '../repositories/location_repository.dart';

@lazySingleton
class FetchAllLocations extends FutureUseCase<Locations, String> {
  final LocationRepository locationRepository;

  FetchAllLocations({
    required this.locationRepository,
  });

  @override
  Future<Either<Failure, Locations>> call(String params) async =>
      locationRepository.fetchAllLocations(params);
}
