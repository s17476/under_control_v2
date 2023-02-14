import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/tasks_for_asset/tasks_for_asset_bloc.dart';

import '../../../core/presentation/widgets/home_page/app_bar_animated_icon.dart';
import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/utils/choice.dart';
import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/permission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../tasks/presentation/blocs/tasks_archive_for_asset/tasks_archive_for_asset_bloc.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../data/models/asset_model.dart';
import '../../domain/entities/asset.dart';
import '../../utils/asset_management_bloc_listener.dart';
import '../blocs/asset/asset_bloc.dart';
import '../blocs/asset_action/asset_action_bloc.dart';
import '../blocs/asset_management/asset_management_bloc.dart';
import '../widgets/asset_details/asset_children_tab.dart';
import '../widgets/asset_details/asset_documents_tab.dart';
import '../widgets/asset_details/asset_history_tab.dart';
import '../widgets/asset_details/asset_images_tab.dart';
import '../widgets/asset_details/asset_info_tab.dart';
import '../widgets/asset_details/asset_instructions_tab.dart';
import '../widgets/asset_details/asset_tasks_tab.dart';
import '../widgets/asset_details/assets_spare_parts_tab.dart';
import 'add_asset_page.dart';

class AssetDetailsPage extends StatefulWidget {
  const AssetDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/asset-details';

  @override
  State<AssetDetailsPage> createState() => _AssetDetailsPageState();
}

class _AssetDetailsPageState extends State<AssetDetailsPage>
    with ResponsiveSize, TickerProviderStateMixin {
  Asset? _asset;
  late UserProfile _currentUser;

  List<Choice> _choices = [];
  List<Asset> _children = [];

  int _tabsCount = 2;

  late TabController _tabController;

  List<String> _titles = [];
  String _appBarTitle = '';

  @override
  void initState() {
    _tabController = TabController(length: _tabsCount, vsync: this);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _titles = [
      AppLocalizations.of(context)!.details_asset,
      AppLocalizations.of(context)!.details_tasks,
      AppLocalizations.of(context)!.details_history,
    ];
    _appBarTitle = _titles[_tabController.index];

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
        // fetch tasks for current asset
        context
            .read<TasksForAssetBloc>()
            .add(GetTasksForAssetEvent(assetId: assetId));
        // fetch finished tasks for current asset
        context
            .read<TasksArchiveForAssetBloc>()
            .add(GetTasksArchiveForAssetEvent(assetId: assetId, isAll: false));
        _children = assetsState.allAssets.allAssets
            .where((asset) => asset.currentParentId == _asset!.id)
            .toList();
        // final assetState = context.watch<AssetBloc>().state;
        // if (assetState is AssetLoadedState) {
        // }
        // number of tabs
        _tabsCount = 3;
        if (_children.isNotEmpty) {
          _tabsCount++;
          _titles.add(AppLocalizations.of(context)!.details_subassets);
        }
        if (_asset!.images.isNotEmpty) {
          _tabsCount++;
          _titles.add(AppLocalizations.of(context)!.details_pictures);
        }
        if (_asset!.spareParts.isNotEmpty) {
          _tabsCount++;
          _titles.add(AppLocalizations.of(context)!.details_spare_parts);
        }
        if (_asset!.instructions.isNotEmpty) {
          _tabsCount++;
          _titles.add(AppLocalizations.of(context)!.details_instructions);
        }
        if (_asset!.documents.isNotEmpty) {
          _tabsCount++;
          _titles.add(
            AppLocalizations.of(context)!.details_documents,
          );
        }

        _tabController.dispose();
        _tabController = TabController(length: _tabsCount, vsync: this);
        _tabController.addListener(() {
          setState(() {
            _appBarTitle = _titles[_tabController.index];
          });
        });
        // popup menu items
        _choices = [
          // edit item
          if (getUserPermission(
            context: context,
            featureType: FeatureType.assets,
            permissionType: PermissionType.edit,
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
          if (getUserPermission(
            context: context,
            featureType: FeatureType.assets,
            permissionType: PermissionType.create,
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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color? tabBarIconColor = Theme.of(context).textTheme.bodyLarge!.color;
    const double tabBarIconSize = 32;
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const AppBarAnimatedIcon(isBackIcon: true),
            );
          },
        ),
        actions: [
          // popup menu
          if (getUserPermission(
            context: context,
            featureType: FeatureType.assets,
            permissionType: PermissionType.edit,
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
          controller: _tabController,
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
                Icons.work_history,
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
            if (_children.isNotEmpty)
              Tab(
                icon: Icon(
                  Icons.account_tree,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
            if (_asset!.images.isNotEmpty)
              Tab(
                icon: Icon(
                  Icons.image,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
            if (_asset!.spareParts.isNotEmpty)
              Tab(
                icon: Icon(
                  Icons.settings_applications_sharp,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
            if (_asset!.instructions.isNotEmpty)
              Tab(
                icon: Icon(
                  Icons.menu_book,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
            if (_asset!.documents.isNotEmpty)
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
                controller: _tabController,
                children: [
                  AssetInfoTab(asset: _asset!),
                  AssetTasksTab(asset: _asset!),
                  AssetHistoryTab(asset: _asset!),
                  if (_children.isNotEmpty)
                    AssetChildrenTab(children: _children),
                  if (_asset!.images.isNotEmpty) AssetImagesTab(asset: _asset!),
                  if (_asset!.spareParts.isNotEmpty)
                    AssetsSparePartsTab(asset: _asset!),
                  if (_asset!.instructions.isNotEmpty)
                    AssetsInstructionsTab(asset: _asset!),
                  if (_asset!.documents.isNotEmpty)
                    AssetDocumentsTab(asset: _asset!),
                ],
              ),
            ),
    );
  }
}
