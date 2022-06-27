import '../../domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel({
    required super.id,
    required super.name,
    required super.parentId,
    super.address,
    super.postCode,
    super.city,
    super.country,
  });

  factory LocationModel.initial() => const LocationModel(
        id: '',
        name: '',
        parentId: '',
      );

  LocationModel copyWith({
    String? id,
    String? name,
    String? parentId,
    String? address,
    String? postCode,
    String? city,
    String? country,
  }) {
    return LocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      address: address ?? this.address,
      postCode: postCode ?? this.postCode,
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'parentId': parentId});
    if (address != null) {
      result.addAll({'address': address});
    }
    if (postCode != null) {
      result.addAll({'postCode': postCode});
    }
    if (city != null) {
      result.addAll({'city': city});
    }
    if (country != null) {
      result.addAll({'country': country});
    }

    return result;
  }

  factory LocationModel.fromMap(Map<String, dynamic> map, String id) {
    return LocationModel(
      id: id,
      name: map['name'] ?? '',
      parentId: map['parentId'] ?? '',
      address: map['address'],
      postCode: map['postCode'],
      city: map['city'],
      country: map['country'],
    );
  }
}
