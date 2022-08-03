import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/new_users/new_users_bloc.dart';
import 'package:under_control_v2/features/core/presentation/widgets/user_list_tile.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:under_control_v2/features/user_profile/presentation/pages/new_users_list_page.dart';
import 'package:under_control_v2/features/user_profile/presentation/pages/user_details_page.dart';

import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/presentation/widgets/search_text_field.dart';

class UsersListPage extends StatefulWidget {
  const UsersListPage({Key? key}) : super(key: key);

  static const routeName = '/users/list';

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  bool isSearchFieldExpanded = false;

  TextEditingController searchController = TextEditingController();

  String searchQuery = '';

  late UserProfile currentUser;

  int? newUsersCount;

  int suspendedUsersCount = 0;

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
    final currentState = context.read<UserProfileBloc>().state;
    if (currentState is Approved) {
      currentUser = currentState.userProfile;
    }
    final newUsersState = context.watch<NewUsersBloc>().state;
    if (newUsersState is NewUsersLoadedState) {
      newUsersCount = newUsersState.newUsers.allUsers.length;
    }
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
            : Text(
                AppLocalizations.of(context)!.drawer_item_users,
              ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // suspended and new users
            if (currentUser.administrator && !isSearchFieldExpanded)
              Padding(
                padding: const EdgeInsets.only(
                  top: 8,
                  left: 8,
                  right: 8,
                ),
                child: Column(
                  children: [
                    InkWell(
                      onTap: newUsersCount == null
                          ? null
                          : newUsersCount == 0
                              ? null
                              : () {
                                  Navigator.pushNamed(
                                    context,
                                    NewUsersListPage.routeName,
                                  );
                                },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).focusColor,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .user_awaiting_approval,
                                maxLines: 2,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            // new users loaded
                            if (newUsersCount != null)
                              Text(
                                newUsersCount.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            // new users not loaded
                            if (newUsersCount == null)
                              const CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    )
                  ],
                ),
              ),
            // accepted users
            BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
              builder: (context, state) {
                if (state is CompanyProfileLoaded) {
                  List<UserProfile> filteredUsers = state.companyUsers.allUsers
                      .where(
                        (user) =>
                            user.firstName
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()) ||
                            user.lastName
                                .toLowerCase()
                                .contains(searchQuery.toLowerCase()),
                      )
                      .toList()
                    ..sort(
                      (a, b) => a.firstName.compareTo(b.firstName),
                    );
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 2.0,
                      ),
                      child: UserListTile(
                        user: filteredUsers[index],
                        onTap: ((userProfile) {
                          Navigator.pushNamed(
                            context,
                            UserDetailsPage.routeName,
                            arguments: userProfile,
                          );
                        }),
                      ),
                    ),
                  );
                } else {
                  return const LoadingWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
