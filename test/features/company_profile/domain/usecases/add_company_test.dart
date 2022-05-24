import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_model.dart';
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart';
import 'package:under_control_v2/features/core/error/failures.dart';

class MockCompanyManagementRepository extends Mock
    implements CompanyManagementRepository {}

void main() {
  late AddCompany usecase;
  late MockCompanyManagementRepository mockCompanyRepository;

  final tCompanyModel = CompanyModel(
    id: 'id',
    name: 'name',
    address: 'address',
    postCode: 'postCode',
    city: 'city',
    country: 'country',
    vatNumber: 'vatNumber',
    phoneNumber: 'phoneNumber',
    email: 'email',
    homepage: 'homepage',
    logo: 'logo',
    joinDate: DateTime.now(),
  );

  setUpAll(() {
    registerFallbackValue(
      CompanyModel(
        id: 'id',
        name: 'name',
        address: 'address',
        postCode: 'postCode',
        city: 'city',
        country: 'country',
        vatNumber: 'vatNumber',
        phoneNumber: 'phoneNumber',
        email: 'email',
        homepage: 'homepage',
        logo: 'logo',
        joinDate: DateTime.now(),
      ),
    );
  });

  setUp(
    () {
      mockCompanyRepository = MockCompanyManagementRepository();
      usecase = AddCompany(companyManagementRepository: mockCompanyRepository);
    },
  );

  test(
    'should return [String] from repository when add company usecase is called',
    () async {
      // arrange
      when(
        () => mockCompanyRepository.addCompany(any()),
      ).thenAnswer((_) async => const Right(''));
      // act
      final result = await usecase(tCompanyModel);
      // assert
      verify(() => mockCompanyRepository.addCompany(tCompanyModel));
      verifyNoMoreInteractions(mockCompanyRepository);
      expect(result, isA<Right<Failure, String>>());
    },
  );
}
