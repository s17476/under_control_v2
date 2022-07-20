import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_model.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart';
import 'package:under_control_v2/features/core/error/failures.dart';

class MockCompanyRepository extends Mock implements CompanyRepository {}

void main() {
  late GetCompanyById usecase;
  late MockCompanyRepository mockCompanyRepository;

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
      Company(
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
      mockCompanyRepository = MockCompanyRepository();
      usecase = GetCompanyById(companyRepository: mockCompanyRepository);
    },
  );

  test(
    'Company Profile should return [Company] from repository when get company by id usecase is called',
    () async {
      // arrange
      when(
        () => mockCompanyRepository.getCompanyById(any()),
      ).thenAnswer((_) async => Right(tCompanyModel));
      // act
      final result = await usecase('id');
      // assert
      verify(() => mockCompanyRepository.getCompanyById('id'));
      verifyNoMoreInteractions(mockCompanyRepository);
      expect(result, isA<Right<Failure, Company>>());
    },
  );
}
