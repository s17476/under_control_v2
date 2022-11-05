import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/assets/utils/get_asset_status_icon.dart';

import '../../../core/presentation/widgets/selection_button.dart';
import '../../../core/utils/responsive_size.dart';
import '../../domain/entities/task_priority.dart';
import '../../utils/get_task_priority_icon.dart';

class SetAssetStatusCard extends StatelessWidget with ResponsiveSize {
  const SetAssetStatusCard({
    Key? key,
    required this.setStatus,
    required this.assetStatus,
  }) : super(key: key);

  final Function(String) setStatus;
  final String assetStatus;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                // title
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 8,
                    right: 8,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.asset_status,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ok
                        SelectionButton<String>(
                          onSelected: (val) {
                            setStatus(val);
                          },
                          leading: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 16,
                            ),
                            width: 70,
                            height: 70,
                            child:
                                getAssetStatusIcon(context, AssetStatus.ok, 35),
                          ),
                          iconSize: 50,
                          title: AppLocalizations.of(context)!.asset_status_ok,
                          titleSize: 22,
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).cardColor,
                              Theme.of(context).cardColor,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          value: AssetStatus.ok.name,
                          groupValue: assetStatus,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // attention
                        SelectionButton<String>(
                          onSelected: (val) {
                            setStatus(val);
                          },
                          leading: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 16,
                            ),
                            width: 70,
                            height: 70,
                            child: getAssetStatusIcon(context,
                                AssetStatus.workingRequiresAttention, 35),
                          ),
                          iconSize: 50,
                          title: AppLocalizations.of(context)!
                              .asset_status_working_requires_attention,
                          titleSize: 22,
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).cardColor,
                              Theme.of(context).cardColor,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          value: AssetStatus.workingRequiresAttention.name,
                          groupValue: assetStatus,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // not working
                        SelectionButton<String>(
                          onSelected: (val) {
                            setStatus(val);
                          },
                          leading: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 16,
                            ),
                            width: 70,
                            height: 70,
                            child: getAssetStatusIcon(context,
                                AssetStatus.notWorkingRequiresReparation, 35),
                          ),
                          iconSize: 50,
                          title: AppLocalizations.of(context)!
                              .asset_status_not_working_requires_reparation,
                          titleSize: 22,
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).cardColor,
                              Theme.of(context).cardColor,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          value: AssetStatus.notWorkingRequiresReparation.name,
                          groupValue: assetStatus,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
