import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/widgets/backward_text_button.dart';
import 'package:under_control_v2/features/core/presentation/widgets/forward_text_button.dart';

import '../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../core/presentation/widgets/logo_widget.dart';
import '../../../core/utils/size_config.dart';

class WelcomeCard extends StatelessWidget with ResponsiveSize {
  const WelcomeCard({
    Key? key,
    required this.pageController,
  }) : super(key: key);
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackwardTextButton(
                        icon: Icons.logout,
                        color: Colors.black,
                        label: AppLocalizations.of(context)!
                            .user_profile_add_user_signout,
                        function: () => context.read<AuthenticationBloc>().add(
                              SignoutEvent(),
                            ),
                      ),
                      ForwardTextButton(
                        color: Theme.of(context).textTheme.headline4!.color!,
                        label: AppLocalizations.of(context)!
                            .user_profile_add_user_next,
                        function: () => pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn),
                        icon: Icons.arrow_forward_ios,
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
