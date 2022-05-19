import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company_user.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company_users.dart';
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart';

class MockCompanyRepository extends Mock implements CompanyRepository {}

void main() {
  late FetchAllCompanyUsers usecase;
  late MockCompanyRepository mockCompanyRepository;

  setUp(
    () {
      mockCompanyRepository = MockCompanyRepository();
      usecase = FetchAllCompanyUsers(companyRepository: mockCompanyRepository);
    },
  );

  const tCompanyUser = CompanyUser(
    id: 'id',
    firstName: 'firstName',
    lastName: 'lastName',
    avatarUrl: 'avatarUrl',
  );

  const tCompanyUsers = [tCompanyUser];

  test(
    'should return [CompanyUsers] from repository when fetch all company users usecase is called',
    () async {
      // arrange
      when(
        () => mockCompanyRepository.fetchAllCompanyUsers(any()),
      ).thenAnswer(
          (_) async => const Right(CompanyUsers(allUsers: tCompanyUsers)));
      // act
      await usecase('');
      // assert
      verify(() => mockCompanyRepository.fetchAllCompanyUsers(''));
      verifyNoMoreInteractions(mockCompanyRepository);
    },
  );
}
