import 'package:dartz/dartz.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/companies.dart';
import 'package:under_control_v2/features/locations/domain/entities/locations.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/location_repository.dart';

class FetchAllLocations extends FutureUseCase<Locations, NoParams> {
  final LocationRepository locationRepository;

  FetchAllLocations({
    required this.locationRepository,
  });

  @override
  Future<Either<Failure, Locations>> call(NoParams params) async =>
      locationRepository.fetchAllLocations();
}
