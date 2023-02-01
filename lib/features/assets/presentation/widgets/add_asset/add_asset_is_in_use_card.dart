import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/pages/qr_scanner.dart';
import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/presentation/widgets/selection_button.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../../utils/search_assets.dart';
import '../../blocs/asset/asset_bloc.dart';
import '../asset_tile.dart';

class AddAssetIsInUseCard extends StatefulWidget {
  const AddAssetIsInUseCard({
    Key? key,
    required this.setIsInUse,
    required this.isInUse,
    required this.setParentAsset,
    required this.isSparePart,
    required this.setLocation,
    required this.currentParentId,
  }) : super(key: key);

  final Function(bool) setIsInUse;
  final bool isInUse;
  final Function(String) setParentAsset;
  final bool isSparePart;
  final Function(String) setLocation;
  final String currentParentId;

  @override
  State<AddAssetIsInUseCard> createState() => _AddAssetIsInUseCardState();
}

class _AddAssetIsInUseCardState extends State<AddAssetIsInUseCard>
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
      child: Column(
        children: [
          Expanded(
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
                    AppLocalizations.of(context)!.asset_is_in_use,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.headlineSmall!.fontSize,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // not a spare part
                        SelectionButton<bool>(
                          onSelected: widget.setIsInUse,
                          icon: Icons.play_circle,
                          iconSize:
                              (widget.isInUse && widget.isSparePart) ? 30 : 50,
                          title: AppLocalizations.of(context)!.asset_in_use,
                          titleSize: 18,
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor.withAlpha(100),
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withAlpha(80),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          value: true,
                          groupValue: widget.isInUse,
                        ),
                        SizedBox(
                          height:
                              (widget.isInUse && widget.isSparePart) ? 8 : 16,
                        ),
                        // spare part
                        SelectionButton<bool>(
                          onSelected: (val) {
                            widget.setIsInUse(val);
                            widget.setParentAsset('');
                          },
                          icon: Icons.pause_circle,
                          iconSize:
                              (widget.isInUse && widget.isSparePart) ? 30 : 50,
                          title: AppLocalizations.of(context)!.asset_not_in_use,
                          titleSize: 18,
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange.withAlpha(150),
                              Colors.orange,
                              Colors.orange.withAlpha(80),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          value: false,
                          groupValue: widget.isInUse,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (widget.isInUse && widget.isSparePart)
                          Text(
                            AppLocalizations.of(context)!.asset_parent_select,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        const SizedBox(
                          height: 8,
                        ),
                        // search box
                        if (widget.isInUse && widget.isSparePart)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      fieldKey: 'search',
                                      controller: _searchTextEditingController,
                                      keyboardType: TextInputType.name,
                                      labelText:
                                          AppLocalizations.of(context)!.search,
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
                                      Theme.of(context)
                                          .primaryColor
                                          .withAlpha(60),
                                    ]),
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        if (widget.isInUse && widget.isSparePart)
                          Expanded(
                            child: BlocBuilder<AssetBloc, AssetState>(
                              builder: (context, state) {
                                if (state is AssetLoadedState) {
                                  if (state.allAssets.allAssets.isEmpty) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          height: responsiveSizeVerticalPct(
                                              small: 40),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .item_no_items,
                                        ),
                                      ],
                                    );
                                  }

                                  final filteredAssets = searchAssets(
                                    context,
                                    state.allAssets.allAssets,
                                    _searchQuery,
                                  );
                                  return ListView.builder(
                                    padding: const EdgeInsets.only(
                                      top: 2,
                                      bottom: 50,
                                    ),
                                    itemCount: filteredAssets.length,
                                    itemBuilder: (context, index) {
                                      return AssetTile(
                                        key: ValueKey(
                                          filteredAssets[index].id,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        asset: filteredAssets[index],
                                        searchQuery: _searchQuery,
                                        groupValue: widget.currentParentId,
                                        onRadioSelected: (val) {
                                          widget.setParentAsset(val);
                                          widget.setLocation(
                                              filteredAssets[index].locationId);
                                        },
                                      );
                                    },
                                  );
                                } else {
                                  // loading shimmer animation
                                  return ListView.builder(
                                    padding: const EdgeInsets.only(top: 2),
                                    itemCount: 6,
                                    itemBuilder: (context, index) {
                                      return const ShimmerItemTile();
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
