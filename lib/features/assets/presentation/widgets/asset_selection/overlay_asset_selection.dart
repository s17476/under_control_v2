import 'package:flutter/material.dart';

import 'package:under_control_v2/features/core/presentation/widgets/glass_layer.dart';

class OverlayAssetSelection extends StatefulWidget {
  const OverlayAssetSelection({
    Key? key,
    required this.spareParts,
    required this.addAsset,
    required this.removeAsset,
    required this.onDismiss,
  }) : super(key: key);

  final List<String> spareParts;
  final Function(String) addAsset;
  final Function(String) removeAsset;
  final Function() onDismiss;

  @override
  State<OverlayAssetSelection> createState() => _OverlayAssetSelectionState();
}

class _OverlayAssetSelectionState extends State<OverlayAssetSelection> {
  String searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return GlassLayer(
      onDismiss: widget.onDismiss,
      child: Container(),
    );
  }
}
