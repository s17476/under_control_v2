import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.avatarUrl,
    required super.userGroups,
    required super.locations,
    required super.companyId,
    required super.approved,
    required super.rejected,
    required super.suspended,
    required super.isActive,
    required super.administrator,
    required super.joinDate,
  });

  UserProfileModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? avatarUrl,
    List<String>? userGroups,
    List<String>? locations,
    String? companyId,
    bool? approved,
    bool? rejected,
    bool? suspended,
    bool? isActive,
    bool? administrator,
    DateTime? joinDate,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      userGroups: userGroups ?? this.userGroups,
      locations: locations ?? this.locations,
      companyId: companyId ?? this.companyId,
      approved: approved ?? this.approved,
      rejected: rejected ?? this.rejected,
      suspended: suspended ?? this.suspended,
      isActive: isActive ?? this.isActive,
      administrator: administrator ?? this.administrator,
      joinDate: joinDate ?? this.joinDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'email': email});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'avatarUrl': avatarUrl});
    result.addAll({'userGroups': userGroups});
    result.addAll({'locations': locations});
    result.addAll({'companyId': companyId});
    result.addAll({'approved': approved});
    result.addAll({'rejected': rejected});
    result.addAll({'suspended': suspended});
    result.addAll({'isActive': isActive});
    result.addAll({'administrator': administrator});
    result.addAll({'joinDate': joinDate});

    return result;
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map, String id) {
    DateTime? date;
    try {
      date = (map['joinDate'] as Timestamp).toDate();
    } catch (e) {
      date = DateTime.now();
    }
    return UserProfileModel(
      id: id,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
      userGroups: List<String>.from(map['userGroups']),
      locations: List<String>.from(map['locations']),
      companyId: map['companyId'] ?? '',
      approved: map['approved'] ?? false,
      rejected: map['rejected'] ?? false,
      suspended: map['suspended'] ?? false,
      isActive: map['isActive'] ?? false,
      administrator: map['administrator'] ?? false,
      joinDate: date,
    );
  }

  factory UserProfileModel.fromSnapshot(DocumentSnapshot snapshot) {
    final doc = snapshot.data() as Map<String, dynamic>;
    return UserProfileModel.fromMap(doc, snapshot.id);
  }

  factory UserProfileModel.newUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) {
    return UserProfileModel(
      id: '',
      firstName: firstName,
      lastName: lastName,
      email: '',
      phoneNumber: phoneNumber,
      avatarUrl: '',
      userGroups: const [],
      locations: const [],
      companyId: '',
      approved: false,
      rejected: false,
      suspended: false,
      isActive: false,
      administrator: false,
      joinDate: DateTime.now(),
    );
  }
}
