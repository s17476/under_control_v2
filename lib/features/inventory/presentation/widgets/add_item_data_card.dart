import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/backward_text_button.dart';
import '../../../core/presentation/widgets/forward_text_button.dart';
import '../../domain/entities/item_category/item_category.dart';
import '../blocs/item_category/item_category_bloc.dart';

class AddItemDataCard extends StatefulWidget {
  const AddItemDataCard({
    Key? key,
    required this.pageController,
    required this.setCategory,
    required this.category,
  }) : super(key: key);

  final PageController pageController;
  final Function(String category) setCategory;
  final String category;

  @override
  State<AddItemDataCard> createState() => _AddItemDataCardState();
}

class _AddItemDataCardState extends State<AddItemDataCard> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // title
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12,
                      left: 8,
                      right: 8,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.item_data,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline5!.fontSize,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  // category
                  BlocBuilder<ItemCategoryBloc, ItemCategoryState>(
                    builder: (context, state) {
                      if (state is ItemCategoryLoadedState) {
                        final dropdownItems =
                            state.allItemsCategories.allItemsCategories
                                .map<DropdownMenuItem<String>>(
                                  (cat) => DropdownMenuItem(
                                    value: cat.id,
                                    child: Text(cat.name),
                                  ),
                                )
                                .toList();
                        if (widget.category.isEmpty) {
                          dropdownItems.add(
                            const DropdownMenuItem(
                              child: Text(''),
                              value: '',
                            ),
                          );
                        }
                        return DropdownButton<String>(
                          value: widget.category,
                          items: dropdownItems,
                          onChanged: (value) {
                            if (value != widget.category) {
                              widget.setCategory(value!);
                            }
                          },
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  )
                ],
              ),
            ),
          ),

          // bottom navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackwardTextButton(
                  icon: Icons.arrow_back_ios_new,
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label: AppLocalizations.of(context)!
                      .user_profile_add_user_personal_data_back,
                  function: () => widget.pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
                ForwardTextButton(
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label:
                      AppLocalizations.of(context)!.user_profile_add_user_next,
                  function: () => widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  icon: Icons.arrow_forward_ios_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
