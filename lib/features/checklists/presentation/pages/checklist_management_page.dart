import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/checklists/domain/entities/checklist.dart';
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart';
import 'package:under_control_v2/features/checklists/presentation/pages/add_checklist_page.dart';
import 'package:under_control_v2/features/checklists/presentation/pages/checklist_details_page.dart';
import 'package:under_control_v2/features/checklists/presentation/widgets/checklist_tile.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';

import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/presentation/widgets/search_text_field.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../blocs/checklist/checklist_bloc.dart';

class ChecklistManagementPage extends StatefulWidget {
  const ChecklistManagementPage({Key? key}) : super(key: key);

  static const routeName = '/checklists';

  @override
  State<ChecklistManagementPage> createState() =>
      _ChecklistManagementPageState();
}

class _ChecklistManagementPageState extends State<ChecklistManagementPage> {
  bool isSearchFieldExpanded = false;
  bool isAdministrator = false;
  late UserProfile currentUser;

  TextEditingController searchController = TextEditingController();

  String searchQuery = '';

  void _hideSearchField() {
    FocusScope.of(context).unfocus();
    setState(() {
      isSearchFieldExpanded = false;
      searchController.text = '';
    });
    _search();
  }

  void _search() {
    setState(() {
      searchQuery = searchController.text;
    });
  }

  @override
  void didChangeDependencies() {
    currentUser =
        (context.read<UserProfileBloc>().state as Approved).userProfile;
    isAdministrator = currentUser.administrator;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: !isSearchFieldExpanded
            ? null
            : Container(
                width: 0,
                color: Colors.amber,
              ),
        leadingWidth: isSearchFieldExpanded ? 0 : null,
        title: isSearchFieldExpanded
            ? SearchTextField(
                searchController: searchController,
                onChanged: _search,
                onCancel: _hideSearchField,
              )
            : Text(AppLocalizations.of(context)!.checklist_drawer_title),
        centerTitle: true,
        actions: [
          if (!isSearchFieldExpanded)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: () => setState(() {
                  isSearchFieldExpanded = true;
                }),
                icon: const Icon(Icons.search),
              ),
            ),
        ],
      ),
      body: BlocListener<ChecklistManagementBloc, ChecklistManagementState>(
        listener: (context, state) {
          if (state is ChecklistManagementSuccessState) {
            String message = '';
            switch (state.message) {
              case ChecklistMessage.checklistAdded:
                message = AppLocalizations.of(context)!.checklist_msg_added;
                break;
              case ChecklistMessage.checklistNotAdded:
                message = AppLocalizations.of(context)!.checklist_msg_not_added;
                break;
              case ChecklistMessage.checklistUpdated:
                message = AppLocalizations.of(context)!.checklist_msg_updated;
                break;
              case ChecklistMessage.checklistNotUpdated:
                message =
                    AppLocalizations.of(context)!.checklist_msg_not_updated;
                break;
              case ChecklistMessage.checklistDeleted:
                message = AppLocalizations.of(context)!.checklist_msg_deleted;
                break;
              case ChecklistMessage.checklistNotDeleted:
                message =
                    AppLocalizations.of(context)!.checklist_msg_not_deleted;
                break;
              default:
                message = '';
            }
            if (message.isNotEmpty) {
              showSnackBar(
                context: context,
                message: message,
              );
            }
          }
        },
        child: BlocBuilder<ChecklistBloc, ChecklistState>(
          builder: (context, state) {
            if (state is ChecklistLoadedState) {
              List<Checklist> filteredChecklists = state
                  .allChecklists.allChecklists
                  .where((checklist) => checklist.title.toLowerCase().contains(
                        searchQuery.toLowerCase(),
                      ))
                  .toList();
              return ListView.builder(
                itemCount: filteredChecklists.length + 1,
                itemBuilder: (context, index) {
                  if (index == filteredChecklists.length) {
                    return const SizedBox(
                      height: 80,
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 4 : 0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ChecklistTile(
                          checklist: filteredChecklists[index],
                          user: currentUser,
                          onTap: (checklist) => Navigator.pushNamed(
                            context,
                            ChecklistDetailsPage.routeName,
                            arguments: checklist,
                          ),
                        ),
                      ),
                    );
                  }
                },
              );
            } else {
              return const LoadingWidget();
            }
          },
        ),
      ),
      floatingActionButton: isAdministrator
          ? context.watch<ChecklistBloc>().state is ChecklistLoadedState
              ? FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: () {
                    Navigator.pushNamed(context, AddChecklistPage.routeName);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.grey.shade200,
                  ),
                  label: Text(
                    AppLocalizations.of(context)!.checklist_add_button,
                    style: TextStyle(
                      color: Colors.grey.shade200,
                    ),
                  ),
                )
              // bloc state is not ChecklistLoadedState
              : null
          // not an administrator
          : null,
    );
  }
}
