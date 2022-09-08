import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:under_control_v2/features/groups/presentation/pages/group_details.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/presentation/pages/add_item_page.dart';

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
  Item? item;
  late UserProfile currentUser;
  List<Choice> choices = [];

  bool isPhotoEditorVisible = false;

  void showPhotoEditor() {
    setState(() {
      isPhotoEditorVisible = true;
    });
  }

  void hidePhotoEditor() {
    setState(() {
      isPhotoEditorVisible = false;
    });
  }

  @override
  void didChangeDependencies() {
    // gets current user
    final currentState = context.read<UserProfileBloc>().state;
    if (currentState is Approved) {
      currentUser = currentState.userProfile;
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
        choices = [
          // edit item
          Choice(
            title: AppLocalizations.of(context)!.user_details_edit_avatar,
            icon: Icons.edit,
            onTap: () => Navigator.pushNamed(
              context,
              AddItemPage.routeName,
              arguments: item,
            ),
          ),
          // edit item image
          Choice(
            title: AppLocalizations.of(context)!.user_details_edit_avatar,
            icon: Icons.image,
            onTap: () => showPhotoEditor(),
          ),
        ];
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = '';
    if (isPhotoEditorVisible) {
      appBarTitle = AppLocalizations.of(context)!.user_details_edit_avatar;
    } else {
      appBarTitle = AppLocalizations.of(context)!.user_details_title;
    }
    return WillPopScope(
      onWillPop: () async {
        if (isPhotoEditorVisible) {
          hidePhotoEditor();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor.withAlpha(50),
          title: Text(appBarTitle),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
          ),
          actions: [
            // popup menu
            if (currentUser.administrator)
              PopupMenuButton<Choice>(
                onSelected: (Choice choice) {
                  if (isPhotoEditorVisible) {
                    hidePhotoEditor();
                  }
                  choice.onTap();
                },
                itemBuilder: (BuildContext context) {
                  return choices.map((Choice choice) {
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
            : BlocListener<ItemsManagementBloc, ItemsManagementState>(
                listener: (context, state) {
                  if (state is ItemsManagementSuccessState) {
                    String message = '';
                    switch (state.message) {
                      case ItemsMessage.itemUpdated:
                        message = 'AppLocalizations.of(context)! updated';
                        break;

                      case ItemsMessage.itemNotUpdated:
                        message = 'AppLocalizations.of(context)! Not updated';
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
                child: SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            // photo
                            if (item!.itemPhoto.isNotEmpty)
                              SizedBox(
                                width: responsiveSizePct(small: 100),
                                height: responsiveSizePct(small: 100),
                                child: Hero(
                                  tag: item!.id,
                                  child: CachedNetworkImage(
                                    imageUrl: item!.itemPhoto,
                                    placeholder: (context, url) =>
                                        const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const SizedBox(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            // user data
                            IconTitleRow(
                              icon: Icons.person,
                              iconColor: Colors.grey.shade300,
                              iconBackground: Colors.black,
                              title: AppLocalizations.of(context)!
                                  .user_details_data,
                              titleFontSize: 16,
                            ),
                            const SizedBox(
                              height: 8,
                            ),

                            const Divider(
                              indent: 8,
                              endIndent: 8,
                              thickness: 1.5,
                            ),

                            // user premissions
                          ],
                        ),
                      ),
                      // if (isPhotoEditorVisible)
                      //   AvatarEditorCard(
                      //     user: user!,
                      //     onDismiss: hideAvatarEditor,
                      //   ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
