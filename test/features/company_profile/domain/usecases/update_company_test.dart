import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_model.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';
import 'package:under_control_v2/features/company_profile/domain/repositories/company_repository.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockCompanyRepository extends Mock implements CompanyRepository {}

void main() {
  late UpdateCompany usecase;
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
      usecase = UpdateCompany(companyRepository: mockCompanyRepository);
    },
  );

  test(
    'Company Profile should return [VoidResult] from repository when update company usecase is called',
    () async {
      // arrange
      when(
        () => mockCompanyRepository.updateCompany(any()),
      ).thenAnswer((_) async => Right(VoidResult()));
      // act
      final result = await usecase(tCompanyModel);
      // assert
      verify(() => mockCompanyRepository.updateCompany(tCompanyModel));
      verifyNoMoreInteractions(mockCompanyRepository);
      expect(result, isA<Right<Failure, VoidResult>>());
    },
  );
}
