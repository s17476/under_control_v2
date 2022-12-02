import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../data/models/checklist_model.dart';
import '../../data/models/checkpoint_model.dart';
import '../../domain/entities/checklist.dart';
import '../blocs/checklist/checklist_bloc.dart';
import '../blocs/checklist_management/checklist_management_bloc.dart';
import '../widgets/add_checklist_summary_card.dart';
import '../widgets/add_checklist_title_card.dart';
import '../widgets/add_checkpoints_card.dart';

class AddChecklistPage extends StatefulWidget {
  const AddChecklistPage({Key? key}) : super(key: key);

  static const routeName = '/checklists/add-checklist';

  @override
  State<AddChecklistPage> createState() => _AddChecklistPageState();
}

class _AddChecklistPageState extends State<AddChecklistPage> {
  Checklist? _checklist;

  List<Widget> _pages = [];

  final _formKey = GlobalKey<FormState>();

  final _pageController = PageController();

  final _titleTexEditingController = TextEditingController();
  final _descriptionTexEditingController = TextEditingController();

  List<CheckpointModel> _checkpoints = [];

  // add new checklist
  void _addNewChecklist(BuildContext context) {
    String errorMessage = '';
    // name lenght validation
    if (!_formKey.currentState!.validate()) {
      errorMessage = AppLocalizations.of(context)!.checklist_add_name_to_short;
      // checkpoints validation
    } else {
      if (_checkpoints.isEmpty) {
        errorMessage =
            AppLocalizations.of(context)!.checklist_add_checkpoints_empty;
        // checklist name validation
      } else if (_checklist == null) {
        final currentState = context.read<ChecklistBloc>().state;
        if (currentState is ChecklistLoadedState) {
          final tmpChecklists = currentState.allChecklists.allChecklists.where(
              (checklist) =>
                  checklist.title.toLowerCase() ==
                  _titleTexEditingController.text.trim().toLowerCase());

          if (tmpChecklists.isNotEmpty) {
            errorMessage = AppLocalizations.of(context)!.checklist_add_exists;
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
        id: (_checklist != null) ? _checklist!.id : '',
        title: _titleTexEditingController.text,
        description: _descriptionTexEditingController.text,
        allCheckpoints: _checkpoints,
      );

      // update
      if (_checklist != null) {
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
  void dispose() {
    _pageController.dispose();
    _titleTexEditingController.dispose();
    _descriptionTexEditingController.dispose();
    super.dispose();
  }

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

    if (arguments != null && arguments is ChecklistModel) {
      _checklist = arguments.deepCopy();
      _titleTexEditingController.text = _checklist!.title;
      _descriptionTexEditingController.text = _checklist!.description;

      _checkpoints = _checklist!.allCheckpoints;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      KeepAlivePage(
        child: AddChecklistTitleCard(
          isEditMode: _checklist != null,
          titleTexEditingController: _titleTexEditingController,
          descriptionTexEditingController: _descriptionTexEditingController,
        ),
      ),
      KeepAlivePage(
        child: AddCheckpointsCard(
          checkpoints: _checkpoints,
        ),
      ),
      AddChecklistSummaryCard(
        pageController: _pageController,
        titleTexEditingController: _titleTexEditingController,
        descriptionTexEditingController: _descriptionTexEditingController,
        checkpoints: _checkpoints,
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
          );
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
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
                      controller: _pageController,
                      children: _pages,
                    ),
                  ),
                  CreatorBottomNavigation(
                    lastPageForwardButtonFunction: () =>
                        _addNewChecklist(context),
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
