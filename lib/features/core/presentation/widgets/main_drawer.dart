import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(),
          const Expanded(child: SizedBox()),
          TextButton.icon(
              onPressed: () {
                context.read<AuthenticationBloc>().add(SignoutEvent());
              },
              icon: const Icon(Icons.logout),
              label: Text(AppLocalizations.of(context)!.main_drawer_signout))
        ],
      ),
    );
  }
}
