import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/widgets/glass_layer.dart';
import '../../../groups/domain/entities/group.dart';
import '../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../../groups/presentation/widgets/group_management/group_tile.dart';
import '../../../user_profile/domain/entities/user_profile.dart';

class ManageGroupsCard extends StatefulWidget {
  const ManageGroupsCard({
    Key? key,
    required this.user,
    required this.onDismiss,
    required this.onToggleGroupSelection,
  }) : super(key: key);

  final UserProfile user;
  final VoidCallback onDismiss;
  final Function(BuildContext context, Group group, UserProfile user)
      onToggleGroupSelection;

  @override
  State<ManageGroupsCard> createState() => _ManageGroupsCardState();
}

class _ManageGroupsCardState extends State<ManageGroupsCard> {
  List<Group> allGroups = [];

  void toggleGroup(Group group) {
    widget.onToggleGroupSelection(context, group, widget.user);
  }

  @override
  void didChangeDependencies() {
    final groupState = context.watch<GroupBloc>().state;
    if (groupState is GroupLoadedState) {
      allGroups = groupState.allGroups.allGroups;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GlassLayer(
      onDismiss: widget.onDismiss,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: allGroups.length,
                    itemBuilder: (context, index) {
                      return GroupTile(
                        group: allGroups[index],
                        isSelectionTile: true,
                        isGroupMember: widget.user.userGroups.contains(
                          allGroups[index].id,
                        ),
                        onTap: toggleGroup,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
