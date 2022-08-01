import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/core/presentation/widgets/user_list_tile.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
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
      body: BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
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
                .toList();
            return ListView.builder(
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
    );
  }
}
