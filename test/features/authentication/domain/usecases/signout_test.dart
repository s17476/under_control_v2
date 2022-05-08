import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:under_control_v2/features/authentication/domain/usecases/signout.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late Signout usecase;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    usecase = Signout(authenticationRepository: mockAuthenticationRepository);
  });

  NoParams noParams = NoParams();

  test(
    'should only call signout method in repository',
    () async {
      // arrange
      when(() => mockAuthenticationRepository.signout())
          .thenAnswer((_) async => Right(Future.value()));
      // act
      await usecase(noParams);
      // assert

      verify(
        () => mockAuthenticationRepository.signout(),
      );
      verifyNoMoreInteractions(mockAuthenticationRepository);
    },
  );
}
