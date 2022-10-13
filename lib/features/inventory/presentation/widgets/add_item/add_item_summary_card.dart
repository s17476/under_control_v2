import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/summary_card.dart';
import '../../../../core/utils/double_apis.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../domain/entities/item.dart';
import '../../../utils/get_localized_unit_name.dart';
import '../../blocs/item_category/item_category_bloc.dart';

class AddItemSummaryCard extends StatelessWidget with ResponsiveSize {
  const AddItemSummaryCard({
    Key? key,
    required this.pageController,
    required this.producerTextEditingController,
    required this.titleTextEditingController,
    required this.descriptionTextEditingController,
    required this.barCodeTextEditingController,
    required this.codeTextEditingController,
    required this.priceTextEditingController,
    required this.category,
    required this.itemUnit,
    required this.itemImage,
  }) : super(key: key);

  final PageController pageController;

  final TextEditingController producerTextEditingController;
  final TextEditingController titleTextEditingController;
  final TextEditingController descriptionTextEditingController;
  final TextEditingController barCodeTextEditingController;
  final TextEditingController codeTextEditingController;
  final TextEditingController priceTextEditingController;

  final String category;
  final String itemUnit;

  final File? itemImage;

  @override
  Widget build(BuildContext context) {
    // category name
    String categoryName = '';
    String priceString = '';
    final itemCategoryState = context.read<ItemCategoryBloc>().state;
    if (category.isNotEmpty && itemCategoryState is ItemCategoryLoadedState) {
      categoryName = itemCategoryState.allItemsCategories.allItemsCategories
          .firstWhere((cat) => cat.id == category)
          .name;
    }
    try {
      final price = double.parse(priceTextEditingController.text);

      priceString = price.toStringWithFixedDecimal();
    } catch (e) {
      priceString = priceTextEditingController.text;
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
                    // producer name
                    SummaryCard(
                      title: AppLocalizations.of(context)!.item_producer,
                      validator: () =>
                          producerTextEditingController.text.trim().length < 2
                              ? AppLocalizations.of(context)!
                                  .validation_min_two_characters
                              : null,
                      child: Text(producerTextEditingController.text.trim()),
                      pageController: pageController,
                      onTapAnimateToPage: 0,
                    ),

                    const SizedBox(
                      height: 8,
                    ),
                    // item name
                    SummaryCard(
                      title: AppLocalizations.of(context)!.item_name,
                      validator: () =>
                          titleTextEditingController.text.trim().length < 2
                              ? AppLocalizations.of(context)!
                                  .validation_min_two_characters
                              : null,
                      child: Text(titleTextEditingController.text.trim()),
                      pageController: pageController,
                      onTapAnimateToPage: 0,
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // description
                    if (descriptionTextEditingController.text.isNotEmpty)
                      SummaryCard(
                        title: AppLocalizations.of(context)!.item_description,
                        validator: () => null,
                        child:
                            Text(descriptionTextEditingController.text.trim()),
                        pageController: pageController,
                        onTapAnimateToPage: 0,
                      ),
                    if (descriptionTextEditingController.text.isNotEmpty)
                      const SizedBox(
                        height: 8,
                      ),

                    // category
                    SummaryCard(
                      title: AppLocalizations.of(context)!.item_category,
                      validator: () => category.isEmpty
                          ? AppLocalizations.of(context)!
                              .item_add_error_category_not_selected
                          : null,
                      child: Text(categoryName),
                      pageController: pageController,
                      onTapAnimateToPage: 1,
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    //item unit
                    SummaryCard(
                      title: AppLocalizations.of(context)!.item_unit,
                      validator: () => itemUnit.isEmpty
                          ? AppLocalizations.of(context)!
                              .item_add_error_unit_not_selected
                          : null,
                      child: Text(
                        getLocalizedUnitName(
                          context,
                          ItemUnit.fromString(
                            itemUnit,
                          ),
                        ),
                      ),
                      pageController: pageController,
                      onTapAnimateToPage: 1,
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    //item price
                    if (priceString.isNotEmpty && priceString != '0')
                      SummaryCard(
                        title: AppLocalizations.of(context)!
                            .item_unit_price_optional,
                        validator: () {
                          try {
                            final price =
                                double.parse(priceTextEditingController.text);
                            if (price < 0) {
                              return AppLocalizations.of(context)!
                                  .incorrect_price_to_small;
                            }
                          } catch (e) {
                            return AppLocalizations.of(context)!
                                .incorrect_price_format;
                          }
                          return null;
                        },
                        child: Text(priceString),
                        pageController: pageController,
                        onTapAnimateToPage: 1,
                      ),

                    if (priceString.isNotEmpty && priceString != '0')
                      const SizedBox(
                        height: 8,
                      ),

                    //item internal code
                    if (codeTextEditingController.text.trim().isNotEmpty)
                      SummaryCard(
                        title: AppLocalizations.of(context)!
                            .item_internal_code_optional,
                        validator: () => null,
                        child: Text(codeTextEditingController.text.trim()),
                        pageController: pageController,
                        onTapAnimateToPage: 1,
                      ),

                    if (codeTextEditingController.text.trim().isNotEmpty)
                      const SizedBox(
                        height: 8,
                      ),

                    //item bar/QR code
                    if (barCodeTextEditingController.text.trim().isNotEmpty)
                      SummaryCard(
                        title: AppLocalizations.of(context)!
                            .item_bar_code_optional,
                        validator: () => null,
                        child: Text(barCodeTextEditingController.text.trim()),
                        pageController: pageController,
                        onTapAnimateToPage: 1,
                      ),

                    if (barCodeTextEditingController.text.trim().isNotEmpty)
                      const SizedBox(
                        height: 8,
                      ),

                    // item photo
                    if (itemImage != null)
                      SummaryCard(
                        title: AppLocalizations.of(context)!.item_photo,
                        validator: () => null,
                        child: SizedBox(
                          width: responsiveSizePct(small: 100),
                          height: responsiveSizePct(small: 100),
                          child: Image.file(
                            itemImage!,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        pageController: pageController,
                        onTapAnimateToPage: 2,
                      ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
