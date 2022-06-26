import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/location_repository.dart';

class DeleteLocation extends FutureUseCase<VoidResult, String> {
  final LocationRepository locationRepository;

  DeleteLocation({
    required this.locationRepository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(String params) async =>
      locationRepository.deleteLocation(params);
}
