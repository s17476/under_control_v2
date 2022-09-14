import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/actions/add_quantity_card.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/actions/add_to_item_summary_card.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/actions/add_to_location_card.dart';
import 'package:under_control_v2/features/inventory/utils/get_localized_unit_name.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../data/models/item_model.dart';
import '../../domain/entities/item.dart';
import '../blocs/items/items_bloc.dart';

class AddToItemPage extends StatefulWidget {
  const AddToItemPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/inventory/add-to-item';

  @override
  State<AddToItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddToItemPage> {
  Item? item;

  List<Widget> pages = [];

  final _formKey = GlobalKey<FormState>();

  final pageController = PageController();

  final quantityTextEditingController = TextEditingController(text: '0');

  String selectedLocation = '';

  void setLocation(String location) async {
    setState(() {
      selectedLocation = location;
    });
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments != null && arguments is ItemModel) {
      item = arguments.deepCopy();
    }
    super.didChangeDependencies();
  }

  void addToItem(BuildContext context) {
    String errorMessage = '';
    double amount = 0;
    // amount validation
    try {
      amount = double.parse(quantityTextEditingController.text);
      if (amount <= 0) {
        errorMessage = AppLocalizations.of(context)!.incorrect_number_to_small;
      }
    } catch (e) {
      errorMessage = AppLocalizations.of(context)!.incorrect_number_format;
    }
    // item name validation
    if (!_formKey.currentState!.validate()) {}
    // } else {
    //   // category selection validation
    //   if (category.isEmpty) {
    //     errorMessage =
    //         AppLocalizations.of(context)!.item_add_error_category_not_selected;
    //   } else {
    //     // item unit selection validation

    //     if (itemUnit.isEmpty) {
    //       errorMessage =
    //           AppLocalizations.of(context)!.item_add_error_unit_not_selected;
    //     } else if (item == null) {
    //       final currentState = context.read<ItemsBloc>().state;
    //       if (currentState is ItemsLoadedState) {
    //         final tmpItems = currentState.allItems.allItems
    //             .where((i) => i.name == nameTexEditingController.text.trim());
    //         if (tmpItems.isNotEmpty) {
    //           errorMessage = AppLocalizations.of(context)!
    //               .group_management_add_error_name_exists;
    //         }
    //       }
    //     }
    //   }
    // }

    //   // shows SnackBar if validation error occures
    if (errorMessage.isNotEmpty) {
      showSnackBar(
        context: context,
        message: errorMessage,
        isErrorMessage: true,
      );
      // saves group to DB if no error
    }
    //else {
    //     final newItem = ItemModel(
    //       id: item != null ? item!.id : '',
    //       name: nameTexEditingController.text,
    //       description: descriptionTexEditingController.text,
    //       category: category,
    //       itemCode: itemCodeTexEditingController.text,
    //       itemPhoto: item != null ? item!.itemPhoto : '',
    //       itemUnit: ItemUnit.fromString(itemUnit),
    //       amountInLocations: const [],
    //       locations: const [],
    //       sparePartFor: sparePartFor,
    //     );

    //     if (item != null) {
    //       context.read<ItemsManagementBloc>().add(UpdateItemEvent(
    //             item: newItem,
    //             itemPhoto: itemImage,
    //           ));
    //     } else {
    //       context.read<ItemsManagementBloc>().add(
    //             AddItemEvent(
    //               item: newItem,
    //               itemPhoto: itemImage,
    //             ),
    //           );
    //     }

    //     Navigator.pop(context);
    //   }
  }

  @override
  void dispose() {
    quantityTextEditingController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      KeepAlivePage(
        child: AddToLocationCard(
          pageController: pageController,
          selectedLocation: selectedLocation,
          setLocation: setLocation,
          title: AppLocalizations.of(context)!.item_add_to_location,
          item: item!,
        ),
      ),
      KeepAlivePage(
        child: AddQuantityCard(
          pageController: pageController,
          quantityTextEditingController: quantityTextEditingController,
          itemUnit: item!.itemUnit,
        ),
      ),
      AddToItemSummaryCard(
        pageController: pageController,
        quantityTextEditingController: quantityTextEditingController,
        selectedLocation: selectedLocation,
        itemUnit: getLocalizedUnitName(context, item!.itemUnit),
        addNewItem: addToItem,
      ),
    ];

    return Scaffold(body: BlocBuilder<ItemsBloc, ItemsState>(
      builder: (context, state) {
        if (state is ItemsLoadingState) {
          return const LoadingPage();
        } else {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Form(
                key: _formKey,
                child: PageView(
                  controller: pageController,
                  children: pages,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: pages.length,
                  effect: JumpingDotEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    jumpScale: 2,
                    activeDotColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          );
        }
      },
    ));
  }
}
