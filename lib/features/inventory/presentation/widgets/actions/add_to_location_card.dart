import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import '../../../domain/entities/item.dart';
import 'selectable_locations_list.dart';

class AddToLocationCard extends StatelessWidget {
  const AddToLocationCard({
    Key? key,
    required this.pageController,
    required this.item,
    required this.title,
    required this.selectedLocation,
    required this.setLocation,
  }) : super(key: key);

  final PageController pageController;

  final Item item;

  final String title;

  final String selectedLocation;

  final Function(String) setLocation;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      left: 8,
                      right: 8,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline5!.fontSize,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  SelectableLocationsList(
                    selectedLocation: selectedLocation,
                    setLocation: setLocation,
                    item: item,
                  ),
                ],
              ),
            ),
          ),
          // bottom navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackwardTextButton(
                  icon: Icons.cancel,
                  color: Theme.of(context).textTheme.headline4!.color!,
                  label: AppLocalizations.of(context)!.cancel,
                  function: () => Navigator.pop(context),
                ),
                ForwardTextButton(
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label:
                      AppLocalizations.of(context)!.user_profile_add_user_next,
                  function: () => pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut),
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
