import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';

import '../../../data/models/asset_action/asset_actions_list_model.dart';
import '../../../data/models/asset_model.dart';
import '../../../domain/usecases/asset_action/get_asset_actions_stream.dart';
import '../../../domain/usecases/asset_action/get_last_five_asset_actions_stream.dart';
import '../../../../core/usecases/usecase.dart';

part 'asset_action_event.dart';
part 'asset_action_state.dart';

@injectable
class AssetActionBloc extends Bloc<AssetActionEvent, AssetActionState> {
  final AuthenticationBloc authenticationBloc;
  final GetAssetActionsStream getAssetActionsStream;
  final GetLastFiveAssetActionsStream getLastFiveAssetActionsStream;

  late StreamSubscription _authStreamSubscription;

  StreamSubscription? _assetActionsStreamSubscription;

  AssetActionBloc({
    required this.authenticationBloc,
    required this.getAssetActionsStream,
    required this.getLastFiveAssetActionsStream,
  }) : super(AssetActionEmptyState()) {
    _authStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {
        add(ResetEvent());
      }
    });

    on<ResetEvent>(
      (event, emit) {
        _assetActionsStreamSubscription?.cancel();
        emit(AssetActionEmptyState());
      },
    );

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
    _authStreamSubscription.cancel();
    _assetActionsStreamSubscription?.cancel();
    return super.close();
  }
}
