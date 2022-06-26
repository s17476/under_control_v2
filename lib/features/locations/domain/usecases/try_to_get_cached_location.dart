import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/location_repository.dart';

@lazySingleton
class TryToGetCachedLocation extends FutureUseCase<String, NoParams> {
  final LocationRepository locationRepository;

  TryToGetCachedLocation({
    required this.locationRepository,
  });

  @override
  Future<Either<Failure, String>> call(NoParams params) async =>
      locationRepository.tryToGetCachedLocation();
}
