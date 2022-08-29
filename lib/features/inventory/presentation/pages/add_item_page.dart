import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:under_control_v2/features/inventory/data/models/item_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart';
import 'package:under_control_v2/features/inventory/presentation/widgets/add_item/add_item_summary_card.dart';

import '../../../core/presentation/pages/loading_page.dart';

import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../groups/presentation/widgets/add_group/add_group_name_card.dart';
import '../../domain/entities/item.dart';
import '../blocs/items/items_bloc.dart';
import '../widgets/add_item/add_item_card.dart';
import '../widgets/add_item/add_item_photo_card.dart';
import '../widgets/add_item/add_item_spare_part_card.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/inventory/add-item';

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  Item? item;

  List<Widget> pages = [];

  final _formKey = GlobalKey<FormState>();

  final pageController = PageController();

  final nameTexEditingController = TextEditingController();
  final descriptionTexEditingController = TextEditingController();
  final itemCodeTexEditingController = TextEditingController();
  String category = '';
  String itemUnit = '';
  bool isSparePart = false;
  List<String> sparePartFor = [];

  File? itemImage;

  void setIsSparePart(bool value) {
    setState(() {
      isSparePart = value;
    });
  }

  void setImage(ImageSource souruce) async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: souruce,
        imageQuality: 100,
        maxHeight: 500,
        maxWidth: 500,
      );
      if (pickedFile != null) {
        setState(() {
          itemImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!
            .user_profile_add_user_image_pisker_error,
      );
    }
  }

  void deleteImage() {
    setState(() {
      itemImage = null;
    });
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments != null && arguments is ItemModel) {
      item = arguments.deepCopy();

      nameTexEditingController.text = item!.name;
      descriptionTexEditingController.text = item!.description;
      itemCodeTexEditingController.text = item!.itemCode;
      category = item!.category;
      itemUnit = item!.itemUnit.name;
    }
    super.didChangeDependencies();
  }

  void addNewItem(BuildContext context) {
    String errorMessage = '';
    // item name validation
    if (!_formKey.currentState!.validate()) {
      errorMessage = AppLocalizations.of(context)!.item_add_error_name_to_short;
    } else {
      // category selection validation
      if (category.isEmpty) {
        errorMessage =
            AppLocalizations.of(context)!.item_add_error_category_not_selected;
      } else {
        // item unit selection validation

        if (itemUnit.isEmpty) {
          errorMessage =
              AppLocalizations.of(context)!.item_add_error_unit_not_selected;
        } else if (item == null) {
          final currentState = context.read<ItemsBloc>().state;
          if (currentState is ItemsLoadedState) {
            final tmpItems = currentState.allItems.allItems
                .where((i) => i.name == nameTexEditingController.text.trim());
            if (tmpItems.isNotEmpty) {
              errorMessage = AppLocalizations.of(context)!
                  .group_management_add_error_name_exists;
            }
          }
        }
      }
    }

    // shows SnackBar if validation error occures
    if (errorMessage.isNotEmpty) {
      showSnackBar(
        context: context,
        message: errorMessage,
        isErrorMessage: true,
      );
      // saves group to DB if no error
    } else {
      final newItem = ItemModel(
        id: item != null ? item!.id : '',
        name: nameTexEditingController.text,
        description: descriptionTexEditingController.text,
        category: category,
        itemCode: itemCodeTexEditingController.text,
        itemPhoto: '',
        itemUnit: ItemUnit.fromString(itemUnit),
        amountInLocations: const [],
        locations: const [],
        sparePartFor: sparePartFor,
      );

      if (item != null) {
        context.read<ItemsManagementBloc>().add(UpdateItemEvent(
              item: newItem,
              itemPhoto: itemImage,
            ));
      } else {
        context.read<ItemsManagementBloc>().add(
              AddItemEvent(item: newItem, itemPhoto: itemImage),
            );
      }

      Navigator.pop(context);
    }
  }

  void setCategory(String value) {
    setState(() {
      category = value;
    });
  }

  void setItemUnit(String value) {
    setState(() {
      itemUnit = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      KeepAlivePage(
        child: AddItemCard(
          isEditMode: item != null,
          pageController: pageController,
          nameTexEditingController: nameTexEditingController,
          descriptionTexEditingController: descriptionTexEditingController,
          category: category,
          itemUnit: itemUnit,
          setCategory: setCategory,
          setItemUnit: setItemUnit,
        ),
      ),
      KeepAlivePage(
        child: AddItemPhotoCard(
          pageController: pageController,
          setImage: setImage,
          deleteImage: deleteImage,
          image: itemImage,
        ),
      ),
      KeepAlivePage(
        child: AddItemSparePartCard(
          pageController: pageController,
          setIsSparePart: setIsSparePart,
          isSparePart: isSparePart,
        ),
      ),
      AddItemSummaryCard(
        pageController: pageController,
        titleTexEditingController: nameTexEditingController,
        descriptionTexEditingController: descriptionTexEditingController,
        sparePartFor: sparePartFor,
        addNewItem: addNewItem,
        category: category,
        itemUnit: itemUnit,
        isSparePart: isSparePart,
        itemImage: itemImage,
      ),
      // AddGroupFeaturesCard(
      //   pageController: pageController,
      //   features: features,
      // ),
      // AddGroupSummaryCard(
      //   pageController: pageController,
      //   addNewGroup: addNewGroup,
      //   nameTexEditingController: nameTexEditingController,
      //   descriptionTexEditingController: descriptionTexEditingController,
      //   totalSelectedLocations: totalSelectedLocations,
      //   features: features,
      // ),
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
