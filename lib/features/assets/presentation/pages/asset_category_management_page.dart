import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../utils/show_add_asset_category_modal_bottom_sheet.dart';
import '../blocs/asset_category/asset_category_bloc.dart';
import '../widgets/asset_category_management_bloc_listener.dart';
import '../widgets/asset_category_tile.dart';

class AssetCategoryManagementPage extends StatefulWidget {
  const AssetCategoryManagementPage({Key? key}) : super(key: key);

  static const routeName = '/assets/categories';

  @override
  State<AssetCategoryManagementPage> createState() =>
      _AssetCategoryManagementPageState();
}

class _AssetCategoryManagementPageState
    extends State<AssetCategoryManagementPage> {
  bool _isAdministrator = false;
  late UserProfile _currentUser;

  @override
  void didChangeDependencies() {
    _currentUser =
        (context.read<UserProfileBloc>().state as Approved).userProfile;
    _isAdministrator = _currentUser.administrator;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.item_category_title),
        centerTitle: true,
      ),
      body: AssetCategoryManagementBlocListener(
        child: BlocBuilder<AssetCategoryBloc, AssetCategoryState>(
          builder: (context, state) {
            if (state is AssetCategoryLoadedState) {
              return ListView.builder(
                itemCount:
                    state.allAssetsCategories.allAssetsCategories.length + 1,
                itemBuilder: (context, index) {
                  if (index ==
                      state.allAssetsCategories.allAssetsCategories.length) {
                    return const SizedBox(
                      height: 80,
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: index == 0 ? 4 : 0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: AssetCategoryTile(
                          isAdministrator: _isAdministrator,
                          assetCategory: state
                              .allAssetsCategories.allAssetsCategories[index],
                        ),
                      ),
                    );
                  }
                },
              );
            } else {
              return const LoadingWidget();
            }
          },
        ),
      ),
      floatingActionButton: getUserPremission(
        context: context,
        featureType: FeatureType.assets,
        premissionType: PremissionType.create,
      )
          ? context.watch<AssetCategoryBloc>().state is AssetCategoryLoadedState
              ? FloatingActionButton.extended(
                  heroTag: null,
                  onPressed: () {
                    showAddAssetCategoryModalBottomSheet(context: context);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.grey.shade200,
                  ),
                  label: Text(
                    AppLocalizations.of(context)!.item_category_add_new,
                    style: TextStyle(
                      color: Colors.grey.shade200,
                    ),
                  ),
                )
              // bloc state is not loaded
              : null
          // not an administrator
          : null,
    );
  }
}
