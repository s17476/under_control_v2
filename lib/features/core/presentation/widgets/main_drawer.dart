import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/cached_user_avatar.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:under_control_v2/features/user_profile/presentation/pages/user_details_page.dart';

import '../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../../groups/presentation/pages/group_management_page.dart';
import '../../../locations/presentation/pages/location_management_page.dart';
import '../../utils/responsive_size.dart';
import 'custom_menu_item.dart';
import 'logo_widget.dart';

class MainDrawer extends StatelessWidget with ResponsiveSize {
  const MainDrawer({Key? key}) : super(key: key);

  static const drawerItemTextDarkStyle = TextStyle(color: Colors.white);
  static const drawerItemIconDarkColor = Colors.white;

  static const drawerItemTextLightStyle = TextStyle(color: Colors.black);
  static const drawerItemIconLightColor = Colors.black;

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
              const FittedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Logo(greenLettersSize: 30, whitheLettersSize: 20),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
              CustomMenuItem(
                onTap: () {
                  Navigator.popAndPushNamed(
                    context,
                    LocationManagementPage.routeName,
                  );
                },
                icon: Icons.location_on,
                // iconBackgroundColor: Colors.red,
                label: AppLocalizations.of(context)!.drawer_item_locations,
              ),
              CustomMenuItem(
                onTap: () {
                  Navigator.popAndPushNamed(
                      context, GroupManagementPage.routeName);
                },
                icon: Icons.group,
                // iconBackgroundColor: Colors.amber,
                label: AppLocalizations.of(context)!.drawer_item_groups,
              ),
              CustomMenuItem(
                onTap: () {},
                icon: Icons.settings,
                // iconBackgroundColor: Colors.deepPurple,
                label: AppLocalizations.of(context)!.drawer_item_settings,
              ),
              const Expanded(child: SizedBox()),
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
