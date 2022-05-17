import 'dart:convert';

import '../../domain/entities/company.dart';

class CompanyModel extends Company {
  const CompanyModel({
    required String id,
    required String name,
    required String address,
    required String postCode,
    required String city,
    required String country,
    required String vatNumber,
    required DateTime joinDate,
  }) : super(
          id: id,
          name: name,
          address: address,
          postCode: postCode,
          city: city,
          country: country,
          vatNumber: vatNumber,
          joinDate: joinDate,
        );

  CompanyModel copyWith({
    String? id,
    String? name,
    String? address,
    String? postCode,
    String? city,
    String? country,
    String? vatNumber,
    DateTime? joinDate,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      postCode: postCode ?? this.postCode,
      city: city ?? this.city,
      country: country ?? this.country,
      vatNumber: vatNumber ?? this.vatNumber,
      joinDate: joinDate ?? this.joinDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'address': address});
    result.addAll({'postCode': postCode});
    result.addAll({'city': city});
    result.addAll({'country': country});
    result.addAll({'vatNumber': vatNumber});
    result.addAll({'joinDate': joinDate.toIso8601String()});

    return result;
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      postCode: map['postCode'] ?? '',
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      vatNumber: map['vatNumber'] ?? '',
      joinDate: DateTime.parse(map['joinDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromMap(json.decode(source));
}
