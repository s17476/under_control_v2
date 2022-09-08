import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/company_profile/domain/repositories/company_management_repository.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockCompanyManagementRepository extends Mock
    implements CompanyManagementRepository {}

void main() {
  late AddCompanyLogo usecase;
  late MockCompanyManagementRepository repository;

  setUp(
    () {
      repository = MockCompanyManagementRepository();
      usecase = AddCompanyLogo(repository: repository);
    },
  );

  setUpAll(() {
    registerFallbackValue(AvatarParams(id: 'userId', avatar: File('')));
  });

  File file = File('assets/undercontrol-adaptine.png');

  test(
    'Company Profile should return [String] from repository when AddCompanyLogo is called',
    () async {
      // arrange
      when(() => repository.addCompanyLogo(any()))
          .thenAnswer((_) async => const Right(''));
      // act
      final result = await usecase(AvatarParams(id: 'userId', avatar: file));
      // assert
      expect(result, const Right<Failure, String>(''));
    },
  );
}
