import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../data/models/assets_list_model.dart';
import '../../../domain/entities/asset.dart';
import '../../../domain/usecases/get_assets_stream.dart';

part 'asset_event.dart';
part 'asset_state.dart';

@injectable
class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final FilterBloc filterBloc;
  final GetAssetsStream getAssetsStream;

  late StreamSubscription _filterStreamSubscription;
  final List<StreamSubscription?> _assetStreamSubscriptions = [];

  String _companyId = '';
  List<String> _locations = [];

  AssetBloc({
    required this.filterBloc,
    required this.getAssetsStream,
  }) : super(AssetEmptyState()) {
    _filterStreamSubscription = filterBloc.stream.listen(
      (state) {
        if (state is FilterLoadedState) {
          if (_assetStreamSubscriptions.isNotEmpty) {
            // cancel old subscriptions
            for (var assetSubscription in _assetStreamSubscriptions) {
              assetSubscription?.cancel();
            }
            // clear subscriptions list
            _assetStreamSubscriptions.clear();
          }

          _companyId = state.companyId;
          if (state.isAdmin && state.groups.isEmpty) {
            _locations = state.locations.map((loc) => loc.id).toList();
          } else {
            _locations =
                state.getAvailableLocations.map((loc) => loc.id).toList();
          }

          add(GetAssetsStreamEvent());
        }
      },
    );

    on<GetAssetsStreamEvent>((event, emit) async {
      if (_locations.isEmpty) {
        emit(
          AssetLoadedState(
            allAssets: const AssetsListModel(
              allAssets: [],
            ),
          ),
        );
      } else {
        emit(AssetLoadingState());
        if (_assetStreamSubscriptions.isNotEmpty) {
          // cancel old subscriptions
          for (var assetSubscription in _assetStreamSubscriptions) {
            assetSubscription?.cancel();
          }
          // clear subscriptions list
          _assetStreamSubscriptions.clear();
        }

        final List<List<String>> chunkedLocations = [];
        // chunks list size, because of DB limitations
        int chunkSize = 10;
        for (var i = 0; i < _locations.length; i += chunkSize) {
          chunkedLocations.add(
            _locations.sublist(
              i,
              i + chunkSize > _locations.length
                  ? _locations.length
                  : i + chunkSize,
            ),
          );
        }
        for (int j = 0; j < chunkedLocations.length; j++) {
          var chunk = chunkedLocations[j];
          final params = AssetsInLocationsParams(
            locations: chunk,
            companyId: _companyId,
          );

          final failureOrAssetsStream = await getAssetsStream(params);
          await failureOrAssetsStream.fold(
            (failure) async => emit(AssetErrorState(message: failure.message)),
            (assetsStream) async {
              final streamSubscription =
                  assetsStream.allAssets.listen((snapshot) {
                add(UpdateAssetsListEvent(
                  snapshot: snapshot,
                  locations: chunk,
                ));
              });
              _assetStreamSubscriptions.add(streamSubscription);
            },
          );
        }
      }
    });

    on<UpdateAssetsListEvent>((event, emit) async {
      List<Asset>? oldAssets;
      // save old instructions if this is not a first chunk
      if (state is AssetLoadedState) {
        oldAssets = (state as AssetLoadedState).allAssets.allAssets;
      }
      emit(AssetLoadingState());
      // gets instructions list
      AssetsListModel assetsList = AssetsListModel.fromSnapshot(
        event.snapshot as QuerySnapshot<Map<String, dynamic>>,
      );

      // merge instructions list if this is not a first chunk
      if (oldAssets != null) {
        List<Asset> assetsToRemove = [];
        for (var oldAsset in oldAssets) {
          if (event.locations.contains(oldAsset.locationId)) {
            assetsToRemove.add(oldAsset);
          }
        }
        for (var instructionToRemove in assetsToRemove) {
          oldAssets.remove(instructionToRemove);
        }
        // merge and sort by name
        List<Asset> tmpList = [
          ...oldAssets,
          ...assetsList.allAssets,
        ]..sort((a, b) => a.model.compareTo(b.model));

        assetsList = AssetsListModel(
          allAssets: tmpList,
        );
      }
      emit(AssetLoadedState(
        allAssets: assetsList,
      ));
    });
  }

  @override
  Future<void> close() {
    _filterStreamSubscription.cancel();
    if (_assetStreamSubscriptions.isNotEmpty) {
      for (var assetSubscription in _assetStreamSubscriptions) {
        assetSubscription?.cancel();
      }
    }
    return super.close();
  }
}
