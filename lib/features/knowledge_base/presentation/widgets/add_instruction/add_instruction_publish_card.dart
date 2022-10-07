import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import '../../../../core/presentation/widgets/selection_button.dart';
import '../../../../core/utils/responsive_size.dart';

class AddInstructionPublishCard extends StatelessWidget with ResponsiveSize {
  const AddInstructionPublishCard({
    Key? key,
    required this.pageController,
    required this.setIsPublished,
    required this.isPublished,
  }) : super(key: key);

  final PageController pageController;
  final Function(bool) setIsPublished;
  final bool isPublished;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                // title
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 8,
                    right: 8,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.save_mode,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // draft
                        SelectionButton<bool>(
                          onSelected: setIsPublished,
                          icon: Icons.drive_file_rename_outline_rounded,
                          iconSize: 50,
                          title: AppLocalizations.of(context)!.draft,
                          titleSize: 18,
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange.withAlpha(150),
                              Colors.orange,
                              Colors.orange.withAlpha(80),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          value: false,
                          groupValue: isPublished,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // spare part
                        SelectionButton<bool>(
                          onSelected: setIsPublished,
                          icon: Icons.cloud_upload,
                          iconSize: 50,
                          title: AppLocalizations.of(context)!.publish,
                          titleSize: 18,
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor.withAlpha(100),
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withAlpha(80),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          value: true,
                          groupValue: isPublished,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // bottom navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackwardTextButton(
                  icon: Icons.arrow_back_ios_new,
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label: AppLocalizations.of(context)!
                      .user_profile_add_user_personal_data_back,
                  function: () => pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
                ForwardTextButton(
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label:
                      AppLocalizations.of(context)!.user_profile_add_user_next,
                  function: () => pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  icon: Icons.arrow_forward_ios_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
