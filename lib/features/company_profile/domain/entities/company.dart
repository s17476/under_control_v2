import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String id;
  final String name;
  final String address;
  final String postCode;
  final String city;
  final String country;
  final String currency;
  final String vatNumber;
  final String phoneNumber;
  final String email;
  final String homepage;
  final String logo;
  final DateTime joinDate;

  const Company({
    required this.id,
    required this.name,
    required this.address,
    required this.postCode,
    required this.city,
    required this.country,
    required this.currency,
    required this.vatNumber,
    required this.phoneNumber,
    required this.email,
    required this.homepage,
    required this.logo,
    required this.joinDate,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      address,
      postCode,
      city,
      country,
      currency,
      vatNumber,
      phoneNumber,
      email,
      homepage,
      logo,
      joinDate,
    ];
  }

  @override
  String toString() {
    return 'Company(id: $id, name: $name, address: $address, postCode: $postCode, city: $city, country: $country, currency: $currency, vatNumber: $vatNumber, phoneNumber: $phoneNumber, email: $email, homepage: $homepage, logo: $logo, joinDate: $joinDate)';
  }
}
