import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/company_users_list.dart';
import '../../../user_profile/data/models/user_profile_model.dart';
import '../../../user_profile/domain/entities/user_profile.dart';

class CompanyUsersListModel extends CompanyUsersList {
  const CompanyUsersListModel({
    required super.allUsers,
  });

  Future<int> get allUsersCount async => allUsers.length;

  factory CompanyUsersListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<UserProfile> usersList = [];
    usersList = snapshot.docs
        .map(
          (DocumentSnapshot doc) => UserProfileModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList();

    return CompanyUsersListModel(allUsers: usersList);
  }
}
