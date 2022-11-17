import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../groups/domain/entities/group.dart';
import '../../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../../../groups/presentation/widgets/group_management/group_tile.dart';

class SelectedGroupsList extends StatefulWidget {
  final Function(String) onSelected;
  final List<String> selectedGroups;

  const SelectedGroupsList({
    Key? key,
    required this.onSelected,
    required this.selectedGroups,
  }) : super(key: key);

  @override
  State<SelectedGroupsList> createState() => _SelectedGroupsListState();
}

class _SelectedGroupsListState extends State<SelectedGroupsList> {
  List<Group> _selectedGroups = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(
      builder: (context, state) {
        if (state is GroupLoadedState) {
          _selectedGroups = [];
          for (var grp in widget.selectedGroups) {
            final group = state.getGroupById(grp);
            if (group != null) {
              if (!_selectedGroups.contains(group)) {
                _selectedGroups.add(group);
              }
            }
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            itemCount: _selectedGroups.length,
            itemBuilder: (context, index) => GroupTile(
              key: ValueKey(_selectedGroups[index].id),
              group: _selectedGroups[index],
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
