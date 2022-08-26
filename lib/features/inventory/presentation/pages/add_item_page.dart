import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:under_control_v2/features/inventory/data/models/item_model.dart';

import '../../../core/presentation/pages/loading_page.dart';

import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../groups/presentation/widgets/add_group/add_group_name_card.dart';
import '../../domain/entities/item.dart';
import '../blocs/items/items_bloc.dart';
import '../widgets/add_item_card.dart';
import '../widgets/add_item_data_card.dart';

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
  ItemUnit itemUnit = ItemUnit.unknown;

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments != null && arguments is ItemModel) {
      item = arguments.deepCopy();

      nameTexEditingController.text = item!.name;
      descriptionTexEditingController.text = item!.description;
      itemCodeTexEditingController.text = item!.itemCode;
      category = item!.category;
      itemUnit = item!.itemUnit;
    }
    super.didChangeDependencies();
  }

  // add new group
  // void addNewGroup(BuildContext context) {
  //   String errorMessage = '';
  //   // group name validation
  //   if (!_formKey.currentState!.validate()) {
  //     errorMessage = AppLocalizations.of(context)!
  //         .group_management_add_error_name_to_short;
  //   } else {
  //     // locations selection validation
  //     if (selectedLocations.isEmpty) {
  //       errorMessage = AppLocalizations.of(context)!
  //           .group_management_add_error_no_location_selected;
  //     } else {
  //       // premissions validation
  //       bool isAtLeastOneFeatureSelected = false;
  //       for (var feature in features) {
  //         if (feature.create ||
  //             feature.delete ||
  //             feature.edit ||
  //             feature.read) {
  //           isAtLeastOneFeatureSelected = true;
  //         }
  //       }
  //       if (!isAtLeastOneFeatureSelected) {
  //         errorMessage = AppLocalizations.of(context)!
  //             .group_management_add_error_no_premission_selected;
  //         // group name validation
  //       } else if (group == null) {
  //         final currentState = context.read<GroupBloc>().state;
  //         if (currentState is GroupLoadedState) {
  //           final tmpGroups = currentState.allGroups.allGroups.where(
  //               (group) => group.name == nameTexEditingController.text.trim());
  //           if (tmpGroups.isNotEmpty) {
  //             errorMessage = AppLocalizations.of(context)!
  //                 .group_management_add_error_name_exists;
  //           }
  //         }
  //       }
  //     }
  //   }

  //   // shows SnackBar if validation error occures
  //   if (errorMessage.isNotEmpty) {
  //     showSnackBar(
  //       context: context,
  //       message: errorMessage,
  //       isErrorMessage: true,
  //     );
  //     // saves group to DB if no error
  //   } else {
  //     final newGroup = GroupModel(
  //       id: (group != null) ? group!.id : '',
  //       name: nameTexEditingController.text,
  //       description: descriptionTexEditingController.text,
  //       groupAdministrators: const [],
  //       locations: totalSelectedLocations,
  //       features: features,
  //     );

  //     if (group != null) {
  //       context.read<GroupBloc>().add(UpdateGroupEvent(group: newGroup));
  //     } else {
  //       context.read<GroupBloc>().add(
  //             AddGroupEvent(group: newGroup),
  //           );
  //     }

  //     Navigator.pop(context);
  //   }
  // }

  void setCategory(String value) {
    setState(() {
      category = value;
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
        ),
      ),
      KeepAlivePage(
        child: AddItemDataCard(
          pageController: pageController,
          category: category,
          setCategory: setCategory,
        ),
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
