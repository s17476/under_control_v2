import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import '../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../assets/utils/asset_status.dart';
import '../../../assets/utils/get_asset_status_icon.dart';

class AssetsStatus extends StatelessWidget {
  const AssetsStatus({super.key});

  List<PieChartSectionData> showingSections(
    BuildContext context,
    int ok,
    int attention,
    int reparation,
    int noInspection,
  ) {
    final totalCount = ok + attention + reparation + noInspection;
    final okPercentage = ok / totalCount;
    final attentionPercentage = attention / totalCount;
    final reparationPercentage = (reparation + noInspection) / totalCount;

    return List.generate(3, (i) {
      // final isTouched = i == touchedIndex;
      final isTouched = false;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 15.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            showTitle: false,
            color: Theme.of(context).primaryColor,
            value: okPercentage,
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            showTitle: false,
            color: Colors.amber,
            value: attentionPercentage,
            radius: radius,
          );
        case 2:
          return PieChartSectionData(
            showTitle: false,
            color: Theme.of(context).errorColor,
            value: reparationPercentage,
            radius: radius,
          );

        default:
          throw Error();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetBloc, AssetState>(
      builder: (context, state) {
        if (state is AssetLoadedState) {
          if (state.allAssets.allAssets.isEmpty) {
            return const SizedBox();
          }

          final allAssets = state.allAssets.allAssets;
          final statusOk = allAssets
              .where(
                (asset) => asset.currentStatus == AssetStatus.ok,
              )
              .length;
          final statusAttention = allAssets
              .where(
                (asset) =>
                    asset.currentStatus == AssetStatus.workingRequiresAttention,
              )
              .length;
          final statusReparation = allAssets
              .where(
                (asset) =>
                    asset.currentStatus ==
                    AssetStatus.notWorkingRequiresReparation,
              )
              .length;
          final statusNoInspection = allAssets
              .where(
                (asset) => asset.currentStatus == AssetStatus.noInspection,
              )
              .length;
          final totalCount = statusOk +
              statusNoInspection +
              statusReparation +
              statusAttention;
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.precision_manufacturing,
                      color: Theme.of(context).textTheme.bodySmall!.color,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      AppLocalizations.of(context)!.assets_status,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  enabled: false,
                                  // touchCallback:
                                  //     (FlTouchEvent event, pieTouchResponse) {
                                  // setState(() {
                                  //   if (!event.isInterestedForInteractions ||
                                  //       pieTouchResponse == null ||
                                  //       pieTouchResponse.touchedSection == null) {
                                  //     touchedIndex = -1;
                                  //     return;
                                  //   }
                                  //   touchedIndex = pieTouchResponse
                                  //       .touchedSection!.touchedSectionIndex;
                                  // });
                                  //   },
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                startDegreeOffset: 270,
                                sectionsSpace: 4,
                                centerSpaceRadius: 30,
                                sections: showingSections(
                                  context,
                                  statusOk,
                                  statusAttention,
                                  statusReparation,
                                  statusNoInspection,
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .color,
                            radius: 24,
                            child: FittedBox(
                              child: Text(
                                '${((statusOk / totalCount) * 100).toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 8,
                            right: 8,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: getAssetStatusIcon(
                                      context,
                                      AssetStatus.ok,
                                      10,
                                      true,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .asset_status_ok,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    statusOk.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: getAssetStatusIcon(
                                      context,
                                      AssetStatus.workingRequiresAttention,
                                      10,
                                      true,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .asset_status_working_requires_attention,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    statusAttention.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: getAssetStatusIcon(
                                      context,
                                      AssetStatus.notWorkingRequiresReparation,
                                      10,
                                      true,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .asset_status_not_working_requires_reparation,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    statusReparation.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: getAssetStatusIcon(
                                      context,
                                      AssetStatus.noInspection,
                                      10,
                                      true,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .asset_status_no_inspection,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    statusNoInspection.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ],
            ),
          );
        }
        return Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor,
          highlightColor: Theme.of(context).cardColor.withAlpha(60),
          child: Container(
            width: double.infinity,
            height: 170,
            // margin: margin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
