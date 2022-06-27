import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String id;
  final String name;
  final String parentId;
  final String? address;
  final String? postCode;
  final String? city;
  final String? country;

  const Location({
    required this.id,
    required this.name,
    required this.parentId,
    this.address,
    this.postCode,
    this.city,
    this.country,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      parentId,
    ];
  }

  @override
  String toString() {
    return 'Location(id: $id, name: $name, parentId: $parentId, address: $address, postCode: $postCode, city: $city, country: $country)';
  }
}
