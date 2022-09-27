import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../company_profile/presentation/blocs/new_users/new_users_bloc.dart';
import '../../../company_profile/presentation/blocs/suspended_users/suspended_users_bloc.dart';
import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/presentation/widgets/search_text_field.dart';
import '../../../core/presentation/widgets/user_list_tile.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../domain/entities/user_profile.dart';
import '../blocs/user_profile/user_profile_bloc.dart';
import 'new_users_list_page.dart';
import 'suspended_users_list_page.dart';
import 'user_details_page.dart';

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

  int? suspendedUsersCount;

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
      newUsersCount = newUsersState.newUsers.activeUsers.length;
      newUsersCount =
          newUsersCount! + newUsersState.newUsers.passiveUsers.length;
    }
    final suspendedUsersState = context.watch<SuspendedUsersBloc>().state;
    if (suspendedUsersState is SuspendedUsersLoadedState) {
      suspendedUsersCount = suspendedUsersState.allUsers.length;
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
                    // suspended users
                    InkWell(
                      onTap: suspendedUsersCount == null
                          ? null
                          : suspendedUsersCount == 0
                              ? () => showSnackBar(
                                    context: context,
                                    message: AppLocalizations.of(context)!
                                        .user_no_suspended_users,
                                  )
                              : () {
                                  Navigator.pushNamed(
                                    context,
                                    SuspendedUsersListPage.routeName,
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
                        height: 55,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .user_suspended_users,
                                maxLines: 2,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            // suspended users loaded
                            if (suspendedUsersCount != null)
                              Text(
                                suspendedUsersCount.toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            // suspended users not loaded
                            if (suspendedUsersCount == null)
                              const FittedBox(
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // suspended users
                    InkWell(
                      onTap: newUsersCount == null
                          ? null
                          : newUsersCount == 0
                              ? () => showSnackBar(
                                    context: context,
                                    message: AppLocalizations.of(context)!
                                        .user_no_new_users,
                                  )
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
                        height: 55,
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
                              const FittedBox(
                                child: CircularProgressIndicator(),
                              ),
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
                  List<UserProfile> activeUsers = state.companyUsers.activeUsers
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
                  List<UserProfile> passiveUsers =
                      state.companyUsers.passiveUsers
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // active users
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.active_users,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: activeUsers.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 2.0,
                          ),
                          child: UserListTile(
                            user: activeUsers[index],
                            onTap: ((userProfile) {
                              Navigator.pushNamed(
                                context,
                                UserDetailsPage.routeName,
                                arguments: userProfile,
                              );
                            }),
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1.5,
                        indent: 8,
                        endIndent: 8,
                      ),
                      // passive users
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.passive_users,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 20),
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: passiveUsers.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 2.0,
                          ),
                          child: UserListTile(
                            user: passiveUsers[index],
                            onTap: (userProfile) {
                              Navigator.pushNamed(
                                context,
                                UserDetailsPage.routeName,
                                arguments: userProfile,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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
