import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/groups/domain/entities/feature.dart';

import '../../../assets/data/models/asset_model.dart';
import '../../../assets/domain/entities/asset.dart';
import '../../../assets/presentation/widgets/add_asset/add_asset_location_card.dart';
import '../../../assets/utils/asset_status.dart';
import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../blocs/task/task_bloc.dart';
import '../widgets/add_work_request/set_asset_status_card.dart';

class SelectNewAssetDataPage extends StatefulWidget {
  const SelectNewAssetDataPage({Key? key}) : super(key: key);

  static const routeName = '/tasks-action/select-new-data';

  @override
  State<SelectNewAssetDataPage> createState() => _SelectNewAssetDataPageState();
}

class _SelectNewAssetDataPageState extends State<SelectNewAssetDataPage> {
  AssetModel? _asset;

  // pageview
  List<Widget> _pages = [];
  final _pageController = PageController();

  String _locationId = '';
  String _assetStatus = '';

  _selectNewData(BuildContext context) {
    String errorMessage = '';
    // location validation
    if (_locationId.isEmpty) {
      errorMessage =
          AppLocalizations.of(context)!.validation_location_not_selected;
    }
    // asset status validation
    if (errorMessage.isEmpty && _assetStatus.isEmpty) {
      errorMessage = AppLocalizations.of(context)!.asset_status_not_selected;
    }

    // // shows SnackBar if validation error occures
    if (errorMessage.isNotEmpty) {
      showSnackBar(
        context: context,
        message: errorMessage,
        isErrorMessage: true,
      );
      // saves instruction to DB if no error
    } else {
      final updatedAsset = _asset!.copyWith(
        locationId: _locationId,
        currentStatus: AssetStatus.fromString(_assetStatus),
      );

      Navigator.pop(context, updatedAsset);
    }
  }

  void _setAssetStatus(String value) {
    setState(() {
      _assetStatus = value;
    });
  }

  void _setLocation(String location) async {
    setState(() {
      _locationId = location;
    });
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    // conversion from Work Request
    if (arguments != null && arguments is Asset && _asset == null) {
      _asset = AssetModel.fromAsset(arguments).deepCopy();

      _locationId = _asset!.locationId;
      _assetStatus = _asset!.currentStatus.name;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      KeepAlivePage(
        child: AddAssetLocationCard(
          selectedLocation: _locationId,
          setLocation: _setLocation,
          featureType: FeatureType.tasks,
        ),
      ),
      SetAssetStatusCard(
        setStatus: _setAssetStatus,
        assetStatus: _assetStatus,
      ),
    ];

    DateTime preBackpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        // double click to exit the app
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          showSnackBar(
            context: context,
            message: AppLocalizations.of(context)!.back_to_exit_creator,
            isErrorMessage: true,
            showExitButton: true,
          );
          return false;
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          return true;
        }
      },
      child: Scaffold(
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoadingState) {
              return const LoadingPage();
            } else {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView(
                    controller: _pageController,
                    children: _pages,
                  ),
                  CreatorBottomNavigation(
                    lastPageForwardButtonFunction: () =>
                        _selectNewData(context),
                    lastPageForwardButtonLabel:
                        AppLocalizations.of(context)!.remove,
                    pages: _pages,
                    pageController: _pageController,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
