import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/pages/loading_page.dart';

import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/duration_unit.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../data/models/asset_model.dart';
import '../../domain/entities/asset.dart';
import '../../utils/asset_status.dart';
import '../blocs/asset/asset_bloc.dart';
import '../widgets/add_asset_card.dart';

class AddAssetPage extends StatefulWidget {
  const AddAssetPage({Key? key}) : super(key: key);

  static const routeName = '/assets/add-asset';

  @override
  State<AddAssetPage> createState() => _AddAssetPageState();
}

class _AddAssetPageState extends State<AddAssetPage> {
  Asset? _asset;
  late String _userId;

  // pageview
  List<Widget> _pages = [];
  final _pageController = PageController();

  final _formKey = GlobalKey<FormState>();

  final _producerTextEditingController = TextEditingController();
  final _modelTextEditingController = TextEditingController();
  final _descriptionTextEditingController = TextEditingController();
  final _internalCodeTextEditingController = TextEditingController();
  final _barCodeTextEditingController = TextEditingController();

  String _categoryId = '';
  String _locationId = '';
  String _currentParentId = '';

  bool _isInUse = false;
  bool _isSparePart = false;

  DateTime _lastInspection = DateTime.now();
  AssetStatus _assetStatus = AssetStatus.unknown;
  DurationUnit _durationUnit = DurationUnit.unknown;
  int _duration = 1;

  List<File> _images = [];
  List<File> _documents = [];
  List<String> _spareParts = [];

  _addNewAsset(BuildContext context) {}

  @override
  void initState() {
    _pageController.addListener(() {
      FocusScope.of(context).unfocus();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    final userState = context.watch<UserProfileBloc>().state;
    if (userState is Approved) {
      _userId = userState.userProfile.id;
    }

    if (arguments != null && arguments is AssetModel && _asset == null) {
      _asset = arguments.deepCopy();

      _producerTextEditingController.text = _asset!.producer;
      _modelTextEditingController.text = _asset!.model;
      _descriptionTextEditingController.text = _asset!.description;
      _internalCodeTextEditingController.text = _asset!.internalCode;
      _barCodeTextEditingController.text = _asset!.barCode;

      _categoryId = _asset!.categoryId;
      _locationId = _asset!.locationId;
      _currentParentId = _asset!.currentParentId;
      _isInUse = _asset!.isInUse;
      _isSparePart = _asset!.isSparePart;
      _lastInspection = _asset!.lastInspection;
      _assetStatus = _asset!.currentStatus;
      _durationUnit = _asset!.durationUnit;
      _duration = _asset!.duration;

      _spareParts = _asset!.spareParts;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _producerTextEditingController.dispose();
    _modelTextEditingController.dispose();
    _descriptionTextEditingController.dispose();
    _internalCodeTextEditingController.dispose();
    _barCodeTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      KeepAlivePage(
        child: AddAssetCard(
          isEditMode: _asset != null,
          producerTextEditingController: _producerTextEditingController,
          modelTextEditingController: _modelTextEditingController,
          descriptionTextEditingController: _descriptionTextEditingController,
        ),
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
            message: _asset != null
                ? AppLocalizations.of(context)!.back_to_exit_edit
                : AppLocalizations.of(context)!.back_to_exit_creator,
            isErrorMessage: true,
          );
          return false;
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          return true;
        }
      },
      child: Scaffold(
        body: BlocBuilder<AssetBloc, AssetState>(
          builder: (context, state) {
            if (state is AssetLoadingState) {
              return const LoadingPage();
            } else {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Form(
                    key: _formKey,
                    child: PageView(
                      controller: _pageController,
                      children: _pages,
                    ),
                  ),
                  CreatorBottomNavigation(
                    lastPageForwardButtonFunction: () => _addNewAsset(context),
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
