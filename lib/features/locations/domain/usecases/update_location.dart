import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/location.dart';
import '../repositories/location_repository.dart';

class UpdateLocation extends FutureUseCase<VoidResult, Location> {
  final LocationRepository locationRepository;

  UpdateLocation({
    required this.locationRepository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(Location params) async =>
      locationRepository.updateLocation(params);
}
