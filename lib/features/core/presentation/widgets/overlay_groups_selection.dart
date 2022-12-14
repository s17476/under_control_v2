import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/groups/domain/entities/group.dart';
import 'package:under_control_v2/features/groups/presentation/widgets/group_management/group_tile.dart';

import '../../../groups/domain/entities/feature.dart';
import '../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../utils/responsive_size.dart';
import 'custom_text_form_field.dart';
import 'glass_layer.dart';
import 'shimmer_user_list_tile.dart';

class OverlayGroupsSelection extends StatefulWidget {
  const OverlayGroupsSelection({
    Key? key,
    required this.assignedGroups,
    required this.toggleGroupSelection,
    required this.onDismiss,
  }) : super(key: key);

  final List<String> assignedGroups;
  final Function(String) toggleGroupSelection;
  final Function() onDismiss;

  @override
  State<OverlayGroupsSelection> createState() => _OverlayGroupsSelectionState();
}

class _OverlayGroupsSelectionState extends State<OverlayGroupsSelection>
    with ResponsiveSize {
  List<Group>? _groups;

  String _searchQuery = '';

  final _searchTextEditingController = TextEditingController();

  void _clearSearchQuery() {
    _searchTextEditingController.text = '';
    FocusScope.of(context).unfocus();
    setState(() {
      _searchQuery = '';
    });
  }

  // search groups according to given query string
  List<Group> _searchGroups(
      BuildContext context, List<Group> allGroups, String searchQuery) {
    if (searchQuery.trim().isNotEmpty) {
      return allGroups
          .where(
            (user) => user.name
                .toLowerCase()
                .contains(searchQuery.trim().toLowerCase()),
          )
          .toList();
    }
    return allGroups;
  }

  @override
  void dispose() {
    _searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _groups = null;
    final groupsState = context.watch<GroupBloc>().state;
    // gets groups (id's) with premission to create tasks
    if (groupsState is GroupLoadedState) {
      _groups = groupsState.allGroups.allGroups.where((group) {
        final taskFeature = group.features
            .firstWhere((feature) => feature.type == FeatureType.tasks);
        return taskFeature.create;
      }).toList();
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
                    AppLocalizations.of(context)!.task_assign_groups,
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
                    child: _groups != null
                        ? Builder(builder: (context) {
                            final filteredGroups = _searchGroups(
                              context,
                              _groups!,
                              _searchQuery,
                            );
                            return ListView.builder(
                              padding: const EdgeInsets.only(bottom: 50),
                              shrinkWrap: true,
                              itemCount: filteredGroups.length,
                              itemBuilder: (context, index) => GroupTile(
                                key: ValueKey(filteredGroups[index].id),
                                group: filteredGroups[index],
                                onTap: (group) => widget.toggleGroupSelection(
                                  group.id,
                                ),
                                isSelectionTile: true,
                                isGroupMember: widget.assignedGroups
                                    .contains(filteredGroups[index].id),
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
                    widget.assignedGroups.isNotEmpty ? widget.onDismiss : null,
                icon: const Icon(Icons.done),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
