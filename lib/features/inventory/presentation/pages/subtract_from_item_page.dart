import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/double_apis.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
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
  ItemModel? _item;

  List<Widget> _pages = [];

  final _formKey = GlobalKey<FormState>();

  final _pageController = PageController();

  final _quantityTextEditingController = TextEditingController(text: '0');
  final _descriptionTextEditingController = TextEditingController();

  String _selectedLocation = '';

  double _maxQuantity = 0;

  DateTime _dateTime = DateTime.now();

  void _setLocation(String location) async {
    setState(() {
      _selectedLocation = location;
      final amountInLocation = _item!.amountInLocations
          .firstWhere((element) => element.locationId == location);
      _maxQuantity = amountInLocation.amount;
    });
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _setDate(DateTime date) {
    setState(() {
      _dateTime = date;
    });
  }

  void _subtractFromItem(BuildContext context) {
    String errorMessage = '';
    double quantity = 0;

    // location validation
    if (_selectedLocation.isEmpty) {
      errorMessage =
          AppLocalizations.of(context)!.validation_location_not_selected;
    } else {
      // quantity validation
      try {
        quantity = double.parse(_quantityTextEditingController.text);
        if (quantity <= 0) {
          errorMessage =
              AppLocalizations.of(context)!.incorrect_number_to_small;
        } else if (_maxQuantity != 0 && quantity > _maxQuantity) {
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
            description: _descriptionTextEditingController.text.trim(),
            ammount: double.parse(quantity.toStringWithFixedDecimal()),
            itemUnit: _item!.itemUnit,
            locationId: _selectedLocation,
            date: _dateTime,
            itemId: _item!.id,
            userId: (context.read<UserProfileBloc>().state as Approved)
                .userProfile
                .id,
          );

          context.read<ItemActionManagementBloc>().add(
                AddItemActionEvent(
                  item: _item!,
                  itemAction: newItemAction,
                ),
              );

          Navigator.pop(context);
        }
        // description validation
      } else {
        if (errorMessage.isEmpty &&
            _descriptionTextEditingController.text.trim().length < 2) {
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
  void initState() {
    _pageController.addListener(() {
      FocusScope.of(context).unfocus();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments != null && arguments is ItemModel) {
      _item = arguments.deepCopy();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _quantityTextEditingController.dispose();
    _descriptionTextEditingController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      KeepAlivePage(
        child: AddToLocationCard(
          selectedLocation: _selectedLocation,
          setLocation: _setLocation,
          title: AppLocalizations.of(context)!.item_subtract_from_location,
          item: _item!,
          isSubtract: true,
        ),
      ),
      KeepAlivePage(
        child: AddQuantityCard(
          quantityTextEditingController: _quantityTextEditingController,
          itemUnit: _item!.itemUnit,
          maxQuantity: _maxQuantity,
        ),
      ),
      KeepAlivePage(
        child: AddDateAndDescriptionCard(
          descriptionTextEditingController: _descriptionTextEditingController,
          dateTime: _dateTime,
          setDate: _setDate,
        ),
      ),
      AddToItemSummaryCard(
        pageController: _pageController,
        quantityTextEditingController: _quantityTextEditingController,
        selectedLocation: _selectedLocation,
        itemUnit: getLocalizedUnitName(context, _item!.itemUnit),
        maxQuantity: _maxQuantity,
        addNewItem: _subtractFromItem,
        dateTime: _dateTime,
        descriptionTextEditingController: _descriptionTextEditingController,
      ),
    ];

    DateTime preBackpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        // double click to exit the app
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          showSnackBar(
            context: context,
            message: AppLocalizations.of(context)!.back_to_exit_creator,
            isErrorMessage: true,
          );
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(body: BlocBuilder<ItemsBloc, ItemsState>(
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
                    controller: _pageController,
                    children: _pages,
                  ),
                ),
                CreatorBottomNavigation(
                  lastPageForwardButtonFunction: () =>
                      _subtractFromItem(context),
                  pages: _pages,
                  pageController: _pageController,
                ),
              ],
            );
          }
        },
      )),
    );
  }
}
