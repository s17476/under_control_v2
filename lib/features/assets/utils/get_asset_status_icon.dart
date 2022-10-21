import 'package:flutter/material.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';

Widget getAssetStatusIcon(BuildContext context, AssetStatus status) {
  Widget icon = const Icon(Icons.question_mark);
  String assetPath = '';
  switch (status) {
    case AssetStatus.ok:
      icon = Stack(
        alignment: Alignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.only(bottom: 1.0),
            child: Icon(
              Icons.done,
              color: Colors.black87,
            ),
          ),
          Icon(
            Icons.done,
            color: Colors.black87,
          ),
        ],
      );
      assetPath = 'assets/status_ok.png';
      break;
    case AssetStatus.workingRequiresAttention:
      icon = const Icon(
        Icons.notifications_active,
        color: Colors.black87,
      );
      assetPath = 'assets/status_working.png';
      break;
    case AssetStatus.workingRequiresReparation:
      icon = const Icon(
        Icons.handyman,
        color: Colors.black87,
      );
      assetPath = 'assets/status_working.png';
      break;
    case AssetStatus.notWorkingRequiresReparation:
      icon = const Icon(
        Icons.handyman,
        color: Colors.black87,
      );
      assetPath = 'assets/status_not_working.png';
      break;
    case AssetStatus.disposed:
      icon = const Icon(
        Icons.clear,
        color: Colors.black87,
      );
      assetPath = 'assets/status_disposed.png';
      break;
    default:
      icon = const Icon(
        Icons.question_mark,
        color: Colors.black87,
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
