import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/selection_button.dart';
import '../../../../core/utils/responsive_size.dart';

class AddAssetIsSparePartCard extends StatelessWidget with ResponsiveSize {
  const AddAssetIsSparePartCard({
    Key? key,
    required this.setIsSparePart,
    required this.setParentAsset,
    required this.isSparePart,
  }) : super(key: key);

  final Function(bool) setIsSparePart;
  final Function(String) setParentAsset;
  final bool isSparePart;

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
                    AppLocalizations.of(context)!.asset_type,
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
                          onSelected: (val) {
                            setIsSparePart(val);
                            setParentAsset('');
                          },
                          icon: Icons.check_circle,
                          iconSize: 50,
                          title: AppLocalizations.of(context)!
                              .asset_not_spare_part,
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
                          value: false,
                          groupValue: isSparePart,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        // spare part
                        SelectionButton<bool>(
                          onSelected: setIsSparePart,
                          icon: Icons.build_circle_rounded,
                          iconSize: 50,
                          title: AppLocalizations.of(context)!.asset_spare_part,
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
                          value: true,
                          groupValue: isSparePart,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info,
                              color:
                                  Theme.of(context).textTheme.caption!.color!,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .asset_spare_part_description,
                              style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption!.color!,
                              ),
                            ),
                          ],
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
