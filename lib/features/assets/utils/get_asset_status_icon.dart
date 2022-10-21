import 'package:flutter/material.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';

Widget getAssetStatusIcon(BuildContext context, AssetStatus status) {
  Icon icon = const Icon(Icons.question_mark);
  String assetPath = '';
  switch (status) {
    case AssetStatus.ok:
      icon = const Icon(
        Icons.notifications_active,
        color: Colors.black,
      );
      assetPath = 'assets/status_ok.png';
      break;
    case AssetStatus.workingRequiresAttention:
      icon = const Icon(
        Icons.notifications_active,
        color: Colors.black,
      );
      assetPath = 'assets/status_working.png';
      break;
    case AssetStatus.workingRequiresReparation:
      icon = Icon(
        Icons.circle,
        color: Theme.of(context).primaryColor,
      );
      assetPath = 'assets/status_working.png';
      break;
    case AssetStatus.notWorkingRequiresReparation:
      icon = Icon(
        Icons.circle,
        color: Theme.of(context).primaryColor,
      );
      assetPath = 'assets/status_not_working.png';
      break;
    case AssetStatus.disposed:
      icon = Icon(
        Icons.circle,
        color: Theme.of(context).primaryColor,
      );
      break;
    default:
      icon = const Icon(Icons.question_mark);
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
