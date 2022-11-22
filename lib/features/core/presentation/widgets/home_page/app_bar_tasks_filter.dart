import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../utils/show_snack_bar.dart';
import '../../pages/qr_scanner.dart';
import '../custom_text_form_field.dart';
import '../rounded_button.dart';

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
                  padding: const EdgeInsets.all(12),
                  child: Text('Tasks filter'),
                ),
              ),
            );
          });
    }
  }
}
