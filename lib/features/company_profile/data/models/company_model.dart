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
    required String phoneNumber,
    required String email,
    required String homepage,
    required DateTime joinDate,
  }) : super(
          id: id,
          name: name,
          address: address,
          postCode: postCode,
          city: city,
          country: country,
          vatNumber: vatNumber,
          phoneNumber: phoneNumber,
          email: email,
          homepage: homepage,
          joinDate: joinDate,
        );

  factory CompanyModel.initial() => CompanyModel(
        id: '',
        name: '',
        address: '',
        postCode: '',
        city: '',
        country: '',
        vatNumber: '',
        phoneNumber: '',
        email: '',
        homepage: '',
        joinDate: DateTime.now(),
      );

  CompanyModel copyWith({
    String? id,
    String? name,
    String? address,
    String? postCode,
    String? city,
    String? country,
    String? vatNumber,
    String? phoneNumber,
    String? email,
    String? homepage,
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
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      homepage: homepage ?? this.homepage,
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
    result.addAll({'vatNumber': vatNumber});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'email': email});
    result.addAll({'homepage': homepage});
    result.addAll({'joinDate': joinDate.toIso8601String()});

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
      vatNumber: map['vatNumber'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      email: map['email'] ?? '',
      homepage: map['homepage'] ?? '',
      joinDate: DateTime.parse(map['joinDate']),
    );
  }
}
