import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities/asset.dart';
import '../presentation/blocs/asset_category/asset_category_bloc.dart';

List<Asset> searchAssets(
  BuildContext context,
  List<Asset> allAssets,
  String searchQuery,
) {
  if (searchQuery.trim().isNotEmpty) {
    final categoryState = context.read<AssetCategoryBloc>().state;
    if (categoryState is AssetCategoryLoadedState) {
      return allAssets
          .where(
            (asset) =>
                asset.producer
                    .toLowerCase()
                    .contains(searchQuery.trim().toLowerCase()) ||
                asset.model
                    .toLowerCase()
                    .contains(searchQuery.trim().toLowerCase()) ||
                asset.internalCode
                    .toLowerCase()
                    .contains(searchQuery.trim().toLowerCase()) ||
                asset.barCode
                    .toLowerCase()
                    .contains(searchQuery.trim().toLowerCase()) ||
                categoryState
                    .getAssetCategoryById(asset.categoryId)!
                    .name
                    .toLowerCase()
                    .contains(searchQuery.trim().toLowerCase()),
          )
          .toList();
    }
  }
  return allAssets;
}
