import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/domain/entities/asset.dart';
import '../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../assets/presentation/widgets/asset_tile.dart';
import '../../../assets/utils/asset_status.dart';
import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../pages/all_assets_without_inspection_list_page.dart';

class AssetsWithoutInspection extends StatefulWidget {
  const AssetsWithoutInspection({Key? key}) : super(key: key);

  @override
  State<AssetsWithoutInspection> createState() =>
      _AssetsWithoutInspectionState();
}

class _AssetsWithoutInspectionState extends State<AssetsWithoutInspection> {
  List<Asset>? _assets;

  @override
  void didChangeDependencies() {
    final assetssState = context.watch<AssetBloc>().state;
    if (assetssState is AssetLoadedState) {
      _assets = assetssState.allAssets.allAssets
          .where((asset) => asset.currentStatus == AssetStatus.noInspection)
          .toList();
      if (_assets != null && _assets!.length > 5) {
        _assets = _assets!.sublist(0, 5);
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final premission = getUserPremission(
      context: context,
      featureType: FeatureType.assets,
      premissionType: PremissionType.read,
    );
    if (_assets != null && _assets!.isEmpty) {
      return const SizedBox();
    }
    return !premission
        ? const SizedBox()
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                    // color: Theme.of(context).appBarTheme.backgroundColor,
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade900.withAlpha(150),
                        Colors.blue.withAlpha(30),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 4,
                      )
                    ]),
                child: Row(
                  children: [
                    Expanded(
                      child: IconTitleRow(
                        icon: Icons.precision_manufacturing,
                        iconColor: Colors.white,
                        iconBackground: Colors.blue,
                        title:
                            '${AppLocalizations.of(context)!.bottom_bar_title_assets} - ${AppLocalizations.of(context)!.asset_status_no_inspection}',
                      ),
                    ),
                    if (_assets != null && _assets!.isNotEmpty)
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AllAssetsWithoutInspectionListPage.routeName,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Text(AppLocalizations.of(context)!.show_all),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                    if (_assets == null)
                      const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
              Column(
                children: [
                  // loading assets
                  if (_assets == null)
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) => const ShimmerItemTile(),
                    ),
                  // assets loaded
                  if (_assets != null && _assets!.isNotEmpty)
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _assets!.length,
                      itemBuilder: (context, index) => AssetTile(
                        asset: _assets![index],
                        searchQuery: '',
                      ),
                    ),
                ],
              ),
            ],
          );
  }
}
