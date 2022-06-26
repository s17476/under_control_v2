import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/location.dart';
import '../repositories/location_repository.dart';

class AddLocation extends FutureUseCase<String, Location> {
  final LocationRepository locationRepository;

  AddLocation({
    required this.locationRepository,
  });

  @override
  Future<Either<Failure, String>> call(Location params) async =>
      locationRepository.addLocation(params);
}
