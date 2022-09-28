import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/presentation/widgets/search_text_field.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../domain/entities/checklist.dart';
import '../blocs/checklist/checklist_bloc.dart';
import '../blocs/checklist_management/checklist_management_bloc.dart';
import '../widgets/checklist_tile.dart';
import 'add_checklist_page.dart';
import 'checklist_details_page.dart';

class ChecklistManagementPage extends StatefulWidget {
  const ChecklistManagementPage({Key? key}) : super(key: key);

  static const routeName = '/checklists';

  @override
  State<ChecklistManagementPage> createState() =>
      _ChecklistManagementPageState();
}

class _ChecklistManagementPageState extends State<ChecklistManagementPage> {
  bool _isSearchFieldExpanded = false;
  bool _isAdministrator = false;
  late UserProfile _currentUser;

  final _searchController = TextEditingController();

  String _searchQuery = '';

  void _hideSearchField() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isSearchFieldExpanded = false;
      _searchController.text = '';
    });
    _search();
  }

  void _search() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  void didChangeDependencies() {
    _currentUser =
        (context.read<UserProfileBloc>().state as Approved).userProfile;
    _isAdministrator = _currentUser.administrator;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: !_isSearchFieldExpanded
            ? null
            : Container(
                width: 0,
                color: Colors.amber,
              ),
        leadingWidth: _isSearchFieldExpanded ? 0 : null,
        title: _isSearchFieldExpanded
            ? SearchTextField(
                searchController: _searchController,
                onChanged: _search,
                onCancel: _hideSearchField,
              )
            : Text(AppLocalizations.of(context)!.checklist_drawer_title),
        centerTitle: true,
        actions: [
          if (!_isSearchFieldExpanded)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                onPressed: () => setState(() {
                  _isSearchFieldExpanded = true;
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
            bool error = false;
            switch (state.message) {
              case ChecklistMessage.checklistAdded:
                message = AppLocalizations.of(context)!.checklist_msg_added;
                break;
              case ChecklistMessage.checklistNotAdded:
                message = AppLocalizations.of(context)!.checklist_msg_not_added;
                error = true;
                break;
              case ChecklistMessage.checklistDeleted:
                message = AppLocalizations.of(context)!.checklist_msg_deleted;
                break;
              case ChecklistMessage.checklistNotDeleted:
                message =
                    AppLocalizations.of(context)!.checklist_msg_not_deleted;
                error = true;
                break;
              default:
                message = '';
            }
            if (message.isNotEmpty) {
              showSnackBar(
                context: context,
                message: message,
                isErrorMessage: error,
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
                        _searchQuery.toLowerCase(),
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
                          user: _currentUser,
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
      floatingActionButton: _isAdministrator
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
