import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../data/models/asset_action/asset_actions_list_model.dart';
import '../../../domain/entities/asset_action/asset_action.dart';
import '../../../domain/usecases/asset_action/get_dashboard_asset_actions_stream.dart';
import '../../../domain/usecases/asset_action/get_dashboard_last_five_asset_actions_stream.dart';

part 'dashboard_asset_action_event.dart';
part 'dashboard_asset_action_state.dart';

@injectable
class DashboardAssetActionBloc
    extends Bloc<DashboardAssetActionEvent, DashboardAssetActionState> {
  final FilterBloc filterBloc;
  final GetDashboardAssetActionsStream getDashboardAssetActionsStream;
  final GetDashboardLastFiveAssetActionsStream
      getDashboardLastFiveAssetActionsStream;

  late StreamSubscription _filterStreamSubscription;
  final List<StreamSubscription?> _actionStreamSubscriptions = [];

  String _companyId = '';
  List<String> _locations = [];

  DashboardAssetActionBloc({
    required this.filterBloc,
    required this.getDashboardAssetActionsStream,
    required this.getDashboardLastFiveAssetActionsStream,
  }) : super(DashboardAssetActionEmptyState()) {
    _filterStreamSubscription = filterBloc.stream.listen(
      (state) {
        if (state is FilterLoadedState) {
          if (_actionStreamSubscriptions.isNotEmpty) {
            // cancel old subscriptions
            for (var actionSubscription in _actionStreamSubscriptions) {
              actionSubscription?.cancel();
            }
            // clear subscriptions list
            _actionStreamSubscriptions.clear();
          }

          _companyId = state.companyId;
          _locations = state.locations.map((loc) => loc.id).toList();
          // gets latest five actions
          add(GetDashboardLastFiveAssetActionsEvent());
        }
      },
    );

    on<GetDashboardAssetActionsEvent>((event, emit) async {
      // avoids loading same data multiple times
      // TODO
      //  != ??
      if (filterBloc.state is FilterLoadedState &&
          _locations !=
              filterBloc.state.locations.map((loc) => loc.id).toList() &&
          state is DashboardAssetActionLoadedState &&
          (state as DashboardAssetActionLoadedState)
                  .allActions
                  .allAssetActions
                  .length >
              5) {
        return;
        // gets updated data
      } else {
        if (_locations.isEmpty) {
          emit(
            DashboardAssetActionLoadedState(
              allActions: const AssetActionsListModel(
                allAssetActions: [],
              ),
            ),
          );
        } else {
          emit(DashboardAssetActionLoadingState());
          if (_actionStreamSubscriptions.isNotEmpty) {
            // cancel old subscriptions
            for (var actionSubscription in _actionStreamSubscriptions) {
              actionSubscription?.cancel();
            }
            // clear subscriptions list
            _actionStreamSubscriptions.clear();
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
            final params =
                ItemsInLocationsParams(locations: chunk, companyId: _companyId);
            final failureOrItemActionsStream =
                await getDashboardAssetActionsStream(params);
            await failureOrItemActionsStream.fold(
              (failure) async => emit(
                  DashboardAssetActionErrorState(message: failure.message)),
              (actionsStream) async {
                final streamSubscription =
                    actionsStream.allAssetActions.listen((snapshot) {
                  add(UpdateDashboardAssetActionsListEvent(
                    snapshot: snapshot,
                    limit: 0,
                  ));
                });
                _actionStreamSubscriptions.add(streamSubscription);
              },
            );
          }
        }
      }
    });

    on<GetDashboardLastFiveAssetActionsEvent>((event, emit) async {
      if (_locations.isEmpty) {
        emit(
          DashboardAssetActionLoadedState(
            allActions: const AssetActionsListModel(
              allAssetActions: [],
            ),
          ),
        );
      } else {
        emit(DashboardAssetActionLoadingState());
        if (_actionStreamSubscriptions.isNotEmpty) {
          // cancel old subscriptions
          for (var actionSubscription in _actionStreamSubscriptions) {
            actionSubscription?.cancel();
          }
          // clear subscriptions list
          _actionStreamSubscriptions.clear();
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
          final params =
              ItemsInLocationsParams(locations: chunk, companyId: _companyId);
          final failureOrItemActionsStream =
              await getDashboardLastFiveAssetActionsStream(params);
          await failureOrItemActionsStream.fold(
            (failure) async =>
                emit(DashboardAssetActionErrorState(message: failure.message)),
            (actionsStream) async {
              final streamSubscription =
                  actionsStream.allAssetActions.listen((snapshot) {
                add(
                  UpdateDashboardAssetActionsListEvent(
                    snapshot: snapshot,
                    limit: 5,
                  ),
                );
              });
              _actionStreamSubscriptions.add(streamSubscription);
            },
          );
        }
      }
    });

    on<UpdateDashboardAssetActionsListEvent>(
      (event, emit) async {
        List<AssetAction>? oldAssetActions;
        // save old actions if this is not a first chunk
        if (state is DashboardAssetActionLoadedState) {
          oldAssetActions = (state as DashboardAssetActionLoadedState)
              .allActions
              .allAssetActions;
        }
        emit(DashboardAssetActionLoadingState());
        // gets actions list
        AssetActionsListModel assetActionsList =
            AssetActionsListModel.fromSnapshot(
                event.snapshot as QuerySnapshot<Map<String, dynamic>>);
        // merge actions list if this is not a first chunk
        if (oldAssetActions != null) {
          for (var action in assetActionsList.allAssetActions) {
            final index = oldAssetActions.indexOf(action);
            if (index >= 0) {
              oldAssetActions.removeAt(index);
            }
          }
          // merge and sort by date
          List<AssetAction> tmpList = [
            ...oldAssetActions,
            ...assetActionsList.allAssetActions,
          ]..sort((a, b) => b.dateTime.compareTo(a.dateTime));
          // limit list
          // TODO
          if (event.limit > 0 && tmpList.length > event.limit) {
            tmpList = tmpList.sublist(0, event.limit);
          }
          assetActionsList = AssetActionsListModel(
            allAssetActions: tmpList,
          );
        }
        emit(DashboardAssetActionLoadedState(
          allActions: assetActionsList,
          isAllItems: event.limit == 0,
        ));
      },
    );
  }

  @override
  Future<void> close() {
    _filterStreamSubscription.cancel();
    if (_actionStreamSubscriptions.isNotEmpty) {
      for (var actionSubscription in _actionStreamSubscriptions) {
        actionSubscription?.cancel();
      }
    }
    return super.close();
  }
}
