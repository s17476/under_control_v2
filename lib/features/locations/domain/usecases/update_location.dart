import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/location_repository.dart';

@lazySingleton
class UpdateLocation extends FutureUseCase<VoidResult, LocationParams> {
  final LocationRepository locationRepository;

  UpdateLocation({
    required this.locationRepository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(LocationParams params) async =>
      locationRepository.updateLocation(params);
}
