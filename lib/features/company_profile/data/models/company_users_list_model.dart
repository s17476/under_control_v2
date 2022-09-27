import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/company_users_list.dart';
import '../../../user_profile/data/models/user_profile_model.dart';
import '../../../user_profile/domain/entities/user_profile.dart';

class CompanyUsersListModel extends CompanyUsersList {
  const CompanyUsersListModel({
    required super.activeUsers,
    required super.passiveUsers,
  });

  Future<int> get activeUsersCount async => activeUsers.length;

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

    return CompanyUsersListModel(
      activeUsers: usersList.where((user) => user.isActive).toList(),
      passiveUsers: usersList.where((user) => !user.isActive).toList(),
    );
  }
}
