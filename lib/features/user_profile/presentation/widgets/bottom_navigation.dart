import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'backward_elevated_button.dart';
import 'forward_elevated_button.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
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
              // back button
              Expanded(
                child: BackwardElevatedButton(
                  function: () => pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  ),
                  icon: Icons.arrow_back_ios,
                  child: AppLocalizations.of(context)!
                      .user_profile_add_user_personal_data_back,
                ),
              ),
              const SizedBox(width: 48),
              // forward button
              Expanded(
                child: ForwardElevatedButton(
                  function: () {
                    return pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                  icon: Icons.arrow_forward_ios,
                  child:
                      AppLocalizations.of(context)!.user_profile_add_user_next,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
