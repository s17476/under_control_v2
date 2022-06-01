import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/size_config.dart';
import '../blocs/user_profile/user_profile_bloc.dart';

class NotApprovedPage extends StatelessWidget {
  const NotApprovedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    DateTime preBackpress = DateTime.now();
    return WillPopScope(
      // double click to exit the app
      onWillPop: () async {
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(
                AppLocalizations.of(context)!.back_to_exit,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.black,
            ));
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Image.asset(
                  'assets/validation.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
              Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.well_done,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    AppLocalizations.of(context)!.approve_page_text,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () => context.read<UserProfileBloc>().add(
                          GetUserByIdEvent(
                            userId: (context.read<UserProfileBloc>().state
                                    as NotApproved)
                                .userProfile
                                .id,
                          ),
                        ),
                    child: Text(
                      AppLocalizations.of(context)!
                          .approve_page_change_button_refresh,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () => context.read<UserProfileBloc>().add(
                          ResetCompanyEvent(
                            userProfile: (context.read<UserProfileBloc>().state
                                    as NotApproved)
                                .userProfile,
                          ),
                        ),
                    child: Text(
                      AppLocalizations.of(context)!.approve_page_change_button,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
