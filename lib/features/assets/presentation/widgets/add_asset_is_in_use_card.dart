import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/selection_button.dart';
import '../../../core/utils/responsive_size.dart';
import '../blocs/asset/asset_bloc.dart';

class AddAssetIsInUseCard extends StatelessWidget with ResponsiveSize {
  const AddAssetIsInUseCard({
    Key? key,
    required this.setIsInUse,
    required this.isInUse,
    required this.setParentAsset,
    required this.isSparePart,
    required this.setLocation,
  }) : super(key: key);

  final Function(bool) setIsInUse;
  final bool isInUse;
  final Function(String) setParentAsset;
  final bool isSparePart;
  final Function(String) setLocation;

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
                    AppLocalizations.of(context)!.asset_is_in_use,
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
                        // not a spare part
                        SelectionButton<bool>(
                          onSelected: setIsInUse,
                          icon: Icons.play_circle,
                          iconSize: 50,
                          title: AppLocalizations.of(context)!.asset_in_use,
                          titleSize: 18,
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).primaryColor.withAlpha(100),
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withAlpha(80),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          value: true,
                          groupValue: isInUse,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // spare part
                        SelectionButton<bool>(
                          onSelected: setIsInUse,
                          icon: Icons.pause_circle,
                          iconSize: 50,
                          title: AppLocalizations.of(context)!.asset_not_in_use,
                          titleSize: 18,
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange.withAlpha(150),
                              Colors.orange,
                              Colors.orange.withAlpha(80),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          value: false,
                          groupValue: isInUse,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // TODO
                        if (isInUse && isSparePart)
                          Text(
                            AppLocalizations.of(context)!.asset_parent_select,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        const SizedBox(
                          height: 8,
                        ),
                        if (isInUse && isSparePart)
                          Expanded(
                            child: SingleChildScrollView(
                              child: BlocBuilder<AssetBloc, AssetState>(
                                builder: (context, state) {
                                  if (state is AssetLoadedState) {
                                    if (state.allAssets.allAssets.isNotEmpty) {
                                      return Text('assety');
                                    }
                                    return Text('nic nie ma');
                                  }
                                  return Text('loading');
                                },
                              ),
                            ),
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
