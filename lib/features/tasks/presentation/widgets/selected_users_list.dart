import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../core/presentation/widgets/user_list_tile.dart';
import '../../../user_profile/domain/entities/user_profile.dart';

class SelectedUsersList extends StatefulWidget {
  final Function(String) onSelected;
  final List<String> selectedUsers;

  const SelectedUsersList({
    Key? key,
    required this.onSelected,
    required this.selectedUsers,
  }) : super(key: key);

  @override
  State<SelectedUsersList> createState() => _SelectedUsersListState();
}

class _SelectedUsersListState extends State<SelectedUsersList> {
  List<UserProfile> _selectedUsers = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
      builder: (context, state) {
        if (state is CompanyProfileLoaded) {
          _selectedUsers = [];
          for (var usr in widget.selectedUsers) {
            final user = state.getUserById(usr);
            if (user != null) {
              if (!_selectedUsers.contains(user)) {
                _selectedUsers.add(user);
              }
            }
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            itemCount: _selectedUsers.length,
            itemBuilder: (context, index) => UserListTile(
              key: ValueKey(_selectedUsers[index].id),
              user: _selectedUsers[index],
              onTap: (userProfile) => widget.onSelected(
                userProfile.id,
              ),
              isGroupMember: true,
              isSelectionTile: true,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
