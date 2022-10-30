import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/company.dart';

class CompanyModel extends Company {
  const CompanyModel({
    required super.id,
    required super.name,
    required super.address,
    required super.postCode,
    required super.city,
    required super.country,
    required super.currency,
    required super.vatNumber,
    required super.phoneNumber,
    required super.email,
    required super.homepage,
    required super.logo,
    required super.joinDate,
  });

  factory CompanyModel.initial() => CompanyModel(
        id: '',
        name: '',
        address: '',
        postCode: '',
        city: '',
        country: '',
        currency: '',
        vatNumber: '',
        phoneNumber: '',
        email: '',
        homepage: '',
        logo: '',
        joinDate: DateTime.now(),
      );

  CompanyModel copyWith({
    String? id,
    String? name,
    String? address,
    String? postCode,
    String? city,
    String? country,
    String? currency,
    String? vatNumber,
    String? phoneNumber,
    String? email,
    String? homepage,
    String? logo,
    DateTime? joinDate,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      postCode: postCode ?? this.postCode,
      city: city ?? this.city,
      country: country ?? this.country,
      currency: currency ?? this.currency,
      vatNumber: vatNumber ?? this.vatNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      homepage: homepage ?? this.homepage,
      logo: logo ?? this.logo,
      joinDate: joinDate ?? this.joinDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'address': address});
    result.addAll({'postCode': postCode});
    result.addAll({'city': city});
    result.addAll({'country': country});
    result.addAll({'currency': currency});
    result.addAll({'vatNumber': vatNumber});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'email': email});
    result.addAll({'homepage': homepage});
    result.addAll({'logo': logo});
    result.addAll({'joinDate': joinDate});

    return result;
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map, String id) {
    return CompanyModel(
      id: id,
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      postCode: map['postCode'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      currency: map['currency'] ?? '',
      vatNumber: map['vatNumber'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      homepage: map['homepage'] ?? '',
      logo: map['logo'] ?? '',
      joinDate: (map['joinDate'] as Timestamp).toDate(),
    );
  }
}
