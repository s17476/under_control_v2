import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../assets/data/models/asset_model.dart';
import '../../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../../assets/presentation/blocs/asset_parts/asset_parts_bloc.dart';
import '../../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../../core/presentation/pages/qr_scanner.dart';
import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/glass_layer.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import 'add_task_action_remove_asset_card.dart';

class AddTaskActionRemoveAssetOverlay extends StatefulWidget {
  const AddTaskActionRemoveAssetOverlay({
    Key? key,
    required this.onDismiss,
    required this.replaceConnectedAssets,
    required this.toggleRemovedAssets,
    required this.assetsToRemove,
    required this.connectedAssetId,
    this.replacedAsset,
  }) : super(key: key);

  final Function() onDismiss;
  final Function(AssetModel) replaceConnectedAssets;
  final Function(AssetModel) toggleRemovedAssets;
  final List<AssetModel> assetsToRemove;
  final String connectedAssetId;
  final AssetModel? replacedAsset;

  @override
  State<AddTaskActionRemoveAssetOverlay> createState() =>
      _AddTaskActionRemoveAssetOverlayState();
}

class _AddTaskActionRemoveAssetOverlayState
    extends State<AddTaskActionRemoveAssetOverlay> with ResponsiveSize {
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
                  const SizedBox(
                    width: 16,
                  ),
                  IconButton(
                    onPressed: widget.onDismiss,
                    icon: const Icon(Icons.done),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)!.task_connected_asset,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 18),
                        ),
                      ),
                      BlocBuilder<AssetBloc, AssetState>(
                        builder: (context, state) {
                          if (state is AssetLoadedState) {
                            final asset =
                                state.getAssetById(widget.connectedAssetId);

                            return AssetToRemoveTile(
                              asset: AssetModel.fromAsset(asset!),
                              toggleRemovedAssets:
                                  widget.replaceConnectedAssets,
                              isRemoved: widget.replacedAsset != null,
                            );
                          } else {
                            return const ShimmerItemTile();
                          }
                        },
                      ),
                      BlocBuilder<AssetPartsBloc, AssetPartsState>(
                        builder: (context, state) {
                          if (state is AssetPartsLoadedState) {
                            return Column(
                              children: [
                                if (state.allAssetParts.allAssets.isNotEmpty)
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .asset_spare_parts,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(fontSize: 18),
                                    ),
                                  ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      state.allAssetParts.allAssets.length,
                                  itemBuilder: (context, index) {
                                    final asset =
                                        state.allAssetParts.allAssets[index];
                                    return AssetToRemoveTile(
                                      asset: AssetModel.fromAsset(asset),
                                      toggleRemovedAssets:
                                          widget.toggleRemovedAssets,
                                      isRemoved: widget.assetsToRemove
                                          .map((e) => e.id)
                                          .contains(asset.id),
                                    );
                                  },
                                ),
                              ],
                            );
                          } else {
                            return ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) =>
                                  const ShimmerAssetActionListTile(),
                            );
                          }
                        },
                      ),
                    ],
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
