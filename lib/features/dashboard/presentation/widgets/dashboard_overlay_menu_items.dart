import 'package:flutter/material.dart';

import '../../../core/utils/choice.dart';

List<Choice> dashboardOverlayMenuItems(BuildContext context) {
  final List<Choice> choices = [
    Choice(title: 'nothing', icon: Icons.abc, onTap: () {}),
  ];
  return choices;
}
