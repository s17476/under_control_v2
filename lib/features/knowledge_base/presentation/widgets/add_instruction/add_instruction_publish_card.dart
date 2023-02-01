import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/selection_button.dart';
import '../../../../core/utils/responsive_size.dart';

class AddInstructionPublishCard extends StatelessWidget with ResponsiveSize {
  const AddInstructionPublishCard({
    Key? key,
    required this.setIsPublished,
    required this.isPublished,
  }) : super(key: key);

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
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall!.fontSize,
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
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
