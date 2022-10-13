import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/data/models/last_edit_model.dart';
import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/location_selection_helpers.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../groups/presentation/widgets/add_group/add_group_locations_card.dart';
import '../../../locations/domain/entities/location.dart';
import '../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../data/models/instruction_model.dart';
import '../../data/models/instruction_step_model.dart';
import '../../domain/entities/content_type.dart';
import '../../domain/entities/instruction.dart';
import '../../domain/entities/instruction_step.dart';
import '../../utils/steps_validation.dart';
import '../blocs/instruction/instruction_bloc.dart';
import '../blocs/instruction_management/instruction_management_bloc.dart';
import '../widgets/add_instruction/add_instruction_card.dart';
import '../widgets/add_instruction/add_instruction_publish_card.dart';
import '../widgets/add_instruction/add_instruction_summary_card.dart';
import '../widgets/add_instruction/add_step_card.dart';

class AddInstructionPage extends StatefulWidget {
  const AddInstructionPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/knowledge-base/add-instruction';

  @override
  State<AddInstructionPage> createState() => _AddInstructionPageState();
}

class _AddInstructionPageState extends State<AddInstructionPage> {
  Instruction? _instruction;
  late String _userId;

  List<Widget> _pages = [];

  final _formKey = GlobalKey<FormState>();

  final _pageController = PageController();

  final _titleTexEditingController = TextEditingController();
  final _descriptionTextEditingController = TextEditingController();

  String _category = '';

  bool _isPublished = false;

  List<InstructionStepModel> _steps = [];
  List<ValueKey> _stepsKeys = [];
  List<Location> _selectedLocations = [];
  List<String> _locationsChildren = [];
  List<String> _locationsContext = [];
  List<String> _totalSelectedLocations = [];

  List<InstructionStepModel> _getFinalSteps() =>
      _steps.sublist(0, _steps.length - 1);

  void _setIsPublished(bool value) {
    setState(() {
      _isPublished = value;
    });
  }

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

  void _addNewInstruction(BuildContext context) {
    String errorMessage = '';
    // title validation
    if (!_formKey.currentState!.validate() &&
        _titleTexEditingController.text.trim().length < 2) {
      errorMessage =
          '${AppLocalizations.of(context)!.title} -  ${AppLocalizations.of(context)!.validation_min_two_characters}';

      // category selection validation
    } else if (_category.isEmpty) {
      errorMessage = AppLocalizations.of(context)!.category_no_select;
      // locations selection validation
    } else if (_selectedLocations.isEmpty) {
      errorMessage = AppLocalizations.of(context)!
          .group_management_add_error_no_location_selected;
      // steps list validation
    } else if (_getFinalSteps().isEmpty) {
      errorMessage = AppLocalizations.of(context)!.instruction_no_steps;
      // steps validation
    } else {
      for (var step in _getFinalSteps()) {
        errorMessage = validateStep(context, step) ?? '';
        if (errorMessage.isNotEmpty) {
          break;
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
      // saves instruction to DB if no error
    } else {
      final lastEdit = LastEditModel(userId: _userId, dateTime: DateTime.now());
      List<LastEditModel> lastEdited = [];
      if (_instruction != null) {
        lastEdited.addAll([..._instruction!.lastEdited, lastEdit]);
      } else {
        lastEdited.add(lastEdit);
      }

      final newInstruction = InstructionModel(
        id: _instruction != null ? _instruction!.id : '',
        name: _titleTexEditingController.text.trim(),
        description: _descriptionTextEditingController.text.trim(),
        category: _category,
        steps: _getFinalSteps(),
        locations: _totalSelectedLocations,
        userId: _instruction != null ? _instruction!.userId : _userId,
        lastEdited: lastEdited,
        isPublished: _isPublished,
      );

      if (_instruction != null) {
        context.read<InstructionManagementBloc>().add(
              UpdateInstructionEvent(
                instruction: newInstruction,
              ),
            );
      } else {
        context.read<InstructionManagementBloc>().add(
              AddInstructionEvent(
                instruction: newInstruction,
              ),
            );
      }
      Navigator.pop(context);
    }
  }

  void _setCategory(String value) {
    setState(() {
      _category = value;
    });
  }

  void _updateStep(InstructionStepModel step) {
    final index = _steps.indexWhere((stp) => stp.id == step.id);
    if (index >= 0) {
      setState(() {
        _steps[index] = step;
      });
    }
  }

  void _removeStep(InstructionStep step) {
    final index = _steps.indexWhere((stp) => stp.id == step.id);
    if (index >= 0) {
      setState(() {
        for (int i = index + 1; i < _steps.length; i++) {
          _steps[i] = InstructionStepModel(
            id: _steps[i].id - 1,
            contentType: _steps[i].contentType,
            contentUrl: _steps[i].contentUrl,
            description: _steps[i].description,
            file: _steps[i].file,
            title: _steps[i].title,
          );
        }
        _steps.removeAt(index);
        _stepsKeys.removeAt(index);
      });
    }
  }

  void _insertStepBefore(InstructionStep step) {
    final index = _steps.indexWhere((stp) => stp.id == step.id);
    if (index >= 0) {
      setState(() {
        _steps.insert(
          index,
          InstructionStepModel(id: index, contentType: ContentType.unknown),
        );
        _stepsKeys.insert(index, ValueKey(DateTime.now().toIso8601String()));
        for (int i = index + 1; i < _steps.length; i++) {
          _steps[i] = InstructionStepModel(
            id: _steps[i].id + 1,
            contentType: _steps[i].contentType,
            contentUrl: _steps[i].contentUrl,
            description: _steps[i].description,
            file: _steps[i].file,
            title: _steps[i].title,
          );
        }
      });
    }
  }

  void _insertStepAfter(InstructionStep step) {
    final index = _steps.indexWhere((stp) => stp.id == step.id);
    if (index >= 0 && index < _steps.length - 2) {
      setState(() {
        _steps.insert(
          index + 1,
          InstructionStepModel(id: index + 1, contentType: ContentType.unknown),
        );
        _stepsKeys.insert(
          index + 1,
          ValueKey(DateTime.now().toIso8601String()),
        );
        for (int i = index + 2; i < _steps.length; i++) {
          _steps[i] = InstructionStepModel(
            id: _steps[i].id + 1,
            contentType: _steps[i].contentType,
            contentUrl: _steps[i].contentUrl,
            description: _steps[i].description,
            file: _steps[i].file,
            title: _steps[i].title,
          );
        }
      });
    }
  }

  void _moveStepBack(InstructionStep step) {
    final index = _steps.indexWhere((stp) => stp.id == step.id);
    if (index >= 1) {
      setState(() {
        _steps[index - 1] = InstructionStepModel(
          id: _steps[index - 1].id + 1,
          contentType: _steps[index - 1].contentType,
          contentUrl: _steps[index - 1].contentUrl,
          description: _steps[index - 1].description,
          file: _steps[index - 1].file,
          title: _steps[index - 1].title,
        );
        _steps.removeAt(index);
        _steps.insert(
          index - 1,
          InstructionStepModel(
            id: step.id - 1,
            contentType: step.contentType,
            contentUrl: step.contentUrl,
            description: step.description,
            file: step.file,
            title: step.title,
          ),
        );
        final key = _stepsKeys[index];
        _stepsKeys.removeAt(index);
        _stepsKeys.insert(index - 1, key);
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _moveStepForward(InstructionStep step) {
    final index = _steps.indexWhere((stp) => stp.id == step.id);
    if (index < _steps.length - 2) {
      setState(() {
        _steps[index + 1] = InstructionStepModel(
          id: _steps[index + 1].id - 1,
          contentType: _steps[index + 1].contentType,
          contentUrl: _steps[index + 1].contentUrl,
          description: _steps[index + 1].description,
          file: _steps[index + 1].file,
          title: _steps[index + 1].title,
        );
        _steps.removeAt(index);
        _steps.insert(
          index + 1,
          InstructionStepModel(
            id: step.id + 1,
            contentType: step.contentType,
            contentUrl: step.contentUrl,
            description: step.description,
            file: step.file,
            title: step.title,
          ),
        );
        final key = _stepsKeys[index];
        _stepsKeys.removeAt(index);
        _stepsKeys.insert(index + 1, key);
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // changes step contentType
  void _setStepContentType(
      InstructionStep instructionStep, ContentType contentType) {
    var index = _steps.indexWhere((stp) => stp.id == instructionStep.id);
    if (index >= 0) {
      if (index == _steps.length - 1) {
        setState(() {
          _steps[index] = InstructionStepModel(
            id: _steps[index].id,
            contentType: contentType,
            description: null,
            title: null,
            contentUrl: null,
            file: null,
          );
          _steps.add(
            InstructionStepModel(
              id: _steps.length,
              contentType: ContentType.unknown,
            ),
          );
          _stepsKeys.add(ValueKey(DateTime.now().toIso8601String()));
        });
      } else {
        setState(() {
          _steps[index] = InstructionStepModel(
            id: instructionStep.id,
            contentType: contentType,
            description: instructionStep.description,
            title: instructionStep.title,
            contentUrl: null,
            file: null,
          );
        });
      }
      // remove last item
      if (contentType == ContentType.unknown && index == _steps.length - 2) {
        _steps.removeAt(index + 1);
      }
    }
  }

  @override
  void initState() {
    if (_steps.isEmpty) {
      _steps.add(
        InstructionStepModel.initial(),
      );
      _stepsKeys.add(ValueKey(DateTime.now().toIso8601String()));
    }
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

    if (arguments != null &&
        arguments is InstructionModel &&
        _instruction == null) {
      _instruction = arguments.deepCopy();

      _isPublished = _instruction!.isPublished;
      _titleTexEditingController.text = _instruction!.name;
      _descriptionTextEditingController.text = _instruction!.description;
      _category = _instruction!.category;
      _steps = _instruction!.steps;
      _steps.add(InstructionStepModel.initial().copyWith(id: _steps.length));
      _stepsKeys.clear();
      for (var _ in _steps) {
        _stepsKeys.add(ValueKey(DateTime.now().toIso8601String()));
      }
      List<Location> tmpSelecedlocations = [];
      final allLocations =
          (context.read<LocationBloc>().state as LocationLoadedState)
              .allLocations
              .allLocations;
      for (var locationId in _instruction!.locations) {
        final tmp =
            allLocations.where((element) => element.id == locationId).toList();
        if (tmp.isNotEmpty) {
          tmpSelecedlocations.addAll(tmp);
        }
      }
      _selectedLocations = tmpSelecedlocations;
      _totalSelectedLocations = _instruction!.locations;
      _locationsContext =
          getselectedLocationsContext(_selectedLocations, [], allLocations);
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _titleTexEditingController.dispose();
    _descriptionTextEditingController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      KeepAlivePage(
        child: AddInstructionCard(
          isEditMode: _instruction != null,
          titleTexEditingController: _titleTexEditingController,
          descriptionTexEditingController: _descriptionTextEditingController,
          category: _category,
          setCategory: _setCategory,
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
      for (var step in _steps)
        KeepAlivePage(
          key: ValueKey(_stepsKeys[_steps.indexOf(step)]),
          child: AddStepCard(
            step: step,
            setContentType: _setStepContentType,
            updateStep: _updateStep,
            removeStep: _removeStep,
            isLastStep: step.id == _steps.length - 1,
            insertStepAfter: _insertStepAfter,
            insertStepBefore: _insertStepBefore,
            moveBack: _moveStepBack,
            moveForward: _moveStepForward,
            instruction: _instruction,
          ),
        ),
      AddInstructionPublishCard(
        setIsPublished: _setIsPublished,
        isPublished: _isPublished,
      ),
      AddInstructionSummaryCard(
        pageController: _pageController,
        titleTexEditingController: _titleTexEditingController,
        descriptionTextEditingController: _descriptionTextEditingController,
        steps: _getFinalSteps(),
        totalSelectedLocations: _totalSelectedLocations,
        category: _category,
        addNewInstruction: _addNewInstruction,
        isPublished: _isPublished,
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
            message: _instruction != null
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
        body: BlocBuilder<InstructionBloc, InstructionState>(
          builder: (context, state) {
            if (state is InstructionLoadingState) {
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
                    lastPageForwardButtonFunction: () =>
                        _addNewInstruction(context),
                    lastPageForwardButtonIconData: _isPublished
                        ? Icons.cloud_upload
                        : Icons.drive_file_rename_outline_rounded,
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
