import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/location_repository.dart';

@lazySingleton
class CacheLocation extends FutureUseCase<VoidResult, SelectedLocationsParams> {
  final LocationRepository locationRepository;

  CacheLocation({
    required this.locationRepository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(
          SelectedLocationsParams params) async =>
      locationRepository.cacheSelectedLocations(params);
}
