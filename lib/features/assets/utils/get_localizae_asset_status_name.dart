import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'asset_status.dart';

String getLocalizedAssetStatusName(
    BuildContext context, AssetStatus assetStatus) {
  switch (assetStatus) {
    case AssetStatus.ok:
      return AppLocalizations.of(context)!.asset_status_ok;
    case AssetStatus.workingRequiresAttention:
      return AppLocalizations.of(context)!
          .asset_status_working_requires_attention;
    case AssetStatus.notWorkingRequiresReparation:
      return AppLocalizations.of(context)!
          .asset_status_not_working_requires_reparation;
    case AssetStatus.disposed:
      return AppLocalizations.of(context)!.asset_status_disposed;
    case AssetStatus.noInspection:
      return AppLocalizations.of(context)!.asset_status_no_inspection;
    default:
      return '';
  }
}
