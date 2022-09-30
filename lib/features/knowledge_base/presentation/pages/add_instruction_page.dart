import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:under_control_v2/features/knowledge_base/data/models/instruction_step_model.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/content_type.dart';
import 'package:under_control_v2/features/knowledge_base/presentation/widgets/add_instruction/add_instruction_summary_card.dart';
import 'package:under_control_v2/features/knowledge_base/presentation/widgets/add_instruction/add_step_card.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../data/models/instruction_model.dart';
import '../../domain/entities/instruction.dart';
import '../../domain/entities/instruction_step.dart';
import '../blocs/instruction/instruction_bloc.dart';
import '../widgets/add_instruction/add_instruction_card.dart';

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

  List<InstructionStep> _steps = [
    InstructionStepModel.initial(),
  ];

  List<InstructionStep> _getFinalSteps() =>
      _steps.where((stp) => stp.contentType != ContentType.unknown).toList()
        ..sort(
          (a, b) => a.id.compareTo(b.id),
        );

  void _addNewInstruction(BuildContext context) {
    print('ADD');
  }

  // void _addNewItem(BuildContext context) {
  //   String errorMessage = '';
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

  // changes step contentType
  void _setStepContentType(
      InstructionStep instructionStep, ContentType contentType) {
    var index = _steps.indexWhere((stp) => stp.id == instructionStep.id);
    if (index >= 0) {
      if (index == _steps.length - 1) {
        setState(() {
          _steps[index] = (_steps[index] as InstructionStepModel).copyWith(
            contentType: contentType,
            contentUrl: null,
            file: null,
          );
          _steps.add(
            InstructionStepModel(
              id: _steps.length,
              contentType: ContentType.unknown,
            ),
          );
        });
      } else {
        setState(() {
          _steps[index] = (_steps[index] as InstructionStepModel).copyWith(
            contentType: contentType,
            contentUrl: null,
            file: null,
          );
        });
      }
    }
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
        AddStepCard(
          pageController: _pageController,
          step: step,
          setContentType: _setStepContentType,
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

    return Scaffold(body: BlocBuilder<InstructionBloc, InstructionState>(
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
    ));
  }
}
