import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/pages/qr_scanner.dart';
import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/glass_layer.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../domain/entities/item.dart';
import '../../blocs/item_category/item_category_bloc.dart';
import '../../blocs/items/items_bloc.dart';
import '../item_tile.dart';
import '../shimmer_item_tile.dart';

class OverlayInventorySelection extends StatefulWidget {
  const OverlayInventorySelection({
    Key? key,
    required this.spareParts,
    required this.toggleSelection,
    required this.onDismiss,
    this.isMultiselection = false,
  }) : super(key: key);

  final List<String> spareParts;
  final Function(String) toggleSelection;
  final Function() onDismiss;
  final bool isMultiselection;

  @override
  State<OverlayInventorySelection> createState() =>
      _OverlayInventorySelectionState();
}

class _OverlayInventorySelectionState extends State<OverlayInventorySelection>
    with ResponsiveSize {
  String _searchQuery = '';

  final _searchTextEditingController = TextEditingController();

  void _pickCode(BuildContext context) async {
    FocusScope.of(context).unfocus();
    try {
      final code = await Navigator.pushNamed(context, QrScanner.routeName);
      if (code is String) {
        _searchTextEditingController.text = code;
        setState(() {
          _searchQuery = code;
        });
      }
    } catch (e) {
      showSnackBar(
          context: context,
          message: AppLocalizations.of(context)!.item_no_barcode);
    }
  }

  void _clearSearchQuery() {
    _searchTextEditingController.text = '';
    setState(() {
      _searchQuery = '';
    });
  }

  // search items according to given query string
  List<Item> _searchItems(
      BuildContext context, List<Item> items, String searchQuery) {
    if (searchQuery.trim().isNotEmpty) {
      final categoryState = context.read<ItemCategoryBloc>().state;
      if (categoryState is ItemCategoryLoadedState) {
        return items
            .where(
              (item) =>
                  item.producer
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()) ||
                  item.name
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()) ||
                  item.itemCode
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()) ||
                  item.itemBarCode
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()) ||
                  categoryState
                      .getItemCategoryById(item.category)!
                      .name
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()),
            )
            .toList();
      }
    }
    return items;
  }

  @override
  void dispose() {
    _searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GlassLayer(
        onDismiss: widget.onDismiss,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      fieldKey: 'search',
                      controller: _searchTextEditingController,
                      keyboardType: TextInputType.name,
                      labelText: AppLocalizations.of(context)!.search,
                      onChanged: (value) => setState(() {
                        _searchQuery = value!;
                      }),
                      suffixIcon: InkWell(
                        onTap: () => _clearSearchQuery(),
                        child: const Icon(
                          Icons.cancel,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  RoundedButton(
                    iconSize: 30,
                    padding: const EdgeInsets.all(9),
                    onPressed: () => _pickCode(context),
                    icon: Icons.qr_code_scanner,
                    gradient: LinearGradient(colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withAlpha(60),
                    ]),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<ItemsBloc, ItemsState>(
                    builder: (context, state) {
                      if (state is ItemsLoadedState) {
                        if (state.allItems.allItems.isEmpty) {
                          return Column(
                            children: [
                              SizedBox(
                                height: responsiveSizeVerticalPct(small: 40),
                              ),
                              Text(
                                AppLocalizations.of(context)!.item_no_items,
                              ),
                            ],
                          );
                        }
                        final filteredItems = _searchItems(
                          context,
                          state.allItems.allItems,
                          _searchQuery,
                        );
                        return ListView.builder(
                          padding: const EdgeInsets.only(top: 2),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            return ItemTile(
                              key: ValueKey(filteredItems[index].id),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              item: filteredItems[index],
                              searchQuery: _searchQuery,
                              isSelected: widget.isMultiselection
                                  ? null
                                  : widget.spareParts
                                      .contains(filteredItems[index].id),
                              onSelected: widget.isMultiselection
                                  ? (itemId) {
                                      widget.toggleSelection(itemId);
                                      widget.onDismiss();
                                    }
                                  : widget.toggleSelection,
                            );
                          },
                        );
                      } else {
                        // loading shimmer animation
                        return ListView.builder(
                          padding: const EdgeInsets.only(top: 2),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return const ShimmerItemTile();
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
