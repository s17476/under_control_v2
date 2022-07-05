// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:under_control_v2/features/core/error/failures.dart';
// import 'package:under_control_v2/features/core/usecases/usecase.dart';
// import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart';
// import 'package:under_control_v2/features/locations/domain/usecases/try_to_get_cached_location.dart';

// class MockLocationRepository extends Mock implements LocationRepository {}

// void main() {
//   late LocationRepository repository;
//   late TryToGetCachedLocation usecase;

//   setUp(
//     () {
//       repository = MockLocationRepository();
//       usecase = TryToGetCachedLocation(locationRepository: repository);
//     },
//   );

//   test(
//     'should return [String] from repisitory when TryToGetCachedLocation is called',
//     () async {
//       // arrange
//       when(() => repository.tryToGetCachedLocation())
//           .thenAnswer((_) async => const Right(''));
//       // act
//       final result = await usecase(NoParams());
//       // assert
//       expect(result, isA<Right<Failure, String>>());
//     },
//   );
// }
