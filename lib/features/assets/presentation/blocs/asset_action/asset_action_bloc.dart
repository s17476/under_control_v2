import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:under_control_v2/features/assets/data/models/asset_action/asset_actions_list_model.dart';
import 'package:under_control_v2/features/assets/data/models/asset_model.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_asset_actions_stream.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/get_last_five_asset_actions_stream.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

import '../../../domain/entities/asset.dart';

part 'asset_action_event.dart';
part 'asset_action_state.dart';

@injectable
class AssetActionBloc extends Bloc<AssetActionEvent, AssetActionState> {
  final GetAssetActionsStream getAssetActionsStream;
  final GetLastFiveAssetActionsStream getLastFiveAssetActionsStream;

  StreamSubscription? _assetActionsStreamSubscription;

  AssetActionBloc({
    required this.getAssetActionsStream,
    required this.getLastFiveAssetActionsStream,
  }) : super(AssetActionEmptyState()) {
    on<GetAssetActionsEvent>((event, emit) async {
      emit(AssetActionLoadingState());

      final assetParams = AssetParams(
        asset: event.asset,
        companyId: event.companyId,
      );

      final failureOrAssetActionsStream =
          await getAssetActionsStream(assetParams);
      await failureOrAssetActionsStream.fold(
        (failure) async => emit(
          AssetActionErrorState(
            message: failure.message,
          ),
        ),
        (actionsStream) async {
          _assetActionsStreamSubscription =
              actionsStream.allAssetActions.listen((snapshot) {
            add(
              UpdateAssetActionsListEvent(
                snapshot: snapshot,
                limit: 0,
              ),
            );
          });
        },
      );
    });

    on<GetLastFiveAssetActionsEvent>((event, emit) async {
      emit(AssetActionLoadingState());

      final assetParams = AssetParams(
        asset: event.asset,
        companyId: event.companyId,
      );

      final failureOrAssetActionsStream =
          await getLastFiveAssetActionsStream(assetParams);
      await failureOrAssetActionsStream.fold(
        (failure) async => emit(
          AssetActionErrorState(
            message: failure.message,
          ),
        ),
        (actionsStream) async {
          _assetActionsStreamSubscription =
              actionsStream.allAssetActions.listen((snapshot) {
            add(
              UpdateAssetActionsListEvent(
                snapshot: snapshot,
                limit: 5,
              ),
            );
          });
        },
      );
    });

    on<UpdateAssetActionsListEvent>(
      (event, emit) async {
        emit(AssetActionLoadingState());
        final assetActionsList = AssetActionsListModel.fromSnapshot(
            event.snapshot as QuerySnapshot<Map<String, dynamic>>);
        emit(
          AssetActionLoadedState(
            allActions: assetActionsList,
            isAllItems: event.limit == 0,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _assetActionsStreamSubscription?.cancel();
    return super.close();
  }
}