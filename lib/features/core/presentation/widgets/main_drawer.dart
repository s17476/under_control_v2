import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      width: responsiveSizePct(small: 60, medium: 30),
      child: SafeArea(
        child: Column(
          children: [
            const FittedBox(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Logo(greenLettersSize: 30, whitheLettersSize: 20),
              ),
            ),
            const Expanded(child: SizedBox()),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(SignoutEvent());
                  },
                  icon:
                      const Icon(Icons.logout, color: drawerItemIconDarkColor),
                  label: Text(
                    AppLocalizations.of(context)!.main_drawer_signout,
                    style: drawerItemTextDarkStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
