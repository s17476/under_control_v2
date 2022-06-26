import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/location_repository.dart';

class TryToGetCachedLocation extends FutureUseCase<String, NoParams> {
  final LocationRepository locationRepository;

  TryToGetCachedLocation({
    required this.locationRepository,
  });

  @override
  Future<Either<Failure, String>> call(NoParams params) async =>
      locationRepository.tryToGetCachedLocation();
}
