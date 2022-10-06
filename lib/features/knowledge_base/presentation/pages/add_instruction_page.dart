import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../data/models/instruction_model.dart';
import '../../data/models/instruction_step_model.dart';
import '../../domain/entities/content_type.dart';
import '../../domain/entities/instruction.dart';
import '../../domain/entities/instruction_step.dart';
import '../../utils/validate_step.dart';
import '../blocs/instruction/instruction_bloc.dart';
import '../widgets/add_instruction/add_instruction_card.dart';
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

  List<Widget> _pages = [];

  final _formKey = GlobalKey<FormState>();

  final _pageController = PageController();

  final _titleTexEditingController = TextEditingController();
  final _descriptionTextEditingController = TextEditingController();

  String _category = '';

  List<InstructionStep> _steps = [];

  List<InstructionStep> _getFinalSteps() =>
      _steps.sublist(0, _steps.length - 1);
  // _steps.where((stp) => stp.contentType != ContentType.unknown).toList()
  //   ..sort(
  //     (a, b) => a.id.compareTo(b.id),
  //   );

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
      showSnackBar(
        context: context,
        message: 'OK',
      );
    }
  }

  // void _addNewItem(BuildContext context) {
  //   double price = 0;
  //   // item name validation
  //   if (!_formKey.currentState!.validate()) {
  //     errorMessage = AppLocalizations.of(context)!.item_add_error_name_to_short;
  //   } else {
  //     // price validation
  //     if (_priceTextEditingController.text.trim().isNotEmpty) {
  //       try {
  //         price = double.parse(_priceTextEditingController.text.trim());
  //         if (price < 0) {
  //           errorMessage =
  //               AppLocalizations.of(context)!.incorrect_price_to_small;
  //         }
  //       } catch (e) {
  //         errorMessage = AppLocalizations.of(context)!.incorrect_price_format;
  //       }
  //     }
  //     // category selection validation
  //     if (_category.isEmpty) {
  //       errorMessage =
  //           AppLocalizations.of(context)!.item_add_error_category_not_selected;
  //     } else {
  //       // item unit selection validation

  //       if (_itemUnit.isEmpty) {
  //         errorMessage =
  //             AppLocalizations.of(context)!.item_add_error_unit_not_selected;
  //       } else if (_item == null) {
  //         final currentState = context.read<ItemsBloc>().state;
  //         if (currentState is ItemsLoadedState) {
  //           final tmpItems = currentState.allItems.allItems
  //               .where((i) => i.name == _nameTexEditingController.text.trim());
  //           if (tmpItems.isNotEmpty) {
  //             errorMessage = AppLocalizations.of(context)!
  //                 .group_management_add_error_name_exists;
  //           }
  //         }
  //       }
  //     }
  //   }

  //   // shows SnackBar if validation error occures
  //   if (errorMessage.isNotEmpty) {
  //     showSnackBar(
  //       context: context,
  //       message: errorMessage,
  //       isErrorMessage: true,
  //     );
  //     // saves group to DB if no error
  //   } else {
  //     final newItem = ItemModel(
  //       id: _item != null ? _item!.id : '',
  //       name: _nameTexEditingController.text.trim(),
  //       description: _descriptionTexEditingController.text.trim(),
  //       category: _category,
  //       price: price,
  //       itemCode: _codeTextEditingController.text.trim(),
  //       itemBarCode: _barCodeTextEditingController.text.trim(),
  //       itemPhoto: _item != null ? _item!.itemPhoto : '',
  //       itemUnit: ItemUnit.fromString(_itemUnit),
  //       amountInLocations: _item != null ? _item!.amountInLocations : const [],
  //       locations: _item != null ? _item!.locations : const [],
  //       sparePartFor: const [],
  //     );

  //     if (_item != null) {
  //       context.read<ItemsManagementBloc>().add(UpdateItemEvent(
  //             item: newItem,
  //             itemPhoto: _itemImage,
  //           ));
  //     } else {
  //       context.read<ItemsManagementBloc>().add(
  //             AddItemEvent(
  //               item: newItem,
  //               itemPhoto: _itemImage,
  //             ),
  //           );
  //     }

  //     Navigator.pop(context);
  //   }
  // }

  void _setCategory(String value) {
    setState(() {
      _category = value;
    });
  }

  void _updateStep(InstructionStep step) {
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
          _steps[i] = InstructionStep(
            id: _steps[i].id - 1,
            contentType: _steps[i].contentType,
            contentUrl: _steps[i].contentUrl,
            description: _steps[i].description,
            file: _steps[i].file,
            title: _steps[i].title,
          );
        }
        _steps.removeAt(index);
      });
    }
  }

  void _insertStepBefore(InstructionStep step) {
    final index = _steps.indexWhere((stp) => stp.id == step.id);
    if (index >= 0) {
      setState(() {
        _steps.insert(
          index,
          InstructionStep(id: index, contentType: ContentType.unknown),
        );
        for (int i = index + 1; i < _steps.length; i++) {
          _steps[i] = InstructionStep(
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
          InstructionStep(id: index + 1, contentType: ContentType.unknown),
        );
        for (int i = index + 2; i < _steps.length; i++) {
          _steps[i] = InstructionStep(
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

  void _moveBack(InstructionStep step) {
    final index = _steps.indexWhere((stp) => stp.id == step.id);
    if (index >= 1) {
      setState(() {
        _steps[index - 1] = InstructionStep(
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
          InstructionStep(
            id: step.id - 1,
            contentType: step.contentType,
            contentUrl: step.contentUrl,
            description: step.description,
            file: step.file,
            title: step.title,
          ),
        );
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _moveForward(InstructionStep step) {
    final index = _steps.indexWhere((stp) => stp.id == step.id);
    if (index < _steps.length - 2) {
      setState(() {
        _steps[index + 1] = InstructionStep(
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
          InstructionStep(
            id: step.id + 1,
            contentType: step.contentType,
            contentUrl: step.contentUrl,
            description: step.description,
            file: step.file,
            title: step.title,
          ),
        );
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
          _steps[index] = InstructionStep(
            id: _steps[index].id,
            contentType: contentType,
            description: null,
            title: null,
            contentUrl: null,
            file: null,
          );
          _steps.add(
            InstructionStep(
              id: _steps.length,
              contentType: ContentType.unknown,
            ),
          );
        });
      } else {
        setState(() {
          _steps[index] = InstructionStep(
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
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments != null && arguments is InstructionModel) {
      _instruction = arguments.deepCopy();

      _titleTexEditingController.text = _instruction!.name;
      _descriptionTextEditingController.text = _instruction!.description;
      _category = _instruction!.category;
      _steps = _instruction!.steps;
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
          pageController: _pageController,
          titleTexEditingController: _titleTexEditingController,
          descriptionTexEditingController: _descriptionTextEditingController,
          category: _category,
          setCategory: _setCategory,
        ),
      ),
      for (var step in _steps)
        KeepAlivePage(
          child: AddStepCard(
            pageController: _pageController,
            step: step,
            setContentType: _setStepContentType,
            updateStep: _updateStep,
            removeStep: _removeStep,
            isLastStep: step.id == _steps.length - 1,
            insertStepAfter: _insertStepAfter,
            insertStepBefore: _insertStepBefore,
            moveBack: _moveBack,
            moveForward: _moveForward,
          ),
        ),
      AddInstructionSummaryCard(
        pageController: _pageController,
        titleTexEditingController: _titleTexEditingController,
        descriptionTextEditingController: _descriptionTextEditingController,
        steps: _getFinalSteps(),
        category: _category,
        addNewInstruction: _addNewInstruction,
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
      child: Scaffold(body: BlocBuilder<InstructionBloc, InstructionState>(
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
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
