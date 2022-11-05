import 'package:flutter/material.dart';

import 'asset_status.dart';

Widget getAssetStatusIcon(
  BuildContext context,
  AssetStatus status, [
  double? iconSize,
]) {
  Widget icon = const Icon(Icons.question_mark);
  String assetPath = '';
  switch (status) {
    case AssetStatus.ok:
      icon = Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: Icon(
              Icons.done,
              color: Colors.black87,
              size: iconSize,
            ),
          ),
          Icon(
            Icons.done,
            color: Colors.black87,
            size: iconSize,
          ),
        ],
      );
      assetPath = 'assets/status_ok.png';
      break;
    case AssetStatus.workingRequiresAttention:
      icon = Icon(
        Icons.notifications_active,
        color: Colors.black87,
        size: iconSize,
      );
      assetPath = 'assets/status_working.png';
      break;
    case AssetStatus.notWorkingRequiresReparation:
      icon = Icon(
        Icons.handyman,
        color: Colors.black87,
        size: iconSize,
      );
      assetPath = 'assets/status_not_working.png';
      break;
    case AssetStatus.noInspection:
      icon = Icon(
        Icons.search_off,
        color: Colors.black87,
        size: iconSize,
      );
      assetPath = 'assets/status_not_working.png';
      break;
    case AssetStatus.disposed:
      icon = Icon(
        Icons.clear,
        color: Colors.black87,
        size: iconSize,
      );
      assetPath = 'assets/status_disposed.png';
      break;
    default:
      icon = Icon(
        Icons.question_mark,
        color: Colors.black87,
        size: iconSize,
      );
      assetPath = 'assets/status_disposed.png';
      break;
  }
  return Stack(
    alignment: Alignment.center,
    children: [
      Image.asset(assetPath),
      icon,
    ],
  );
}
