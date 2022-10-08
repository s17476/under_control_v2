import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/location_selection_helpers.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../locations/domain/entities/location.dart';
import '../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../data/models/feature_model.dart';
import '../../data/models/group_model.dart';
import '../../domain/entities/feature.dart';
import '../../domain/entities/group.dart';
import '../blocs/group/group_bloc.dart';
import '../widgets/add_group/add_group_features_card.dart';
import '../widgets/add_group/add_group_locations_card.dart';
import '../widgets/add_group/add_group_name_card.dart';
import '../widgets/add_group/add_group_summary_card.dart';

class AddGroupPage extends StatefulWidget {
  const AddGroupPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/groups/add-group';

  @override
  State<AddGroupPage> createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  Group? group;

  final _formKey = GlobalKey<FormState>();

  final _pageController = PageController();

  final _nameTexEditingController = TextEditingController();
  final _descriptionTexEditingController = TextEditingController();

  List<Widget> _pages = [];
  List<Location> _selectedLocations = [];
  List<String> _locationsChildren = [];
  List<String> _locationsContext = [];
  List<String> _totalSelectedLocations = [];
  List<FeatureModel> _features = [];

  // select / unselect location
  void _toggleLocationSelection(
    BuildContext context,
    Location location,
    bool isSelected,
  ) {
    // gets all locations
    final allLocations =
        (context.read<LocationBloc>().state as LocationLoadedState)
            .allLocations
            .allLocations;
    // gets selected location children
    // if is selected
    if (!isSelected) {
      List<String> tmpChildren = getSelectedLocationsChildrenId(
        location,
        allLocations,
      );
      List<Location> tmpLocations = [..._selectedLocations];

      // finds parent location
      if (location.parentId.isNotEmpty) {
        if (_locationsChildren.contains(location.parentId) ||
            _selectedLocations
                .where((element) => element.id == location.parentId)
                .toList()
                .isNotEmpty) {
          tmpChildren.add(location.id);
          tmpChildren.addAll(_locationsChildren);
        } else {
          tmpLocations.add(location);
          tmpChildren.addAll(_locationsChildren);
        }
        // top level location
      } else {
        // remove all children from selected locations
        for (var loc in tmpChildren) {
          final location = allLocations.firstWhere(
            (element) => element.id == loc,
          );
          tmpLocations.remove(location);
        }
        // add selected location to selected locations list
        tmpLocations.add(location);
        // add selected location children to state children list
        tmpChildren.addAll(_locationsChildren);
      }
      // remove duplicates
      tmpChildren = tmpChildren.toSet().toList();
      tmpLocations = tmpLocations.toSet().toList();
      // update selected locations
      List<Location> updatedLocations = [];
      for (var location in tmpLocations) {
        if (!tmpChildren.contains(location.id)) {
          updatedLocations.add(location);
        }
      }
      // update locations context
      final updatedContext = getselectedLocationsContext(
          updatedLocations, tmpChildren, allLocations);

      setState(() {
        _locationsChildren = tmpChildren;
        _selectedLocations = updatedLocations;
        _locationsContext = updatedContext;
      });

      // if is unselected
    } else {
      // updates children
      List<String> tmpChildren = getSelectedLocationsChildrenId(
        location,
        allLocations,
      );
      tmpChildren.add(location.id);
      final List<String> updatedChildren = [];
      for (var child in _locationsChildren) {
        if (!tmpChildren.contains(child)) {
          updatedChildren.add(child);
        }
      }

      // updates selected locations
      List<Location> tmpLocations = _selectedLocations;
      tmpLocations.remove(location);
      final updatedContext = getselectedLocationsContext(
        tmpLocations,
        updatedChildren,
        allLocations,
      );

      setState(() {
        _locationsChildren = updatedChildren;
        _selectedLocations = tmpLocations;
        _locationsContext = updatedContext;
      });
    }
    setState(() {
      _totalSelectedLocations = [..._locationsChildren];
      _totalSelectedLocations.addAll(
        _selectedLocations.map((e) => e.id).toList(),
      );
    });
  }

  // add new group
  void _addNewGroup(BuildContext context) {
    String errorMessage = '';
    // group name validation
    if (!_formKey.currentState!.validate()) {
      errorMessage = AppLocalizations.of(context)!
          .group_management_add_error_name_to_short;
    } else {
      // locations selection validation
      if (_selectedLocations.isEmpty) {
        errorMessage = AppLocalizations.of(context)!
            .group_management_add_error_no_location_selected;
      } else {
        // premissions validation
        bool isAtLeastOneFeatureSelected = false;
        for (var feature in _features) {
          if (feature.create ||
              feature.delete ||
              feature.edit ||
              feature.read) {
            isAtLeastOneFeatureSelected = true;
          }
        }
        if (!isAtLeastOneFeatureSelected) {
          errorMessage = AppLocalizations.of(context)!
              .group_management_add_error_no_premission_selected;
          // group name validation
        } else if (group == null) {
          final currentState = context.read<GroupBloc>().state;
          if (currentState is GroupLoadedState) {
            final tmpGroups = currentState.allGroups.allGroups.where(
                (group) => group.name == _nameTexEditingController.text.trim());
            if (tmpGroups.isNotEmpty) {
              errorMessage = AppLocalizations.of(context)!
                  .group_management_add_error_name_exists;
            }
          }
        }
      }
    }

    // shows SnackBar if validation error occures
    if (errorMessage.isNotEmpty) {
      showSnackBar(
        context: context,
        message: errorMessage,
        isErrorMessage: true,
      );
      // saves group to DB if no error
    } else {
      final newGroup = GroupModel(
        id: (group != null) ? group!.id : '',
        name: _nameTexEditingController.text,
        description: _descriptionTexEditingController.text,
        groupAdministrators: const [],
        locations: _totalSelectedLocations,
        features: _features,
      );

      if (group != null) {
        context.read<GroupBloc>().add(UpdateGroupEvent(group: newGroup));
      } else {
        context.read<GroupBloc>().add(
              AddGroupEvent(group: newGroup),
            );
      }

      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    _features = [
      FeatureModel(
        type: FeatureType.tasks,
        create: false,
        read: false,
        edit: false,
        delete: false,
      ),
      FeatureModel(
        type: FeatureType.inventory,
        create: false,
        read: false,
        edit: false,
        delete: false,
      ),
      FeatureModel(
        type: FeatureType.assets,
        create: false,
        read: false,
        edit: false,
        delete: false,
      ),
      FeatureModel(
        type: FeatureType.knowledgeBase,
        create: false,
        read: false,
        edit: false,
        delete: false,
      ),
    ];

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments != null && arguments is GroupModel) {
      group = arguments.deepCopy();

      _nameTexEditingController.text = group!.name;
      _descriptionTexEditingController.text = group!.description;

      List<Location> tmpSelecedlocations = [];
      final allLocations =
          (context.read<LocationBloc>().state as LocationLoadedState)
              .allLocations
              .allLocations;
      for (var groupId in group!.locations) {
        final tmp =
            allLocations.where((element) => element.id == groupId).toList();
        if (tmp.isNotEmpty) {
          tmpSelecedlocations.addAll(tmp);
        }
      }
      _selectedLocations = tmpSelecedlocations;
      _totalSelectedLocations = group!.locations;
      _locationsContext =
          getselectedLocationsContext(_selectedLocations, [], allLocations);
      _features = group!.features;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameTexEditingController.dispose();
    _descriptionTexEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      KeepAlivePage(
        child: AddGroupNameCard(
          isEditMode: group != null,
          pageController: _pageController,
          nameTexEditingController: _nameTexEditingController,
          descriptionTexEditingController: _descriptionTexEditingController,
        ),
      ),
      KeepAlivePage(
        child: AddGroupLocationsCard(
          locationsChildren: _locationsChildren,
          locationsContext: _locationsContext,
          selectedLocations: _selectedLocations,
          toggleLocationSelection: _toggleLocationSelection,
        ),
      ),
      AddGroupFeaturesCard(
        pageController: _pageController,
        features: _features,
      ),
      AddGroupSummaryCard(
        pageController: _pageController,
        addNewGroup: _addNewGroup,
        nameTexEditingController: _nameTexEditingController,
        descriptionTexEditingController: _descriptionTexEditingController,
        totalSelectedLocations: _totalSelectedLocations,
        features: _features,
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
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(
                AppLocalizations.of(context)!.back_to_exit_creator,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: Theme.of(context).errorColor,
            ));
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(body: BlocBuilder<GroupBloc, GroupState>(
        builder: (context, state) {
          if (state is GroupLoadingState) {
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: JumpingDotEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      jumpScale: 2,
                      activeDotColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      )),
    );
  }
}
