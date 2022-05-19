import 'package:under_control_v2/features/company_profile/domain/entities/company_user.dart';

class CompanyUserModel extends CompanyUser {
  const CompanyUserModel({
    required String id,
    required String firstName,
    required String lastName,
    required String avatarUrl,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          avatarUrl: avatarUrl,
        );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'avatarUrl': avatarUrl});

    return result;
  }

  factory CompanyUserModel.fromMap(Map<String, dynamic> map) {
    return CompanyUserModel(
      id: map['id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      avatarUrl: map['avatarUrl'] ?? '',
    );
  }
}
