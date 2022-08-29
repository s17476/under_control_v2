import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/checklists/data/models/checkpoint_model.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart';
import 'package:under_control_v2/features/inventory/presentation/blocs/items/items_bloc.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/get_localized_unit_name.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';

class AddItemSummaryCard extends StatelessWidget {
  const AddItemSummaryCard({
    Key? key,
    required this.pageController,
    required this.titleTexEditingController,
    required this.descriptionTexEditingController,
    required this.sparePartFor,
    required this.addNewItem,
    required this.category,
    required this.itemUnit,
    required this.isSparePart,
    required this.itemImage,
  }) : super(key: key);

  final PageController pageController;

  final TextEditingController titleTexEditingController;
  final TextEditingController descriptionTexEditingController;

  final String category;
  final String itemUnit;

  final bool isSparePart;
  final List<String> sparePartFor;

  final File? itemImage;

  final Function(BuildContext context) addNewItem;

  @override
  Widget build(BuildContext context) {
    // category name
    String categoryName = '';
    final itemCategoryState = context.read<ItemCategoryBloc>().state;
    if (category.isNotEmpty && itemCategoryState is ItemCategoryLoadedState) {
      categoryName = itemCategoryState.allItemsCategories.allItemsCategories
          .firstWhere((cat) => cat.id == category)
          .name;
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          // vertical: 4,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                        top: 12,
                        left: 8,
                        right: 8,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.summary,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    // item name
                    InkWell(
                      onTap: () async => pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  validator: (val) {
                                    if (val!.length < 2) {
                                      return AppLocalizations.of(context)!
                                          .validation_min_two_characters;
                                    }
                                    return null;
                                  },
                                  controller: titleTexEditingController,
                                  decoration: InputDecoration(
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    labelText:
                                        AppLocalizations.of(context)!.item_name,
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                      color: titleTexEditingController
                                                  .text.length <
                                              2
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              titleTexEditingController.text.length < 2
                                  ? const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.done,
                                      color: Colors.grey.shade100,
                                    ),
                            ],
                          ),
                          // description
                          if (descriptionTexEditingController.text.isNotEmpty)
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    enabled: false,
                                    controller: descriptionTexEditingController,
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)!
                                          .item_description,
                                      border: InputBorder.none,
                                      labelStyle:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.done,
                                  color: Colors.grey.shade100,
                                ),
                              ],
                            ),
                          // category
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  controller:
                                      TextEditingController(text: categoryName),
                                  decoration: InputDecoration(
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    labelText: AppLocalizations.of(context)!
                                        .item_category,
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                      color: category.isEmpty
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              category.isEmpty
                                  ? const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.done,
                                      color: Colors.grey.shade100,
                                    ),
                            ],
                          ),
                          // item unit
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  enabled: false,
                                  controller: TextEditingController(
                                    text: getLocalizedUnitName(
                                      context,
                                      ItemUnit.fromString(
                                        itemUnit,
                                      ),
                                    ),
                                  ),
                                  decoration: InputDecoration(
                                    errorStyle:
                                        const TextStyle(color: Colors.red),
                                    labelText:
                                        AppLocalizations.of(context)!.item_unit,
                                    border: InputBorder.none,
                                    labelStyle: TextStyle(
                                      color: itemUnit.isEmpty
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              itemUnit.isEmpty
                                  ? const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.done,
                                      color: Colors.grey.shade100,
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // item photo
                    if (itemImage != null)
                      InkWell(
                        onTap: () async => pageController.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              AppLocalizations.of(context)!.item_photo,
                              style: const TextStyle(fontSize: 16),
                            )),
                            Icon(
                              Icons.done,
                              color: Colors.grey.shade100,
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    // not a spare part
                    if (!isSparePart)
                      InkWell(
                        onTap: () async => pageController.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              AppLocalizations.of(context)!.item_spare_part_not,
                              style: const TextStyle(fontSize: 16),
                            )),
                            Icon(
                              Icons.done,
                              color: Colors.grey.shade100,
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    // this is a spare part
                    if (isSparePart)
                      InkWell(
                        onTap: () async => pageController.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              AppLocalizations.of(context)!.item_spare_part_yes,
                              style: const TextStyle(fontSize: 16),
                            )),
                            Icon(
                              Icons.done,
                              color: Colors.grey.shade100,
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(
                      height: 4,
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
                    label: AppLocalizations.of(context)!
                        .user_profile_add_user_personal_data_save,
                    function: () {
                      addNewItem(context);
                    },
                    icon: Icons.save,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
