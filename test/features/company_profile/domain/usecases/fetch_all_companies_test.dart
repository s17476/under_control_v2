import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/company_profile/data/models/company_model.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/companies.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';
import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockCompanyManagementRepository extends Mock
    implements CompanyManagementRepository {}

void main() {
  late FetchAllCompanies usecase;
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
      mockCompanyRepository = MockCompanyManagementRepository();
      usecase =
          FetchAllCompanies(companyManagementRepository: mockCompanyRepository);
    },
  );

  test(
    'Company Profile should return [Companies] from repository when fetch all companies usecase is called',
    () async {
      // arrange
      when(
        () => mockCompanyRepository.fetchAllCompanies(),
      ).thenAnswer(
          (_) async => Right(Companies(allCompanies: [tCompanyModel])));
      // act
      final result = await usecase(NoParams());
      // assert
      verify(() => mockCompanyRepository.fetchAllCompanies());
      verifyNoMoreInteractions(mockCompanyRepository);
      expect(result, isA<Right<Failure, Companies>>());
    },
  );
}
