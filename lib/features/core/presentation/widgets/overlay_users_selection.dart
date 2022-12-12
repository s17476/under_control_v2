import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../utils/responsive_size.dart';
import 'custom_text_form_field.dart';
import 'glass_layer.dart';
import 'shimmer_user_list_tile.dart';
import 'user_list_tile.dart';

class OverlayUsersSelection extends StatefulWidget {
  const OverlayUsersSelection({
    Key? key,
    required this.assignedUsers,
    required this.toggleUserSelection,
    required this.onDismiss,
  }) : super(key: key);

  final List<String> assignedUsers;
  final Function(String) toggleUserSelection;
  final Function() onDismiss;

  @override
  State<OverlayUsersSelection> createState() => _OverlayUsersSelectionState();
}

class _OverlayUsersSelectionState extends State<OverlayUsersSelection>
    with ResponsiveSize {
  List<UserProfile>? _users;

  String _searchQuery = '';

  final _searchTextEditingController = TextEditingController();

  void _clearSearchQuery() {
    _searchTextEditingController.text = '';
    FocusScope.of(context).unfocus();
    setState(() {
      _searchQuery = '';
    });
  }

  // search users according to given query string
  List<UserProfile> _searchUsers(
      BuildContext context, List<UserProfile> allUsers, String searchQuery) {
    if (searchQuery.trim().isNotEmpty) {
      return allUsers
          .where(
            (user) =>
                user.firstName
                    .toLowerCase()
                    .contains(searchQuery.trim().toLowerCase()) ||
                user.lastName
                    .toLowerCase()
                    .contains(searchQuery.trim().toLowerCase()),
          )
          .toList();
    }
    return allUsers;
  }

  @override
  void dispose() {
    _searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _users = null;
    List<String> groups = [];
    final groupsState = context.watch<GroupBloc>().state;
    // gets groups (id's) with premission to create tasks
    if (groupsState is GroupLoadedState) {
      groups = groupsState.allGroups.allGroups
          .where((group) {
            final taskFeature = group.features
                .firstWhere((feature) => feature.type == FeatureType.tasks);
            return taskFeature.create;
          })
          .map((group) => group.id)
          .toList();
    }
    final companyState = context.watch<CompanyProfileBloc>().state;
    if (companyState is CompanyProfileLoaded) {
      for (var usr in companyState.allUsers.where((usr) => usr.isActive)) {
        if (usr.administrator) {
          if (_users == null) {
            _users = [usr];
          } else if (!_users!.contains(usr)) {
            _users!.add(usr);
          }
        } else {
          for (var userGroup in usr.userGroups) {
            if (groups.contains(userGroup)) {
              if (_users == null) {
                _users = [usr];
              } else if (!_users!.contains(usr)) {
                _users!.add(usr);
              }
            }
          }
        }
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GlassLayer(
        onDismiss: widget.onDismiss,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.task_assign_users,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const Divider(),
                  // search field
                  CustomTextFormField(
                    fieldKey: 'search',
                    controller: _searchTextEditingController,
                    keyboardType: TextInputType.name,
                    labelText: AppLocalizations.of(context)!.search,
                    onChanged: (value) => setState(() {
                      _searchQuery = value!;
                    }),
                    suffixIcon: InkWell(
                      onTap: () => _clearSearchQuery(),
                      child: const Icon(
                        Icons.cancel,
                      ),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: _users != null
                        ? Builder(builder: (context) {
                            final filteredUsers = _searchUsers(
                              context,
                              _users!,
                              _searchQuery,
                            );
                            return ListView.builder(
                              padding: const EdgeInsets.only(bottom: 50),
                              shrinkWrap: true,
                              itemCount: filteredUsers.length,
                              itemBuilder: (context, index) => UserListTile(
                                key: ValueKey(filteredUsers[index].id),
                                user: filteredUsers[index],
                                onTap: (userProfile) =>
                                    widget.toggleUserSelection(userProfile.id),
                                isSelectionTile: true,
                                isGroupMember: widget.assignedUsers
                                    .contains(filteredUsers[index].id),
                                searchQuery: _searchQuery,
                              ),
                            );
                          })
                        : ListView.builder(
                            padding: const EdgeInsets.only(bottom: 50),
                            shrinkWrap: true,
                            itemCount: 20,
                            itemBuilder: (context, index) => const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: ShimmerUserListTile(),
                            ),
                          ),
                  ),
                  Container(),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                onPressed:
                    widget.assignedUsers.isNotEmpty ? widget.onDismiss : null,
                icon: const Icon(Icons.done),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
