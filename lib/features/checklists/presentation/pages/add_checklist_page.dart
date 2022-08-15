import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:under_control_v2/features/checklists/data/models/checklist_model.dart';
import 'package:under_control_v2/features/checklists/data/models/checkpoint_model.dart';
import 'package:under_control_v2/features/checklists/domain/entities/checkpoint.dart';
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist/checklist_bloc.dart';
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart';
import 'package:under_control_v2/features/checklists/presentation/widgets/add_checklist_summary_card.dart';
import 'package:under_control_v2/features/checklists/presentation/widgets/add_checkpoints_card.dart';
import 'package:under_control_v2/features/core/presentation/pages/loading_page.dart';
import 'package:under_control_v2/features/core/presentation/widgets/keep_alive_page.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';

import '../../domain/entities/checklist.dart';
import '../widgets/add_checklist_title_card.dart';

class AddChecklistPage extends StatefulWidget {
  const AddChecklistPage({Key? key}) : super(key: key);

  static const routeName = '/checklists/add-checklist';

  @override
  State<AddChecklistPage> createState() => _AddChecklistPageState();
}

class _AddChecklistPageState extends State<AddChecklistPage> {
  Checklist? checklist;

  List<Widget> pages = [];

  final _formKey = GlobalKey<FormState>();

  final pageController = PageController();

  final titleTexEditingController = TextEditingController();
  final descriptionTexEditingController = TextEditingController();

  List<CheckpointModel> checkpoints = [];

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments != null && arguments is Checklist) {
      checklist = arguments;
      titleTexEditingController.text = checklist!.title;
      descriptionTexEditingController.text = checklist!.description;

      checkpoints = checklist!.allCheckpoints;
    }
    super.didChangeDependencies();
  }

  // add new checklist
  void addNewChecklist(BuildContext context) {
    String errorMessage = '';
    // title validation
    if (!_formKey.currentState!.validate()) {
      errorMessage = 'title error';
      // checkpoints validation
    } else {
      if (checkpoints.isEmpty) {
        errorMessage = 'checkpoint empty';
        // checklist name validation
      } else if (checklist != null) {
        final currentState = context.read<ChecklistBloc>().state;
        if (checklist == null && currentState is ChecklistLoadedState) {
          final tmpChecklists = currentState.allChecklists.allChecklists.where(
              (checklist) =>
                  checklist.title.toLowerCase() ==
                  titleTexEditingController.text.trim().toLowerCase());
          if (tmpChecklists.isNotEmpty) {
            errorMessage = 'checklist exists';
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
      // saves checklist to DB if no error occures
    } else {
      final newChecklist = ChecklistModel(
        id: (checklist != null) ? checklist!.id : '',
        title: titleTexEditingController.text,
        description: descriptionTexEditingController.text,
        allCheckpoints: checkpoints,
      );

      // update
      if (checklist != null) {
        context.read<ChecklistManagementBloc>().add(
              UpdateChecklistEvent(checklist: newChecklist),
            );
        // add new
      } else {
        context.read<ChecklistManagementBloc>().add(
              AddChecklistEvent(checklist: newChecklist),
            );
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      KeepAlivePage(
        child: AddChecklistTitleCard(
          isEditMode: checklist != null,
          pageController: pageController,
          titleTexEditingController: titleTexEditingController,
          descriptionTexEditingController: descriptionTexEditingController,
        ),
      ),
      KeepAlivePage(
        child: AddCheckpointsCard(
          pageController: pageController,
          checkpoints: checkpoints,
        ),
      ),
      AddChecklistSummaryCard(
        pageController: pageController,
        titleTexEditingController: titleTexEditingController,
        descriptionTexEditingController: descriptionTexEditingController,
        checkpoints: checkpoints,
        addNewChecklist: addNewChecklist,
      ),
    ];
    return Scaffold(
      body: BlocBuilder<ChecklistBloc, ChecklistState>(
        builder: (context, state) {
          if (state is ChecklistLoadingState) {
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
      ),
    );
  }
}
