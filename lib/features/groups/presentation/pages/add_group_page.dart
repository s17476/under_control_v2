import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/location_selection_helpers.dart';
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

  List<Widget> pages = [];

  final _formKey = GlobalKey<FormState>();

  final pageController = PageController();

  final nameTexEditingController = TextEditingController();
  final descriptionTexEditingController = TextEditingController();

  List<Location> selectedLocations = [];
  List<String> locationsChildren = [];
  List<String> locationsContext = [];

  List<String> totalSelectedLocations = [];

  List<FeatureModel> features = [];

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments != null && arguments is Group) {
      group = arguments;
      nameTexEditingController.text = group!.name;
      descriptionTexEditingController.text = group!.description;

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
      selectedLocations = tmpSelecedlocations;
      totalSelectedLocations = group!.locations;
      locationsContext =
          getselectedLocationsContext(selectedLocations, [], allLocations);
      features = group!.features;
    }
    super.didChangeDependencies();
  }

  // select / unselect location
  void toggleLocationSelection(
      BuildContext context, Location location, bool isSelected) {
    // gets all locations
    final allLocations =
        (context.read<LocationBloc>().state as LocationLoadedState)
            .allLocations
            .allLocations;
    // gets selected location children
    // if is selected
    if (!isSelected) {
      List<String> tmpChildren = getSelectedLocationChildren(
        location,
        allLocations,
      );
      List<Location> tmpLocations = [...selectedLocations];

      // finds parent location
      if (location.parentId.isNotEmpty) {
        if (locationsChildren.contains(location.parentId) ||
            selectedLocations
                .where((element) => element.id == location.parentId)
                .toList()
                .isNotEmpty) {
          tmpChildren.add(location.id);
          tmpChildren.addAll(locationsChildren);
        } else {
          tmpLocations.add(location);
          tmpChildren.addAll(locationsChildren);
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
        tmpChildren.addAll(locationsChildren);
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
        locationsChildren = tmpChildren;
        selectedLocations = updatedLocations;
        locationsContext = updatedContext;
      });

      // if is unselected
    } else {
      // updates children
      List<String> tmpChildren = getSelectedLocationChildren(
        location,
        allLocations,
      );
      tmpChildren.add(location.id);
      final List<String> updatedChildren = [];
      for (var child in locationsChildren) {
        if (!tmpChildren.contains(child)) {
          updatedChildren.add(child);
        }
      }

      // updates selected locations
      List<Location> tmpLocations = selectedLocations;
      tmpLocations.remove(location);
      final updatedContext = getselectedLocationsContext(
        tmpLocations,
        updatedChildren,
        allLocations,
      );

      setState(() {
        locationsChildren = updatedChildren;
        selectedLocations = tmpLocations;
        locationsContext = updatedContext;
      });
    }
    setState(() {
      totalSelectedLocations = [...locationsChildren];
      totalSelectedLocations.addAll(
        selectedLocations.map((e) => e.id).toList(),
      );
    });
  }

  @override
  void initState() {
    features = [
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

  // add new group
  void addNewGroup(BuildContext context) {
    String errorMessage = '';
    // group name validation
    if (!_formKey.currentState!.validate()) {
      errorMessage = AppLocalizations.of(context)!
          .group_management_add_error_name_to_short;
    } else {
      // locations selection validation
      if (selectedLocations.isEmpty) {
        errorMessage = AppLocalizations.of(context)!
            .group_management_add_error_no_location_selected;
      } else {
        // premissions validation
        bool isAtLeastOneFeatureSelected = false;
        for (var feature in features) {
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
                (group) => group.name == nameTexEditingController.text.trim());
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
        name: nameTexEditingController.text,
        description: descriptionTexEditingController.text,
        groupAdministrators: const [],
        locations: totalSelectedLocations,
        features: features,
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
  Widget build(BuildContext context) {
    pages = [
      KeepAlivePage(
        child: AddGroupNameCard(
          isEditMode: group != null,
          pageController: pageController,
          nameTexEditingController: nameTexEditingController,
          descriptionTexEditingController: descriptionTexEditingController,
        ),
      ),
      KeepAlivePage(
        child: AddGroupLocationsCard(
          pageController: pageController,
          locationsChildren: locationsChildren,
          locationsContext: locationsContext,
          selectedLocations: selectedLocations,
          toggleLocationSelection: toggleLocationSelection,
        ),
      ),
      AddGroupFeaturesCard(
        pageController: pageController,
        features: features,
      ),
      AddGroupSummaryCard(
        pageController: pageController,
        addNewGroup: addNewGroup,
        nameTexEditingController: nameTexEditingController,
        descriptionTexEditingController: descriptionTexEditingController,
        totalSelectedLocations: totalSelectedLocations,
        features: features,
      ),
    ];

    return Scaffold(body: BlocBuilder<GroupBloc, GroupState>(
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
                  controller: pageController,
                  children: pages,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: SmoothPageIndicator(
                  controller: pageController,
                  count: pages.length,
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
    ));
  }
}
