import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../company_profile/presentation/pages/company_details_page.dart';
import '../../../../groups/presentation/pages/group_management_page.dart';
import '../../../../locations/presentation/pages/location_management_page.dart';
import '../../../../settings/presentation/pages/settings_page.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../../user_profile/presentation/pages/user_details_page.dart';
import '../../../../user_profile/presentation/pages/users_list_page.dart';
import '../../../utils/responsive_size.dart';
import '../cached_user_avatar.dart';
import '../logo_widget.dart';
import 'custom_menu_item.dart';

class MainDrawer extends StatelessWidget with ResponsiveSize {
  const MainDrawer({
    Key? key,
    required this.drawerKey,
    this.toggleShowcaseBarierInteraction,
  }) : super(key: key);

  final GlobalKey drawerKey;
  final VoidCallback? toggleShowcaseBarierInteraction;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: responsiveSizePct(small: 70),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Column(
            children: [
              Showcase(
                key: drawerKey,
                title: AppLocalizations.of(context)!.showcase_menu,
                targetPadding: const EdgeInsets.only(
                  top: -8,
                  bottom: 32,
                  left: 8,
                  right: 8,
                ),
                description: AppLocalizations.of(context)!.showcase_menu_drawer,
                targetBorderRadius: BorderRadius.circular(15),
                tooltipBackgroundColor: Theme.of(context).primaryColor,
                titleTextStyle: Theme.of(context).textTheme.headlineSmall,
                descTextStyle: Theme.of(context).textTheme.bodyLarge,
                onTargetClick: () async {
                  Scaffold.of(context).closeDrawer();
                  if (toggleShowcaseBarierInteraction != null) {
                    toggleShowcaseBarierInteraction!();
                  }
                  // Future.delayed(const Duration(milliseconds: 400), () {
                  ShowCaseWidget.of(context).next();
                  // });
                },
                disposeOnTap: false,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                      child: FittedBox(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 8,
                            right: 8,
                            top: 4,
                          ),
                          child:
                              Logo(greenLettersSize: 30, whitheLettersSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      child:
                          BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
                        builder: (context, state) {
                          if (state is CompanyProfileLoaded) {
                            return InkWell(
                              onTap: () => Navigator.popAndPushNamed(
                                context,
                                CompanyDetailsPage.routeName,
                              ),
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(
                                  state.company.name,
                                  style: const TextStyle(fontSize: 22),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                    const Divider(),
                    BlocBuilder<UserProfileBloc, UserProfileState>(
                      builder: (context, state) {
                        if (state is Approved) {
                          return InkWell(
                            onTap: () => Navigator.popAndPushNamed(
                              context,
                              UserDetailsPage.routeName,
                              arguments: state.userProfile,
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                // avatar
                                CachedUserAvatar(
                                  size: responsiveSizePct(small: 15),
                                  imageUrl: state.userProfile.avatarUrl,
                                ),
                                const SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // first name
                                      Text(
                                        state.userProfile.firstName,
                                        style: const TextStyle(fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                      // last name
                                      Text(
                                        state.userProfile.lastName,
                                        style: const TextStyle(fontSize: 16),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    const Divider(),
                    // users
                    CustomMenuItem(
                      onTap: () {
                        Navigator.popAndPushNamed(
                          context,
                          UsersListPage.routeName,
                        );
                      },
                      icon: Icons.person,
                      label: AppLocalizations.of(context)!.drawer_item_users,
                    ),
                    // groups
                    CustomMenuItem(
                      onTap: () {
                        Navigator.popAndPushNamed(
                            context, GroupManagementPage.routeName);
                      },
                      icon: Icons.group,
                      // iconBackgroundColor: Colors.amber,
                      label: AppLocalizations.of(context)!.drawer_item_groups,
                    ),
                    // locations
                    CustomMenuItem(
                      onTap: () {
                        Navigator.popAndPushNamed(
                          context,
                          LocationManagementPage.routeName,
                        );
                      },
                      icon: Icons.location_on,
                      label:
                          AppLocalizations.of(context)!.drawer_item_locations,
                    ),
                  ],
                ),
              ),

              const Expanded(child: SizedBox()),
              // settings
              CustomMenuItem(
                onTap: () => Navigator.popAndPushNamed(
                  context,
                  SettingsPage.routeName,
                ),
                icon: Icons.settings,
                // iconBackgroundColor: Colors.deepPurple,
                label: AppLocalizations.of(context)!.drawer_item_settings,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Divider(),
                  CustomMenuItem(
                    onTap: () =>
                        context.read<AuthenticationBloc>().add(SignoutEvent()),
                    icon: Icons.logout_outlined,
                    // iconBackgroundColor: Colors.black38,
                    label: AppLocalizations.of(context)!.main_drawer_signout,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
