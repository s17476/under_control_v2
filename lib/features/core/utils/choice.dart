import 'package:flutter/material.dart';

class Choice {
  const Choice({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Function onTap;
}
