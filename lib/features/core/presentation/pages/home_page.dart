import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/presentation/pages/loading_page.dart';

import '../../../assets/presentation/blocs/asset_management/asset_management_bloc.dart';
import '../../../assets/presentation/pages/assets_page.dart';
import '../../../assets/utils/asset_management_bloc_listener.dart';
import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../filter/presentation/widgets/home_page_filter.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../inventory/presentation/blocs/items_management/items_management_bloc.dart';
import '../../../inventory/presentation/pages/inventory_page.dart';
import '../../../inventory/utils/item_management_bloc_listener.dart';
import '../../../knowledge_base/presentation/blocs/instruction_management/instruction_management_bloc.dart';
import '../../../knowledge_base/presentation/pages/knowledge_base_page.dart';
import '../../../knowledge_base/utils/instruction_management_bloc_listener.dart';
import '../../../tasks/presentation/blocs/task_filter/task_filter_bloc.dart';
import '../../../tasks/presentation/blocs/task_management/task_management_bloc.dart';
import '../../../tasks/presentation/blocs/work_request_management/work_request_management_bloc.dart';
import '../../../tasks/presentation/pages/tasks_page.dart';
import '../../../tasks/presentation/widgets/app_bar_tasks_filter/app_bar_tasks_filter.dart';
import '../../../tasks/utils/task_management_bloc_listener.dart';
import '../../../tasks/utils/work_request_management_bloc_listener.dart';
import '../../utils/get_user_permission.dart';
import '../../utils/permission.dart';
import '../../utils/show_snack_bar.dart';
import '../../utils/size_config.dart';
import '../widgets/home_page/app_bar_search_box.dart';
import '../widgets/home_page/home_bottom_navigation_bar.dart';
import '../widgets/home_page/home_sliver_app_bar.dart';
import '../widgets/home_page/main_drawer.dart';
import '../widgets/keep_alive_page.dart';
import '../widgets/overlay_menu/overlay_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // search box height
  final double _searchBoxHeight = 70;

  final _scrollController = ScrollController();

  // bottom navigation controls
  final _pageController = PageController(
    initialPage: 2,
    keepPage: true,
  );
  int _pageIndex = 2;
  late CircularBottomNavigationController _navigationController;

  bool _isFilterExpanded = false;
  bool _isInventorySearchBarExpanded = false;
  bool _isAssetsSearchBarExpanded = false;
  bool _isInstructionsSearchBarExpanded = false;
  bool _isControlsVisible = true;
  bool _isMenuVisible = false;
  bool _isBottomNavigationAnimating = false;
  bool _isTaskFilterVisible = false;

  // inventory search
  final _inventorySearchTextEditingController = TextEditingController();
  String _inventorySearchQuery = '';

  // assets search
  final _assetsSearchTextEditingController = TextEditingController();
  String _assetsSearchQuery = '';

  // instructions search
  final _instructionsSearchTextEditingController = TextEditingController();
  String _instructionsSearchQuery = '';

  // scroll controller current offset
  double _currentScrollOffset = 0;

  // search

  // bottom navigation show/hide animation
  AnimationController? _animationController;

  // search in inventory
  void _searchInInventory() {
    setState(() {
      _inventorySearchQuery = _inventorySearchTextEditingController.text;
    });
  }

  // search in assets
  void _searchInAssets() {
    setState(() {
      _assetsSearchQuery = _assetsSearchTextEditingController.text;
    });
  }

  // search in assets
  void _searchInInstructions() {
    setState(() {
      _instructionsSearchQuery = _instructionsSearchTextEditingController.text;
    });
  }

  // set page index
  void _setPageIndex(int index) async {
    setState(() {
      _pageIndex = index;
    });
    _isBottomNavigationAnimating = true;
    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
    _isBottomNavigationAnimating = false;
  }

  // show BottomNavigationTabBar
  void _showControls() {
    if (!_isControlsVisible) {
      _animationController!.reverse();
      setState(() {
        _isControlsVisible = true;
      });
    }
  }

  // hide BottomNavigationTabBar
  void _hideControls() {
    if (_isControlsVisible) {
      _animationController!.forward();
      setState(() {
        _isControlsVisible = false;
      });
      context.read<TaskFilterBloc>().add(TaskFilterSetMiniSizeEvent());
    }
  }

  // show/hide filter widget
  void _toggleIsFilterExpanded() {
    setState(() {
      _isFilterExpanded = !_isFilterExpanded;
    });
    context.read<TaskFilterBloc>().add(TaskFilterHideEvent());
  }

  // show/hide search bar widget
  void _toggleIsSearchBarExpanded() {
    setState(() {
      // closes menu and filter
      if (_isMenuVisible) {
        _toggleIsMenuVisible();
      }
      if (_isTaskFilterVisible) {
        context.read<TaskFilterBloc>().add(TaskFilterHideEvent());
      }
      if (_isFilterExpanded) {
        _toggleIsFilterExpanded();
      }

      // toggle inventory search
      if (_isInventorySearchBarExpanded) {
        _inventorySearchTextEditingController.text = '';
        _searchInInventory();
        _isInventorySearchBarExpanded = false;
      } else if (!_isInventorySearchBarExpanded && _pageIndex == 1) {
        _isInventorySearchBarExpanded = true;
      }

      // toggle assets search
      if (_isAssetsSearchBarExpanded) {
        _assetsSearchTextEditingController.text = '';
        _searchInAssets();
        _isAssetsSearchBarExpanded = false;
      } else if (!_isAssetsSearchBarExpanded && _pageIndex == 3) {
        _isAssetsSearchBarExpanded = true;
      }

      // toggle instructions search
      if (_isInstructionsSearchBarExpanded) {
        _instructionsSearchTextEditingController.text = '';
        _searchInInstructions();
        _isInstructionsSearchBarExpanded = false;
      } else if (!_isInstructionsSearchBarExpanded && _pageIndex == 4) {
        _isInstructionsSearchBarExpanded = true;
      }
    });
  }

  bool _getFlagForPageIndex(int index) {
    if (_pageIndex == 1) {
      return _isInventorySearchBarExpanded;
    } else if (_pageIndex == 3) {
      return _isAssetsSearchBarExpanded;
    } else {
      return _isInstructionsSearchBarExpanded;
    }
  }

  // show overlay menu
  void _toggleIsMenuVisible() {
    // hides filter widget if expanded
    if (_isFilterExpanded) {
      _toggleIsFilterExpanded();
    }
    // hides tasks filter if visible
    if (_isTaskFilterVisible) {
      context.read<TaskFilterBloc>().add(TaskFilterHideEvent());
    }
    // hides search box if visible
    if (_isAssetsSearchBarExpanded ||
        _isInstructionsSearchBarExpanded ||
        _isInventorySearchBarExpanded) {
      _toggleIsSearchBarExpanded();
    }
    bool premision = true;
    // no inventory read permission
    if (_pageIndex == 0 &&
        !getUserPermission(
          context: context,
          featureType: FeatureType.tasks,
          permissionType: PermissionType.read,
        )) {
      premision = false;
    } else if (_pageIndex == 1 &&
        !getUserPermission(
          context: context,
          featureType: FeatureType.inventory,
          permissionType: PermissionType.read,
        )) {
      premision = false;
    } else if (_pageIndex == 3 &&
        !getUserPermission(
          context: context,
          featureType: FeatureType.assets,
          permissionType: PermissionType.read,
        )) {
      premision = false;
    } else if (_pageIndex == 4 &&
        !getUserPermission(
          context: context,
          featureType: FeatureType.knowledgeBase,
          permissionType: PermissionType.read,
        )) {
      premision = false;
    }
    if (premision) {
      setState(() {
        _isMenuVisible = !_isMenuVisible;
      });
    } else {
      showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.permission_no_permission,
        isErrorMessage: true,
      );
    }
  }

  @override
  void initState() {
    // bottom bar navigation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // bottom navigation
    _navigationController = CircularBottomNavigationController(_pageIndex);
    _pageController.addListener(() {
      if (_pageController.page! - _pageIndex > 0.5 ||
          _pageController.page! - _pageIndex < -0.5) {
        // TODO - scroll up on page change
        // _scrollController.animateTo(
        //   0,
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeInOut,
        // );
      }
    });

    // triggers hide/show bottom navigation bar
    _scrollController.addListener(() {
      if (_isTaskFilterVisible && _scrollController.offset < 5) {
        context.read<TaskFilterBloc>().add(TaskFilterSetFullSizeEvent());
      }
      if (_isControlsVisible &&
          _scrollController.offset > _currentScrollOffset) {
        _hideControls();
      }
      if (MediaQuery.of(context).viewInsets.bottom == 0 &&
          !_isControlsVisible &&
          _scrollController.offset < _currentScrollOffset) {
        _showControls();
      }
      _currentScrollOffset = _scrollController.offset;
    });

    // closes search bar when page changes
    _pageController.addListener(() {
      if (_isInventorySearchBarExpanded ||
          _isAssetsSearchBarExpanded ||
          _isInstructionsSearchBarExpanded) {
        _toggleIsSearchBarExpanded();
      }
      if (_isTaskFilterVisible) {
        context.read<TaskFilterBloc>().add(TaskFilterHideEvent());
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final taskFilterState = context.watch<TaskFilterBloc>().state;
    if (taskFilterState is TaskFilterSelectedState ||
        taskFilterState is TaskFilterNothingSelectedState) {
      _isTaskFilterVisible = taskFilterState.isFilterVisible;
    }
    if (MediaQuery.of(context).viewInsets.bottom == 0 && !_isControlsVisible) {
      _showControls();
    } else if (MediaQuery.of(context).viewInsets.bottom != 0 &&
        _isControlsVisible) {
      _hideControls();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _navigationController.dispose();
    _scrollController.dispose();
    _animationController?.dispose();
    _pageController.dispose();
    _inventorySearchTextEditingController.dispose();
    _assetsSearchTextEditingController.dispose();
    _instructionsSearchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    DateTime preBackpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        // hides filter widget if expanded
        if (_isFilterExpanded) {
          _toggleIsFilterExpanded();
          return false;
        }
        // hides menu drawer if visible
        if (_isMenuVisible) {
          _toggleIsMenuVisible();
          return false;
        }
        // hides tasks filter if visible
        if (_isTaskFilterVisible) {
          context.read<TaskFilterBloc>().add(TaskFilterHideEvent());
          return false;
        }
        // hides search box if visible
        if (_isAssetsSearchBarExpanded ||
            _isInstructionsSearchBarExpanded ||
            _isInventorySearchBarExpanded) {
          _toggleIsSearchBarExpanded();
          return false;
        }
        // double click to exit the app
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          // shows snack bar after first click
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  AppLocalizations.of(context)!.back_to_exit,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.black,
              ),
            );
          return false;
        } else {
          return true;
        }
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<ItemsManagementBloc, ItemsManagementState>(
            listener: (context, state) =>
                itemManagementBlocListener(context, state),
          ),
          BlocListener<InstructionManagementBloc, InstructionManagementState>(
            listener: (context, state) =>
                instructionManagementBlocListener(context, state),
          ),
          BlocListener<AssetManagementBloc, AssetManagementState>(
            listener: (context, state) =>
                assetManagementBlocListener(context, state),
          ),
          BlocListener<WorkRequestManagementBloc, WorkRequestManagementState>(
            listener: (context, state) =>
                workRequestManagementBlocListener(context, state),
          ),
          BlocListener<TaskManagementBloc, TaskManagementState>(
            listener: (context, state) =>
                taskManagementBlocListener(context, state),
          ),
          BlocListener<TaskFilterBloc, TaskFilterState>(
              listener: (context, state) {
            if ((state is TaskFilterSelectedState ||
                    state is TaskFilterNothingSelectedState) &&
                state.isFilterVisible &&
                _isFilterExpanded) {
              setState(() {
                _isFilterExpanded = false;
              });
            }
          }),
        ],
        child: Scaffold(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,

          drawer: const MainDrawer(),
          // safe area
          body: SafeArea(
            bottom: _isControlsVisible,
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/scaffold_background.png'),
                  fit: BoxFit.cover,
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: NestedScrollView(
                controller: _scrollController,
                // physics: const NeverScrollableScrollPhysics(),
                // AppBar
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: HomeSliverAppBar(
                      pageIndex: _pageIndex,
                      isFilterExpanded: _isFilterExpanded,
                      toggleIsFilterExpanded: _toggleIsFilterExpanded,
                      isMenuVisible: _isMenuVisible,
                      toggleIsMenuVisible: _toggleIsMenuVisible,
                      isSearchBarExpanded: _getFlagForPageIndex(_pageIndex),
                      toggleIsSearchBarExpanded: _toggleIsSearchBarExpanded,
                      isTaskFilterVisible: _isTaskFilterVisible,
                    ),
                  )
                ],
                // body
                body: Stack(
                  children: [
                    BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, state) {
                        if (state is FilterLoadedState) {
                          return Stack(
                            children: [
                              // locations not selected
                              if (state is FilterLoadedState &&
                                  state.locations.isEmpty)
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                        top: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .home_screen_filter_select_locations,
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.arrow_upward,
                                            size: 50,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Expanded(
                                      child: Center(
                                        child: Icon(
                                          Icons.location_off,
                                          size: 100,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 36,
                                    ),
                                  ],
                                ),
                              // tabs
                              // if (state is FilterLoadedState &&
                              //     state.locations.isNotEmpty)
                              PageView(
                                controller: _pageController,
                                onPageChanged: (index) {
                                  if (!_isBottomNavigationAnimating) {
                                    setState(() {
                                      _pageIndex = index;
                                    });
                                    _navigationController.value = index;
                                  }
                                },
                                children: [
                                  const KeepAlivePage(
                                    child: TasksPage(),
                                  ),
                                  KeepAlivePage(
                                    child: InventoryPage(
                                      searchBoxHeight: _searchBoxHeight,
                                      isSearchBoxExpanded:
                                          _isInventorySearchBarExpanded,
                                      searchQuery: _inventorySearchQuery,
                                      isSortedByCategory: false,
                                    ),
                                  ),
                                  const DashboardPage(),
                                  AssetsPage(
                                    searchBoxHeight: _searchBoxHeight,
                                    isSearchBoxExpanded:
                                        _isAssetsSearchBarExpanded,
                                    searchQuery: _assetsSearchQuery,
                                  ),
                                  KeepAlivePage(
                                    child: KnowledgeBasePage(
                                      searchBoxHeight: _searchBoxHeight,
                                      isSearchBoxExpanded:
                                          _isInstructionsSearchBarExpanded,
                                      searchQuery: _instructionsSearchQuery,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.grey.shade700,
                            Colors.grey.shade700.withOpacity(0.1),
                            Colors.transparent,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    // bottom navigation bar
                    HomeBottomNavigationBar(
                      animationController: _animationController!,
                      navigationController: _navigationController,
                      // pageController: _pageController,
                      setPageIndex: _setPageIndex,
                      toggleShowMenu: _toggleIsMenuVisible,
                    ),
                    // location and group selection filter
                    HomePageFilter(
                      isFilterExpanded: _isFilterExpanded,
                      onDismiss: _toggleIsFilterExpanded,
                    ),
                    OverlayMenu(
                      isVisible: _isMenuVisible,
                      onDismiss: _toggleIsMenuVisible,
                      pageIndex: _pageIndex,
                    ),
                    // inventory search box
                    AppBarSearchBox(
                      title: AppLocalizations.of(context)!.search_item,
                      searchBoxHeight: _searchBoxHeight,
                      isSearchBoxExpanded: _isInventorySearchBarExpanded,
                      onChanged: _searchInInventory,
                      searchTextEditingController:
                          _inventorySearchTextEditingController,
                    ),
                    // assets search box
                    AppBarSearchBox(
                      title: AppLocalizations.of(context)!.search,
                      searchBoxHeight: _searchBoxHeight,
                      isSearchBoxExpanded: _isAssetsSearchBarExpanded,
                      onChanged: _searchInAssets,
                      searchTextEditingController:
                          _assetsSearchTextEditingController,
                    ),
                    // instructions search box
                    AppBarSearchBox(
                      title: AppLocalizations.of(context)!.search,
                      searchBoxHeight: _searchBoxHeight,
                      isSearchBoxExpanded: _isInstructionsSearchBarExpanded,
                      onChanged: _searchInInstructions,
                      searchTextEditingController:
                          _instructionsSearchTextEditingController,
                    ),
                    // tasks filter
                    AppBarTasksFilter(
                      isTaskFilterVisible: _isTaskFilterVisible,
                    ),
                    // loading widget
                    BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
                      builder: (context, state) {
                        if (state is CompanyProfileLoaded) {
                          return const SizedBox();
                        }
                        return const LoadingPage();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
