import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/utils/choice.dart';
import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../data/models/asset_model.dart';
import '../../domain/entities/asset.dart';
import '../../utils/asset_management_bloc_listener.dart';
import '../blocs/asset/asset_bloc.dart';
import '../blocs/asset_action/asset_action_bloc.dart';
import '../blocs/asset_management/asset_management_bloc.dart';
import '../widgets/asset_details/asset_documents_tab.dart';
import '../widgets/asset_details/asset_history_tab.dart';
import '../widgets/asset_details/asset_images_tab.dart';
import '../widgets/asset_details/asset_info_tab.dart';
import '../widgets/asset_details/asset_instructions_tab.dart';
import '../widgets/asset_details/assets_spare_parts_tab.dart';
import 'add_asset_page.dart';

class AssetDetailsPage extends StatefulWidget {
  const AssetDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/asset-details';

  @override
  State<AssetDetailsPage> createState() => _AssetDetailsPageState();
}

class _AssetDetailsPageState extends State<AssetDetailsPage>
    with ResponsiveSize {
  Asset? _asset;
  late UserProfile _currentUser;

  List<Choice> _choices = [];

  @override
  void didChangeDependencies() {
    // gets current user
    final currentState = context.read<UserProfileBloc>().state;
    if (currentState is Approved) {
      _currentUser = currentState.userProfile;
    }
    // gets selected asset
    final assetId = (ModalRoute.of(context)?.settings.arguments as String);
    final assetsState = context.watch<AssetBloc>().state;
    if (assetsState is AssetLoadedState) {
      setState(() {
        _asset = assetsState.getAssetById(assetId);
      });
      if (_asset != null) {
        // popup menu items
        _choices = [
          // edit item
          if (getUserPremission(
            context: context,
            featureType: FeatureType.assets,
            premissionType: PremissionType.edit,
          ))
            Choice(
              title: AppLocalizations.of(context)!.edit,
              icon: Icons.edit,
              onTap: () => Navigator.pushNamed(
                context,
                AddAssetPage.routeName,
                arguments: _asset,
              ),
            ),
          // copy asset
          if (getUserPremission(
            context: context,
            featureType: FeatureType.assets,
            premissionType: PremissionType.create,
          ))
            Choice(
              title: AppLocalizations.of(context)!.copy,
              icon: Icons.copy,
              onTap: () => Navigator.pushNamed(
                context,
                AddAssetPage.routeName,
                arguments: AssetModel.fromAsset(_asset!).copyWith(id: ''),
              ),
            ),
        ];
        // gets last actions for selected item
        context.read<AssetActionBloc>().add(
              GetLastFiveAssetActionsEvent(
                asset: AssetModel.fromAsset(_asset!),
                companyId: _currentUser.companyId,
              ),
            );
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = '';
    final Color? tabBarIconColor = Theme.of(context).textTheme.bodyLarge!.color;
    const double tabBarIconSize = 32;

    appBarTitle = AppLocalizations.of(context)!.asset_details;

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          centerTitle: true,
          actions: [
            // popup menu
            if (getUserPremission(
              context: context,
              featureType: FeatureType.assets,
              premissionType: PremissionType.edit,
            ))
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
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.info,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.history,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.image,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.settings_applications_sharp,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.menu_book,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
              Tab(
                icon: Icon(
                  FontAwesomeIcons.filePdf,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
            ],
            indicatorColor: tabBarIconColor,
          ),
        ),
        body: _asset == null
            ? const LoadingWidget()
            : MultiBlocListener(
                listeners: [
                  BlocListener<AssetManagementBloc, AssetManagementState>(
                    listener: (context, state) =>
                        assetManagementBlocListener(context, state),
                  ),
                ],
                child: TabBarView(
                  children: [
                    AssetInfoTab(asset: _asset!),
                    AssetHistoryTab(asset: _asset!),
                    AssetImagesTab(asset: _asset!),
                    AssetsSparePartsTab(asset: _asset!),
                    AssetsInstructionsTab(asset: _asset!),
                    AssetDocumentsTab(asset: _asset!),
                  ],
                ),
              ),
      ),
    );
  }
}
