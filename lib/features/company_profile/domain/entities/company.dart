import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String id;
  final String name;
  final String address;
  final String postCode;
  final String city;
  final String country;
  final String vatNumber;
  final DateTime joinDate;

  const Company({
    required this.id,
    required this.name,
    required this.address,
    required this.postCode,
    required this.city,
    required this.country,
    required this.vatNumber,
    required this.joinDate,
  });

  @override
  List<Object> get props => [
        id,
        name,
        address,
        postCode,
        city,
        country,
        vatNumber,
        joinDate,
      ];

  @override
  String toString() {
    return 'Company(id: $id, name: $name, address: $address, postCode: $postCode, city: $city, country: $country, vatNumber: $vatNumber, joinDate: $joinDate)';
  }
}
