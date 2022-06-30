import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/locations/presentation/pages/location_management_page.dart';

import 'custom_menu_item.dart';
import 'logo_widget.dart';
import '../../utils/responsive_size.dart';
import '../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';

class MainDrawer extends StatelessWidget with ResponsiveSize {
  const MainDrawer({Key? key}) : super(key: key);

  static const drawerItemTextDarkStyle = TextStyle(color: Colors.white);
  static const drawerItemIconDarkColor = Colors.white;

  static const drawerItemTextLightStyle = TextStyle(color: Colors.black);
  static const drawerItemIconLightColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: responsiveSizePct(small: 60),
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
              const Text('user data'),
              const Divider(),
              CustomMenuItem(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    LocationManagementPage.routeName,
                  );
                },
                icon: Icons.location_on,
                // iconBackgroundColor: Colors.red,
                label: AppLocalizations.of(context)!.drawer_item_locations,
              ),
              CustomMenuItem(
                onTap: () {},
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
