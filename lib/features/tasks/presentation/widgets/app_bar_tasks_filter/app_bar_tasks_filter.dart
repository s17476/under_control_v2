import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/app_bar_tasks_filter/task_owner_tab_bar.dart';

import '../../../../core/utils/show_snack_bar.dart';
import '../../../../core/presentation/pages/qr_scanner.dart';
import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';

class AppBarTasksFilter extends StatelessWidget {
  const AppBarTasksFilter({
    Key? key,
    required this.isTaskFilterVisible,
    required this.tasksFilterHeight,
  }) : super(key: key);

  final bool isTaskFilterVisible;
  final double tasksFilterHeight;

  @override
  Widget build(BuildContext context) {
    final Color? tabBarIconColor = Theme.of(context).textTheme.bodyLarge!.color;
    const double tabBarIconSize = 32;
    if (!isTaskFilterVisible) {
      return const SizedBox();
    } else {
      return TweenAnimationBuilder(
          duration: const Duration(milliseconds: 300),
          tween: Tween<Offset>(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ),
          builder: (context, Offset offset, child) {
            return FractionalTranslation(
              translation: offset,
              child: Container(
                height: tasksFilterHeight,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 0.5),
                      color: Colors.grey.shade700,
                      blurRadius: 3,
                    )
                  ],
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 8,
                    right: 8,
                    bottom: 8,
                  ),
                  child: Column(
                    children: [
                      TaskOwnerTabBar(
                        iconSize: tabBarIconSize,
                        color: tabBarIconColor,
                        indicatorColor: tabBarIconColor,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
