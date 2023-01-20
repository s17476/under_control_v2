import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates/task_templates_bloc.dart';
import 'package:under_control_v2/features/tasks/presentation/pages/add_task_template_page.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/task_tile.dart';

import '../../../core/presentation/widgets/home_page/app_bar_animated_icon.dart';
import '../../../core/presentation/widgets/loading_widget.dart';
import '../../domain/entities/task/task.dart';
import '../../utils/template_listener.dart';

class TemplatesManagementPage extends StatelessWidget {
  const TemplatesManagementPage({Key? key}) : super(key: key);

  static const routeName = '/task-templates';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const AppBarAnimatedIcon(isBackIcon: true),
            );
          },
        ),
        title: Text(AppLocalizations.of(context)!.task_templates),
        centerTitle: true,
      ),
      body: TemplateListener(
        child: BlocBuilder<TaskTemplatesBloc, TaskTemplatesState>(
          builder: (context, state) {
            if (state is TaskTemplatesLoadedState) {
              List<Task> allTasks = state.allTasks.allTasks;
              return ListView.builder(
                itemCount: allTasks.length + 1,
                itemBuilder: (context, index) {
                  if (index == allTasks.length) {
                    return const SizedBox(
                      height: 80,
                    );
                  } else {
                    return Padding(
                      key: ValueKey(allTasks[index].id),
                      padding: EdgeInsets.only(top: index == 0 ? 4 : 0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TaskTile(task: allTasks[index]),
                      ),
                    );
                  }
                },
              );
            } else {
              return const LoadingWidget();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        onPressed: () {
          Navigator.pushNamed(context, AddTaskTemplatePage.routeName);
        },
        icon: Icon(
          Icons.add,
          color: Colors.grey.shade200,
        ),
        label: Text(
          AppLocalizations.of(context)!.checklist_add_button,
          style: TextStyle(
            color: Colors.grey.shade200,
          ),
        ),
      ),
    );
  }
}
