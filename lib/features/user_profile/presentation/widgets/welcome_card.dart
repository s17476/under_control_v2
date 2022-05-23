import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/responsive_size.dart';
import '../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../../core/presentation/widgets/logo_widget.dart';
import '../../../core/utils/size_config.dart';
import 'backward_elevated_button.dart';
import 'forward_elevated_button.dart';

class WelcomeCard extends StatelessWidget with ResponsiveSize {
  const WelcomeCard({Key? key, required this.pageController}) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height:
                              responsiveSizeVerticalPct(small: 25, medium: 0),
                        ),
                        const FittedBox(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.0),
                            child: Logo(
                              greenLettersSize: 15,
                              whitheLettersSize: 10,
                            ),
                          ),
                        ),
                        SizedBox(
                          height:
                              responsiveSizeVerticalPct(small: 5, medium: 0),
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .user_profile_add_user_welcome,
                          style: const TextStyle(fontSize: 32),
                        ),
                        SizedBox(
                          height: responsiveSizePx(small: 32, medium: 5),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            AppLocalizations.of(context)!
                                .user_profile_add_user_personal_data_info,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // signout button
                      Expanded(
                        child: BackwardElevatedButton(
                          function: () => context
                              .read<AuthenticationBloc>()
                              .add(SignoutEvent()),
                          icon: Icons.logout,
                          child: AppLocalizations.of(context)!
                              .user_profile_add_user_signout,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(width: 48),
                      // forward button
                      Expanded(
                        child: ForwardElevatedButton(
                          function: () => pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          ),
                          icon: Icons.arrow_forward_ios,
                          child: AppLocalizations.of(context)!
                              .user_profile_add_user_next,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
