import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String id;
  final String name;
  final String parentId;
  final List<String> children;
  final String? address;
  final String? postCode;
  final String? city;
  final String? country;

  const Location({
    required this.id,
    required this.name,
    required this.parentId,
    required this.children,
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
      children,
    ];
  }

  @override
  String toString() {
    return 'Location(id: $id, name: $name, parentId: $parentId, children: $children, address: $address, postCode: $postCode, city: $city, country: $country)';
  }
}
