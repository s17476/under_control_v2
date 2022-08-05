import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String avatarUrl,
    required List<String> userGroups,
    required List<String> locations,
    required String companyId,
    required bool approved,
    required bool rejected,
    required bool suspended,
    required bool administrator,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          email: email,
          phoneNumber: phoneNumber,
          avatarUrl: avatarUrl,
          userGroups: userGroups,
          locations: locations,
          companyId: companyId,
          approved: approved,
          rejected: rejected,
          suspended: suspended,
          administrator: administrator,
        );

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
    bool? administrator,
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
      administrator: administrator ?? this.administrator,
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
    result.addAll({'administrator': administrator});

    return result;
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map, String id) {
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
      administrator: map['administrator'] ?? false,
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
      administrator: false,
    );
  }
}
