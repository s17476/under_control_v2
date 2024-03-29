import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../groups/domain/entities/group.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../utils/responsive_size.dart';
import '../../utils/size_config.dart';
import 'glass_layer.dart';
import 'user_list_tile.dart';

class AddMembersCard extends StatefulWidget {
  const AddMembersCard({
    Key? key,
    required this.group,
    required this.onToggleUserSelection,
    required this.onDismiss,
  }) : super(key: key);

  final Group group;
  final VoidCallback onDismiss;
  final Function(BuildContext context, Group group, UserProfile user)
      onToggleUserSelection;

  @override
  State<AddMembersCard> createState() => _AddMembersCardState();
}

class _AddMembersCardState extends State<AddMembersCard> with ResponsiveSize {
  List<UserProfile> _allUsers = [];
  late UserProfile _currentUser;

  void _toggleUser(UserProfile user) {
    widget.onToggleUserSelection(context, widget.group, user);
  }

  @override
  void didChangeDependencies() {
    final companyState = context.watch<CompanyProfileBloc>().state;
    if (companyState is CompanyProfileLoaded) {
      _allUsers = companyState.companyUsers.activeUsers;
    }
    _currentUser =
        (context.read<UserProfileBloc>().state as Approved).userProfile;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GlassLayer(
      onDismiss: widget.onDismiss,
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _allUsers.length,
              itemBuilder: (context, index) {
                return UserListTile(
                  user: _allUsers[index],
                  onTap: _currentUser.administrator
                      ? _toggleUser
                      : _currentUser.id == _allUsers[index].id
                          ? (UserProfile _) {}
                          : _toggleUser,
                  isSelectionTile: (_allUsers[index].id != _currentUser.id) ||
                      _currentUser.administrator,
                  isGroupMember:
                      _allUsers[index].userGroups.contains(widget.group.id),
                  isGroupAdministrator: widget.group.groupAdministrators
                      .contains(_allUsers[index].id),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
