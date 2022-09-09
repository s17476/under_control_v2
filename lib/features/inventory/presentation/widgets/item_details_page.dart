import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:under_control_v2/features/groups/presentation/pages/group_details.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart';
import 'package:under_control_v2/features/inventory/presentation/pages/add_item_page.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/get_localized_unit_name.dart';

import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../company_profile/presentation/widgets/user_management_dialogs.dart';
import '../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/presentation/widgets/url_launcher_helpers.dart';
import '../../../core/utils/choice.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../core/utils/size_config.dart';
import '../../../groups/domain/entities/group.dart';
import '../../../groups/presentation/blocs/group/group_bloc.dart';
import '../../../groups/presentation/widgets/group_management/group_tile.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../blocs/items/items_bloc.dart';
import '../blocs/items_management/items_management_bloc.dart';

class ItemDetailsPage extends StatefulWidget {
  const ItemDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/inventory/item-details';

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> with ResponsiveSize {
  Item? _item;
  late UserProfile _currentUser;

  List<Choice> _choices = [];

  String _category = '';

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
          _item = itemsState.allItems.allItems[index];
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
              arguments: _item,
            ),
          ),
        ];
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
      body: _item == null
          ? const LoadingWidget()
          : BlocListener<ItemsManagementBloc, ItemsManagementState>(
              listener: (context, state) {
                if (state is ItemsManagementSuccessState) {
                  String message = '';
                  switch (state.message) {
                    case ItemsMessage.itemUpdated:
                      message = AppLocalizations.of(context)!.item_msg_updated;
                      break;

                    case ItemsMessage.itemNotUpdated:
                      message =
                          AppLocalizations.of(context)!.item_msg_not_updated;
                      break;

                    default:
                      message = '';
                      break;
                  }
                  if (message.isNotEmpty) {
                    showSnackBar(
                      context: context,
                      message: message,
                      isErrorMessage: state.error,
                    );
                  }
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // photo
                    if (_item!.itemPhoto.isNotEmpty)
                      SizedBox(
                        width: responsiveSizePct(small: 100),
                        height: responsiveSizePct(small: 100),
                        child: Hero(
                          tag: _item!.id,
                          child: CachedNetworkImage(
                            imageUrl: _item!.itemPhoto,
                            placeholder: (context, url) => const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const SizedBox(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                    // item data
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // item name and description
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 8,
                              left: 8,
                              right: 8,
                            ),
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
                                  height: 4,
                                ),
                                // name
                                Text(
                                  _item!.name,
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
                                  _item!.name,
                                  style: const TextStyle(fontSize: 16),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                // category
                                Row(
                                  children: [
                                    Expanded(
                                      child: IconTitleRow(
                                        icon: Icons.category,
                                        iconColor: Colors.grey.shade300,
                                        iconBackground:
                                            Theme.of(context).primaryColor,
                                        title: AppLocalizations.of(context)!
                                            .item_details_category,
                                        titleFontSize: 16,
                                      ),
                                    ),
                                    BlocBuilder<ItemCategoryBloc,
                                        ItemCategoryState>(
                                      builder: (context, state) {
                                        if (state is ItemCategoryLoadedState) {
                                          final categoryIdex = state
                                              .allItemsCategories
                                              .allItemsCategories
                                              .indexWhere((element) =>
                                                  element.id ==
                                                  _item!.category);
                                          if (categoryIdex >= 0) {
                                            return Text(
                                              state
                                                  .allItemsCategories
                                                  .allItemsCategories[
                                                      categoryIdex]
                                                  .name,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            );
                                          } else {
                                            return Text(
                                              AppLocalizations.of(context)!
                                                  .item_details_category_not_found,
                                            );
                                          }
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                // unit
                                Row(
                                  children: [
                                    Expanded(
                                      child: IconTitleRow(
                                        icon: Icons.balance,
                                        iconColor: Colors.grey.shade300,
                                        iconBackground:
                                            Theme.of(context).primaryColor,
                                        title: AppLocalizations.of(context)!
                                            .item_unit,
                                        titleFontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      getLocalizedUnitName(
                                        context,
                                        _item!.itemUnit,
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
                          //
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 4,
                              left: 8,
                              right: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
