import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/location_repository.dart';

@lazySingleton
class AddLocation extends FutureUseCase<String, LocationParams> {
  final LocationRepository locationRepository;

  AddLocation({
    required this.locationRepository,
  });

  @override
  Future<Either<Failure, String>> call(LocationParams params) async =>
      locationRepository.addLocation(params);
}
