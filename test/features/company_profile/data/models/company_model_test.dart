import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:under_control_v2/features/company_profile/data/models/company_model.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';

void main() {
  final dateTime = DateTime.now();
  final tCompanyModel = CompanyModel(
    id: 'id',
    name: 'name',
    address: 'address',
    postCode: 'postCode',
    city: 'city',
    country: 'country',
    currency: 'currency',
    vatNumber: 'vatNumber',
    phoneNumber: 'phoneNumber',
    email: 'email',
    homepage: 'homepage',
    logo: 'logo',
    joinDate: dateTime,
  );
  final Map<String, dynamic> tCompanyToModelMap = {
    'name': 'name',
    'address': 'address',
    'postCode': 'postCode',
    'city': 'city',
    'country': 'country',
    'currency': 'currency',
    'vatNumber': 'vatNumber',
    'phoneNumber': 'phoneNumber',
    'email': 'email',
    'homepage': 'homepage',
    'logo': 'logo',
    'joinDate': dateTime
  };
  final Map<String, dynamic> tCompanyFromModelMap = {
    'name': 'name',
    'address': 'address',
    'postCode': 'postCode',
    'city': 'city',
    'country': 'country',
    'currency': 'currency',
    'vatNumber': 'vatNumber',
    'phoneNumber': 'phoneNumber',
    'email': 'email',
    'homepage': 'homepage',
    'logo': 'logo',
    'joinDate': Timestamp.fromDate(dateTime)
  };
  group('Company Profile', () {
    test(
      'should be a subclass of [Company] entity',
      () async {
        // assert
        expect(tCompanyModel, isA<Company>());
      },
    );

    test(
      'should return a valid model from a map',
      () async {
        // act
        final result =
            CompanyModel.fromMap(tCompanyFromModelMap, tCompanyModel.id);
        // assert
        expect(result, tCompanyModel);
      },
    );

    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tCompanyModel.toMap();
        // assert
        expect(result, tCompanyToModelMap);
      },
    );
  });
}
