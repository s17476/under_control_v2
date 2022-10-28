import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
import '../widgets/actions/add_to_location_card.dart';
import '../widgets/actions/move_inside_item_summary_card.dart';

class MoveInsideItemPage extends StatefulWidget {
  const MoveInsideItemPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/inventory/move_inside-item';

  @override
  State<MoveInsideItemPage> createState() => _MoveInsideItemPageState();
}

class _MoveInsideItemPageState extends State<MoveInsideItemPage> {
  ItemModel? _item;

  List<Widget> _pages = [];

  final _formKey = GlobalKey<FormState>();

  final _pageController = PageController();

  final _quantityTextEditingController = TextEditingController(text: '0');
  final _descriptionTextEditingController = TextEditingController();

  String _selectedFromLocation = '';
  String _selectedToLocation = '';

  double _maxQuantity = 0;

  DateTime _dateTime = DateTime.now();

  void _setFromLocation(String location) async {
    setState(() {
      _selectedFromLocation = location;
      final amountInLocation = _item!.amountInLocations
          .firstWhere((element) => element.locationId == location);
      _maxQuantity = amountInLocation.amount;
      if (_selectedToLocation == _selectedFromLocation) {
        _selectedToLocation = '';
      }
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

  void _setToLocation(String location) async {
    setState(() {
      _selectedToLocation = location;
    });
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    _pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void _setDate(DateTime date) {
    setState(() {
      _dateTime = date;
    });
  }

  void _moveInsideItem(BuildContext context) {
    String errorMessage = '';
    double quantity = 0;

    // from location validation
    if (_selectedFromLocation.isEmpty) {
      errorMessage =
          AppLocalizations.of(context)!.validation_location_not_selected;
    } else {
      // to location validation
      if (_selectedToLocation.isEmpty) {
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
            errorMessage =
                AppLocalizations.of(context)!.incorrect_number_to_big;
          }
        } catch (e) {
          errorMessage = AppLocalizations.of(context)!.incorrect_number_format;
        }
        // text fields validation
        if (_formKey.currentState!.validate()) {
          if (errorMessage.isEmpty) {
            final userId = (context.read<UserProfileBloc>().state as Approved)
                .userProfile
                .id;

            // subtract item action
            final subtractItemAction = ItemActionModel(
              id: '',
              type: ItemActionType.moveRemove,
              description: _descriptionTextEditingController.text.trim(),
              ammount: double.parse(quantity.toStringWithFixedDecimal()),
              itemUnit: _item!.itemUnit,
              locationId: _selectedFromLocation,
              date: _dateTime,
              itemId: _item!.id,
              userId: userId,
            );

            // add item action
            final addItemAction = ItemActionModel(
              id: '',
              type: ItemActionType.moveAdd,
              description: _descriptionTextEditingController.text.trim(),
              ammount: double.parse(quantity.toStringWithFixedDecimal()),
              itemUnit: _item!.itemUnit,
              locationId: _selectedToLocation,
              date: DateTime(
                _dateTime.year,
                _dateTime.month,
                _dateTime.day,
                _dateTime.hour,
                _dateTime.minute,
                _dateTime.second + 1,
              ),
              itemId: _item!.id,
              userId: userId,
            );

            context.read<ItemActionManagementBloc>().add(
                  MoveItemActionEvent(
                    item: _item!,
                    oldItemAction: subtractItemAction,
                    itemAction: addItemAction,
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
          selectedLocation: _selectedFromLocation,
          setLocation: _setFromLocation,
          title: AppLocalizations.of(context)!.item_subtract_from_location,
          item: _item!,
          isSubtract: true,
        ),
      ),
      KeepAlivePage(
        child: AddToLocationCard(
          selectedLocation: _selectedToLocation,
          selectedFromLocation: _selectedFromLocation,
          setLocation: _setToLocation,
          title: AppLocalizations.of(context)!.item_add_to_location,
          item: _item!,
          isFirstPage: false,
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
      MoveInsideItemSummaryCard(
        pageController: _pageController,
        quantityTextEditingController: _quantityTextEditingController,
        selectedFromLocation: _selectedFromLocation,
        selectedToLocation: _selectedToLocation,
        itemUnit: getLocalizedUnitName(context, _item!.itemUnit),
        maxQuantity: _maxQuantity,
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
                  lastPageForwardButtonFunction: () => _moveInsideItem(context),
                  pages: _pages,
                  pageController: _pageController,
                )
              ],
            );
          }
        },
      )),
    );
  }
}
