import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/double_apis.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../data/models/item_action/item_action_model.dart';
import '../../data/models/item_model.dart';
import '../../domain/entities/item_action/item_action.dart';
import '../../utils/get_localized_unit_name.dart';
import '../blocs/item_action_management/item_action_management_bloc.dart';
import '../blocs/items/items_bloc.dart';
import '../widgets/actions/add_date_and_description_card.dart';
import '../widgets/actions/add_quantity_card.dart';
import '../widgets/actions/add_to_item_summary_card.dart';
import '../widgets/actions/add_to_location_card.dart';

class SubtractFromItemPage extends StatefulWidget {
  const SubtractFromItemPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/inventory/subtract-from-item';

  @override
  State<SubtractFromItemPage> createState() => _SubtractFromPageState();
}

class _SubtractFromPageState extends State<SubtractFromItemPage> {
  ItemModel? item;

  List<Widget> pages = [];

  final _formKey = GlobalKey<FormState>();

  final pageController = PageController();

  final quantityTextEditingController = TextEditingController(text: '0');

  final descriptionTextEditingController = TextEditingController();

  String selectedLocation = '';

  double maxQuantity = 0;

  DateTime dateTime = DateTime.now();

  void setLocation(String location) async {
    setState(() {
      selectedLocation = location;
      final amountInLocation = item!.amountInLocations
          .firstWhere((element) => element.locationId == location);
      maxQuantity = amountInLocation.amount;
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

  void setDate(DateTime date) {
    setState(() {
      dateTime = date;
    });
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments != null && arguments is ItemModel) {
      item = arguments.deepCopy();
    }
    super.didChangeDependencies();
  }

  void subtractFromItem(BuildContext context) {
    String errorMessage = '';
    double quantity = 0;

    // location validation
    if (selectedLocation.isEmpty) {
      errorMessage =
          AppLocalizations.of(context)!.validation_location_not_selected;
    } else {
      // quantity validation
      try {
        quantity = double.parse(quantityTextEditingController.text);
        if (quantity <= 0) {
          errorMessage =
              AppLocalizations.of(context)!.incorrect_number_to_small;
        } else if (maxQuantity != 0 && quantity > maxQuantity) {
          errorMessage = AppLocalizations.of(context)!.incorrect_number_to_big;
        }
      } catch (e) {
        errorMessage = AppLocalizations.of(context)!.incorrect_number_format;
      }
      // text fields validation
      if (_formKey.currentState!.validate()) {
        if (errorMessage.isEmpty) {
          // save new item action
          final newItemAction = ItemActionModel(
            id: '',
            type: ItemActionType.remove,
            description: descriptionTextEditingController.text.trim(),
            ammount: double.parse(quantity.toStringWithFixedDecimal()),
            itemUnit: item!.itemUnit,
            locationId: selectedLocation,
            date: dateTime,
            itemId: item!.id,
          );

          context.read<ItemActionManagementBloc>().add(
                AddItemActionEvent(
                  item: item!,
                  itemAction: newItemAction,
                ),
              );

          Navigator.pop(context);
        }
        // description validation
      } else {
        if (errorMessage.isEmpty &&
            descriptionTextEditingController.text.trim().length < 2) {
          errorMessage =
              AppLocalizations.of(context)!.validation_no_description;
        }
      }
    }

    //   // shows SnackBar if validation error occures
    if (errorMessage.isNotEmpty) {
      showSnackBar(
        context: context,
        message: errorMessage,
        isErrorMessage: true,
      );
    }
  }

  @override
  void dispose() {
    quantityTextEditingController.dispose();
    descriptionTextEditingController.dispose();
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
          title: AppLocalizations.of(context)!.item_subtract_from_location,
          item: item!,
          isSubtract: true,
        ),
      ),
      KeepAlivePage(
        child: AddQuantityCard(
          pageController: pageController,
          quantityTextEditingController: quantityTextEditingController,
          itemUnit: item!.itemUnit,
          maxQuantity: maxQuantity,
        ),
      ),
      KeepAlivePage(
        child: AddDateAndDescriptionCard(
          pageController: pageController,
          descriptionTextEditingController: descriptionTextEditingController,
          dateTime: dateTime,
          setDate: setDate,
        ),
      ),
      AddToItemSummaryCard(
        pageController: pageController,
        quantityTextEditingController: quantityTextEditingController,
        selectedLocation: selectedLocation,
        itemUnit: getLocalizedUnitName(context, item!.itemUnit),
        maxQuantity: maxQuantity,
        addNewItem: subtractFromItem,
        dateTime: dateTime,
        descriptionTextEditingController: descriptionTextEditingController,
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
