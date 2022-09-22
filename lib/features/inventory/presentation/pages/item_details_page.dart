import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/qr_code_row.dart';
import 'package:under_control_v2/features/inventory/utils/show_item_delete_dialog.dart';

import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/utils/choice.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../domain/entities/item.dart';
import '../../utils/get_item_total_quantity.dart';
import '../../utils/item_action_management_bloc_listener.dart';
import '../../utils/item_management_bloc_listener.dart';
import '../blocs/item_action/item_action_bloc.dart';
import '../blocs/item_action_management/item_action_management_bloc.dart';
import '../blocs/items/items_bloc.dart';
import '../blocs/items_management/items_management_bloc.dart';
import '../widgets/actions/items_in_locations.dart';
import '../widgets/actions/last_five_item_actions.dart';
import '../widgets/internal_code_row.dart';
import '../widgets/item_category_row.dart';
import '../widgets/item_unit_row.dart';
import '../widgets/overlay_info_box.dart';
import '../widgets/price_row.dart';
import '../widgets/square_item_image.dart';
import 'add_item_page.dart';
import 'add_to_item_page.dart';
import 'move_inside_item_page.dart';
import 'subtract_from_item_page.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/inventory/item-details';

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> with ResponsiveSize {
  Item? item;
  late UserProfile _currentUser;

  List<Choice> _choices = [];

  @override
  void didChangeDependencies() {
    // gets current user
    final currentState = context.read<UserProfileBloc>().state;
    if (currentState is Approved) {
      _currentUser = currentState.userProfile;
    }
    // gets selected item
    final itemId = (ModalRoute.of(context)?.settings.arguments as Item).id;
    final itemsState = context.watch<ItemsBloc>().state;
    if (itemsState is ItemsLoadedState) {
      final index = itemsState.allItems.allItems
          .indexWhere((element) => element.id == itemId);
      if (index >= 0) {
        setState(() {
          item = itemsState.allItems.allItems[index];
        });
        // popup menu items
        _choices = [
          // edit item
          Choice(
            title: AppLocalizations.of(context)!.edit,
            icon: Icons.edit,
            onTap: () => Navigator.pushNamed(
              context,
              AddItemPage.routeName,
              arguments: item,
            ),
          ),
          if (_currentUser.administrator)
            Choice(
              title: AppLocalizations.of(context)!.delete,
              icon: Icons.delete,
              onTap: () async {
                if (getItemTotalQuantity(item!) > 0) {
                  showSnackBar(
                    context: context,
                    message: AppLocalizations.of(context)!
                        .item_details_cannot_delete,
                    isErrorMessage: true,
                  );
                } else {
                  final result =
                      await showItemDeleteDialog(context: context, item: item!);
                  if (result != null && result) {
                    Navigator.pop(context);
                  }
                }
              },
            ),
        ];
        // gets last actions for selected item
        context.read<ItemActionBloc>().add(
              GetLastFiveItemActionsEvent(
                item: item!,
                companyId: _currentUser.companyId,
              ),
            );
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = '';

    appBarTitle = AppLocalizations.of(context)!.item_details_title;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: true,
        actions: [
          // popup menu
          if (_currentUser.administrator)
            PopupMenuButton<Choice>(
              onSelected: (Choice choice) {
                choice.onTap();
              },
              itemBuilder: (BuildContext context) {
                return _choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(choice.icon),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          choice.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
        ],
      ),
      body: item == null
          ? const LoadingWidget()
          : MultiBlocListener(
              listeners: [
                BlocListener<ItemsManagementBloc, ItemsManagementState>(
                  listener: (context, state) =>
                      itemManagementBlocListener(context, state),
                ),
                BlocListener<ItemActionManagementBloc,
                    ItemActionManagementState>(
                  listener: (context, state) =>
                      itemActionManagementBlocListener(context, state),
                ),
              ],
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // item photo and quantity
                    Stack(
                      children: [
                        // item photo
                        SquareItemImage(item: item!),
                        // quantity info boxes
                        Row(
                          children: [
                            OverlayQuantityInfoBox(
                              item: item,
                              quantity: getItemTotalQuantity(item!),
                              title: AppLocalizations.of(context)!
                                  .item_total_quantity,
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                            OverlayQuantityInfoBox(
                              item: item,
                              quantity: getItemTotalQuantity(item!),
                              title: AppLocalizations.of(context)!
                                  .item_in_selected_quantity,
                              quantityStyle: TextStyle(
                                fontSize: 24,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        // overlay item data
                        Positioned(
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                              bottom: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0.5),
                                  Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0.9),
                                  Theme.of(context).scaffoldBackgroundColor,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            width: responsiveSizePct(small: 100),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // name
                                Text(
                                  item!.name,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                // description
                                Text(
                                  item!.description,
                                  style: const TextStyle(fontSize: 16),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // item data
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          const Divider(
                            thickness: 1.5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconTitleRow(
                                  icon: Icons.api,
                                  iconColor: Colors.grey.shade300,
                                  iconBackground: Colors.black,
                                  title: AppLocalizations.of(context)!
                                      .item_details_data,
                                  titleFontSize: 16,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                // category
                                ItemCategoryRow(item: item),
                                const SizedBox(height: 16),
                                // unit
                                ItemUnitRow(item: item),
                                // qr code
                                if (item!.itemBarCode.isNotEmpty)
                                  const SizedBox(height: 16),
                                if (item!.itemBarCode.isNotEmpty)
                                  QrCodeRow(item: item),
                                // internal code
                                if (item!.itemCode.isNotEmpty)
                                  const SizedBox(height: 16),
                                if (item!.itemCode.isNotEmpty)
                                  InternalCodeRow(item: item),
                                // price
                                if (item!.price > 0) const SizedBox(height: 16),
                                if (item!.price > 0) PriceRow(item: item)
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1.5,
                          ),
                          // actions
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconTitleRow(
                                  icon: Icons.edit,
                                  iconColor: Colors.white,
                                  iconBackground: Colors.black,
                                  title: AppLocalizations.of(context)!.actions,
                                  titleFontSize: 16,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    // add button
                                    Expanded(
                                      child: RoundedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            AddToItemPage.routeName,
                                            arguments: item,
                                          );
                                        },
                                        icon: Icons.add,
                                        iconSize: 40,
                                        title:
                                            AppLocalizations.of(context)!.add,
                                        titleSize: 16,
                                        foregroundColor: Colors.grey.shade200,
                                        padding: const EdgeInsets.all(16),
                                        gradient: LinearGradient(
                                          colors: [
                                            Theme.of(context).primaryColor,
                                            Theme.of(context)
                                                .primaryColor
                                                .withAlpha(60),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    // move button
                                    Expanded(
                                      child: RoundedButton(
                                        onPressed: getItemTotalQuantity(item!) >
                                                0
                                            ? () {
                                                Navigator.pushNamed(
                                                  context,
                                                  MoveInsideItemPage.routeName,
                                                  arguments: item,
                                                );
                                              }
                                            : () {},
                                        icon: Icons.compare_arrows_outlined,
                                        iconSize: 40,
                                        title:
                                            AppLocalizations.of(context)!.move,
                                        titleSize: 16,
                                        foregroundColor: Colors.grey.shade200,
                                        padding: const EdgeInsets.all(16),
                                        gradient: LinearGradient(
                                          colors:
                                              getItemTotalQuantity(item!) > 0
                                                  ? [
                                                      Colors.blue.shade700,
                                                      Colors.blue.shade700
                                                          .withAlpha(60),
                                                    ]
                                                  : [
                                                      Colors.grey,
                                                      Colors.grey.withAlpha(60),
                                                    ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                      width: 16,
                                    ),
                                    // subtract button
                                    Expanded(
                                      child: RoundedButton(
                                        onPressed:
                                            getItemTotalQuantity(item!) > 0
                                                ? () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      SubtractFromItemPage
                                                          .routeName,
                                                      arguments: item,
                                                    );
                                                  }
                                                : () {},
                                        icon: Icons.remove,
                                        iconSize: 40,
                                        title: AppLocalizations.of(context)!
                                            .subtract,
                                        titleSize: 16,
                                        foregroundColor: Colors.grey.shade200,
                                        padding: const EdgeInsets.all(16),
                                        gradient: LinearGradient(
                                          colors:
                                              getItemTotalQuantity(item!) > 0
                                                  ? [
                                                      Colors.red.shade600,
                                                      Colors.red.shade600
                                                          .withAlpha(60),
                                                    ]
                                                  : [
                                                      Colors.grey,
                                                      Colors.grey.withAlpha(60),
                                                    ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1.5,
                          ),
                          LastFiveItemActions(item: item!),
                          const Divider(
                            thickness: 1.5,
                          ),
                          ItemsInLocations(item: item!),
                          const Divider(
                            thickness: 1.5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
