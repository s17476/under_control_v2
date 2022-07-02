import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/location_repository.dart';

@lazySingleton
class TryToGetCachedLocation
    extends FutureUseCase<SelectedLocationsParams, NoParams> {
  final LocationRepository locationRepository;

  TryToGetCachedLocation({
    required this.locationRepository,
  });

  @override
  Future<Either<Failure, SelectedLocationsParams>> call(
          NoParams params) async =>
      locationRepository.tryToGetCachedLocation();
}
