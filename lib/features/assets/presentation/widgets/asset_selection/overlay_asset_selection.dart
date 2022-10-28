import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/pages/qr_scanner.dart';
import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/glass_layer.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../../utils/search_assets.dart';
import '../../blocs/asset/asset_bloc.dart';
import '../asset_tile.dart';

class OverlayAssetSelection extends StatefulWidget {
  const OverlayAssetSelection({
    Key? key,
    required this.spareParts,
    required this.toggleSelection,
    required this.onDismiss,
  }) : super(key: key);

  final List<String> spareParts;
  final Function(String) toggleSelection;
  final Function() onDismiss;

  @override
  State<OverlayAssetSelection> createState() => _OverlayAssetSelectionState();
}

class _OverlayAssetSelectionState extends State<OverlayAssetSelection>
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
                  child: BlocBuilder<AssetBloc, AssetState>(
                    builder: (context, state) {
                      if (state is AssetLoadedState) {
                        if (state.allAssets.allAssets.isEmpty) {
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

                        final spareParts = state.allAssets.allAssets
                            .where((asset) => asset.isSparePart)
                            .toList();
                        final filteredAssets = searchAssets(
                          context,
                          // state.allAssets.allAssets,
                          spareParts,
                          _searchQuery,
                        );
                        return ListView.builder(
                          padding: const EdgeInsets.only(top: 2),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredAssets.length,
                          itemBuilder: (context, index) {
                            return AssetTile(
                              key: ValueKey(filteredAssets[index].id),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              asset: filteredAssets[index],
                              searchQuery: _searchQuery,
                              isSelected: widget.spareParts
                                  .contains(filteredAssets[index].id),
                              onSelected: widget.toggleSelection,
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
