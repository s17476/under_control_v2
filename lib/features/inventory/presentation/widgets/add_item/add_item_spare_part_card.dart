import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/selection_radio_card.dart';
import '../../../../core/utils/responsive_size.dart';

class AddItemSparePartCard extends StatefulWidget {
  const AddItemSparePartCard({
    Key? key,
    required this.pageController,
    required this.setIsSparePart,
    required this.isSparePart,
  }) : super(key: key);

  final PageController pageController;
  final Function(bool) setIsSparePart;
  final bool isSparePart;

  @override
  State<AddItemSparePartCard> createState() => _AddItemSparePartCardState();
}

class _AddItemSparePartCardState extends State<AddItemSparePartCard>
    with ResponsiveSize {
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
                    AppLocalizations.of(context)!.item_spare_part,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                AnimatedPadding(
                  padding: EdgeInsets.only(
                    top: responsiveSizeVerticalPct(
                        small: widget.isSparePart ? 0 : 30),
                  ),
                  duration: const Duration(milliseconds: 300),
                  // sellection cards
                  child: Column(
                    children: [
                      // not a spare part
                      SelectionRadioCard(
                        onTap: widget.setIsSparePart,
                        value: false,
                        groupValue: widget.isSparePart,
                        title:
                            AppLocalizations.of(context)!.item_spare_part_not,
                      ),
                      // spare part
                      SelectionRadioCard(
                        onTap: widget.setIsSparePart,
                        value: true,
                        groupValue: widget.isSparePart,
                        title:
                            AppLocalizations.of(context)!.item_spare_part_yes,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // // bottom navigation
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       BackwardTextButton(
          //         icon: Icons.arrow_back_ios_new,
          //         color: Theme.of(context).textTheme.headline5!.color!,
          //         label: AppLocalizations.of(context)!
          //             .user_profile_add_user_personal_data_back,
          //         function: () {
          //           FocusScope.of(context).unfocus();
          //           widget.pageController.previousPage(
          //           duration: const Duration(milliseconds: 300),
          //           curve: Curves.easeInOut,
          //         );
          //         },
          //         onHoldFunction: () {
          //           FocusScope.of(context).unfocus();
          //           widget.pageController.animateToPage(
          //             0,
          //             duration: const Duration(milliseconds: 300),
          //             curve: Curves.easeInOut,
          //           );
          //         },
          //       ),
          //       ForwardTextButton(
          //         color: Theme.of(context).textTheme.headline5!.color!,
          //         label:
          //             AppLocalizations.of(context)!.user_profile_add_user_next,
          //         function: () {
          //           FocusScope.of(context).unfocus();
          //           widget.pageController.nextPage(
          //           duration: const Duration(milliseconds: 300),
          //           curve: Curves.easeInOut,
          //         );
          //         },
          //         onHoldFunction: () {
          //           FocusScope.of(context).unfocus();
          //           widget.pageController.animateToPage(
          //             widget.,
          //             duration: const Duration(milliseconds: 300),
          //             curve: Curves.easeInOut,
          //           );
          //         },
          //         icon: Icons.arrow_forward_ios_outlined,
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
