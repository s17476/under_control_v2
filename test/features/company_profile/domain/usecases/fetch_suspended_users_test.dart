import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company_users.dart';
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_suspended_users.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/user_profile/data/models/user_profile_model.dart';

class MockCompanyRepository extends Mock implements CompanyRepository {}

void main() {
  late FetchSuspendedUsers usecase;
  late MockCompanyRepository mockCompanyRepository;

  setUp(
    () {
      mockCompanyRepository = MockCompanyRepository();
      usecase = FetchSuspendedUsers(companyRepository: mockCompanyRepository);
    },
  );

  final tCompanyUser = UserProfileModel.newUser(
    firstName: 'firstName',
    lastName: 'lastName',
    phoneNumber: 'phoneNumber',
  );

  final tCompanyUsers = [tCompanyUser];

  test(
    'Company Profile should return [CompanyUsers] from repository when FetchSuspendedUsers usecase is called',
    () async {
      // arrange
      when(
        () => mockCompanyRepository.fetchSuspendedUsers(any()),
      ).thenAnswer((_) async =>
          Right(CompanyUsers(allUsers: Stream.fromIterable(tCompanyUsers))));
      // act
      final result = await usecase('');
      // assert
      verify(() => mockCompanyRepository.fetchSuspendedUsers(''));
      verifyNoMoreInteractions(mockCompanyRepository);
      expect(result, isA<Right<Failure, CompanyUsers>>());
    },
  );
}
