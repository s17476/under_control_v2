import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../checklists/data/models/checkpoint_model.dart';
import '../../../../checklists/domain/entities/checklist.dart';
import '../../../../checklists/presentation/blocs/checklist/checklist_bloc.dart';
import '../../../../checklists/presentation/widgets/checklist_tile.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/glass_layer.dart';
import '../../../../core/presentation/widgets/shimmer_user_list_tile.dart';
import 'checklist_selection_tile.dart';

class OverlayChecklistSelection extends StatefulWidget {
  const OverlayChecklistSelection({
    Key? key,
    required this.checklist,
    required this.onDismiss,
  }) : super(key: key);

  final List<CheckpointModel> checklist;
  final Function() onDismiss;

  @override
  State<OverlayChecklistSelection> createState() =>
      _OverlayChecklistSelectionState();
}

class _OverlayChecklistSelectionState extends State<OverlayChecklistSelection>
    with ResponsiveSize {
  List<Checklist>? _checklists;

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
  List<Checklist> _searchUsers(
      BuildContext context, List<Checklist> allChecklists, String searchQuery) {
    if (searchQuery.trim().isNotEmpty) {
      return allChecklists
          .where(
            (checklist) => checklist.title
                .toLowerCase()
                .contains(searchQuery.trim().toLowerCase()),
          )
          .toList();
    }
    return allChecklists;
  }

  @override
  void dispose() {
    _searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _checklists = null;
    final checklistState = context.watch<ChecklistBloc>().state;
    if (checklistState is ChecklistLoadedState) {
      _checklists = checklistState.allChecklists.allChecklists;
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
                    AppLocalizations.of(context)!.checklist_add_checkpoints,
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
                    child: _checklists != null
                        ? Builder(builder: (context) {
                            final filteredChecklists = _searchUsers(
                              context,
                              _checklists!,
                              _searchQuery,
                            );
                            return ListView.builder(
                              padding: const EdgeInsets.only(bottom: 50),
                              shrinkWrap: true,
                              itemCount: filteredChecklists.length,
                              itemBuilder: (context, index) =>
                                  ChecklistSelectionTile(
                                key: ValueKey(filteredChecklists[index].id),
                                checklist: filteredChecklists[index],
                                searchQuery: _searchQuery,
                                // onTap: (checklist) {
                                // TODO - open checklist page
                                // },
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
                    widget.checklist.isNotEmpty ? widget.onDismiss : null,
                icon: const Icon(Icons.done),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
