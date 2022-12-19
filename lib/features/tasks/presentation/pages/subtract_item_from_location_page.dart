import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../inventory/domain/entities/item.dart';
import '../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../inventory/presentation/widgets/actions/add_quantity_card.dart';
import '../../../inventory/presentation/widgets/actions/add_to_location_card.dart';
import '../../data/models/task/spare_part_item_model.dart';
import '../blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart';

class SubtractItemFromLocationPage extends StatefulWidget {
  const SubtractItemFromLocationPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/task-action/subtract-from-item';

  @override
  State<SubtractItemFromLocationPage> createState() =>
      _SubtractItemFromLocationPageState();
}

class _SubtractItemFromLocationPageState
    extends State<SubtractItemFromLocationPage> {
  Item? _item;

  SparePartItemModel? _sparePartItemModel;

  List<Widget> _pages = [];

  final _pageController = PageController();

  final _quantityTextEditingController = TextEditingController(text: '0');

  String _selectedLocation = '';

  double _maxQuantity = 0;

  void _setLocation(String location) async {
    double reservedQuantity = 0;
    final state = context.read<ReservedSparePartsBloc>().state;
    if (state is ReservedSparePartsActiveState) {
      reservedQuantity = state.getReservedQuantity(_item!.id, location);
    }
    setState(() {
      _selectedLocation = location;
      final amountInLocation = _item!.amountInLocations
          .firstWhere((element) => element.locationId == location);
      _maxQuantity = amountInLocation.amount - reservedQuantity;
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

  void _subtractFromItem() {
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

      if (errorMessage.isEmpty) {
        final updatedSparePartItem = SparePartItemModel(
          itemId: _sparePartItemModel!.itemId,
          locationId: _selectedLocation,
          quantity: quantity,
        );
        Navigator.pop(context, updatedSparePartItem);
      }
    }

    // shows SnackBar if validation error occures
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

    if (arguments != null && arguments is SparePartItemModel) {
      _sparePartItemModel = arguments;
      final itemsState = context.watch<ItemsBloc>().state;
      if (itemsState is ItemsLoadedState) {
        _item = itemsState.getItemById(_sparePartItemModel!.itemId);
      }
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _quantityTextEditingController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_item == null) {
      return const LoadingPage();
    }
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
                PageView(
                  controller: _pageController,
                  children: _pages,
                ),
                CreatorBottomNavigation(
                  lastPageForwardButtonFunction: () => _subtractFromItem(),
                  lastPageForwardButtonLabel: AppLocalizations.of(context)!.add,
                  lastPageForwardButtonIconData: Icons.add,
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
