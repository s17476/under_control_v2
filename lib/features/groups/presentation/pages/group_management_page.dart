import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/presentation/widgets/search_text_field.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../domain/entities/group.dart';
import '../blocs/group/group_bloc.dart';
import '../widgets/group_management/group_tile.dart';
import 'add_group_page.dart';

class GroupManagementPage extends StatefulWidget {
  const GroupManagementPage({Key? key}) : super(key: key);

  static const routeName = '/groups';

  @override
  State<GroupManagementPage> createState() => _GroupManagementPageState();
}

class _GroupManagementPageState extends State<GroupManagementPage> {
  bool isSearchFieldExpanded = false;
  bool isAdministrator = false;

  TextEditingController searchController = TextEditingController();

  String searchQuery = '';

  void hideSearchField() {
    FocusScope.of(context).unfocus();
    setState(() {
      isSearchFieldExpanded = false;
      searchController.text = '';
    });
    search();
  }

  void search() {
    setState(() {
      searchQuery = searchController.text;
    });
  }

  @override
  void didChangeDependencies() {
    isAdministrator = (context.read<UserProfileBloc>().state as Approved)
        .userProfile
        .administrator;
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
                onChanged: search,
                onCancel: hideSearchField,
              )
            : Text(AppLocalizations.of(context)!.group_management_title),
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
      body: BlocConsumer<GroupBloc, GroupState>(
        // shows message
        listener: (context, state) {
          if (state is GroupLoadedState) {
            if (state.message.isNotEmpty) {
              String message = '';
              switch (state.message) {
                case addedMessage:
                  message = AppLocalizations.of(context)!
                      .group_management_add_added_new_msg;
                  break;
                case groupContainsMembers:
                  message = AppLocalizations.of(context)!
                      .group_management_delete_error_not_empty;
                  break;
                case updateSuccess:
                  message = AppLocalizations.of(context)!.update_success;
                  break;
                case deleteSuccess:
                  message = AppLocalizations.of(context)!.delete_success;
                  break;
                default:
                  message = '';
              }
              if (message.isNotEmpty) {
                ScaffoldMessenger.of(context)
                  ..clearSnackBars()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        message,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: state.error
                          ? Theme.of(context).errorColor
                          : Theme.of(context).primaryColor,
                    ),
                  );
              }
            }
          }
        },
        builder: (context, state) {
          if (state is GroupLoadedState) {
            List<Group> filteredGroups = state.allGroups.allGroups
                .where((group) => group.name.toLowerCase().contains(
                      searchQuery.toLowerCase(),
                    ))
                .toList();
            return ListView.builder(
              itemCount: filteredGroups.length + 1,
              itemBuilder: (context, index) {
                if (index == filteredGroups.length) {
                  return const SizedBox(
                    height: 80,
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(top: index == 0 ? 4 : 0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GroupTile(
                        key: ValueKey(filteredGroups[index].id),
                        group: filteredGroups[index],
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
      // floating action button visible only if:
      // user is administrator
      // and GroupBloc state is GroupLoadedState
      floatingActionButton: isAdministrator
          ? context.watch<GroupBloc>().state is GroupLoadedState
              ? FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pushNamed(context, AddGroupPage.routeName);
                  },
                  icon: Icon(
                    Icons.group_add,
                    color: Colors.grey.shade200,
                  ),
                  label: Text(
                    AppLocalizations.of(context)!.group_management_add_button,
                    style: TextStyle(
                      color: Colors.grey.shade200,
                    ),
                  ),
                )
              // bloc state is not GroupLoadedState
              : null
          // not an administrator
          : null,
    );
  }
}
