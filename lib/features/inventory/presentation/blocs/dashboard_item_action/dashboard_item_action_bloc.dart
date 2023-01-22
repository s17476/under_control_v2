import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../data/models/item_action/item_actions_list_model.dart';
import '../../../domain/entities/item_action/item_action.dart';
import '../../../domain/usecases/item_action/get_dashboard_item_actions_stream.dart';
import '../../../domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart';

part 'dashboard_item_action_event.dart';
part 'dashboard_item_action_state.dart';

@singleton
class DashboardItemActionBloc
    extends Bloc<DashboardItemActionEvent, DashboardItemActionState> {
  final AuthenticationBloc authenticationBloc;
  final FilterBloc filterBloc;
  final GetDashboardItemsActionsStream getDashboardItemsActionsStream;
  final GetDashboardLastFiveItemsActionsStream
      getDashboardLastFiveItemsActionsStream;

  late StreamSubscription _authStreamSubscription;
  late StreamSubscription _filterStreamSubscription;
  final List<StreamSubscription?> _actionStreamSubscriptions = [];

  String _companyId = '';
  List<String> _locations = [];

  DashboardItemActionBloc({
    required this.authenticationBloc,
    required this.filterBloc,
    required this.getDashboardItemsActionsStream,
    required this.getDashboardLastFiveItemsActionsStream,
  }) : super(DashboardItemActionEmptyState()) {
    _authStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {}
      add(ResetEvent());
    });
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
          add(GetDashboardLastFiveItemActionsEvent());
        }
      },
    );

    on<ResetEvent>(
      (event, emit) {
        _companyId = '';
        _locations = [];
        if (_actionStreamSubscriptions.isNotEmpty) {
          for (var actionSubscription in _actionStreamSubscriptions) {
            actionSubscription?.cancel();
          }
        }
        _actionStreamSubscriptions.clear();
        emit(DashboardItemActionEmptyState());
      },
    );

    on<GetDashboardItemActionsEvent>((event, emit) async {
      // avoids loading same data multiple times
      if (filterBloc.state is FilterLoadedState &&
          _locations !=
              filterBloc.state.locations.map((loc) => loc.id).toList() &&
          state is DashboardItemActionLoadedState &&
          (state as DashboardItemActionLoadedState)
                  .allActions
                  .allItemActions
                  .length >
              5) {
        return;
        // gets updated data
      } else {
        if (_locations.isEmpty) {
          emit(
            DashboardItemActionLoadedState(
              allActions: const ItemActionsListModel(
                allItemActions: [],
              ),
            ),
          );
        } else {
          emit(DashboardItemActionLoadingState());
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
                await getDashboardItemsActionsStream(params);
            await failureOrItemActionsStream.fold(
              (failure) async =>
                  emit(DashboardItemActionErrorState(message: failure.message)),
              (actionsStream) async {
                final streamSubscription =
                    actionsStream.allItemActions.listen((snapshot) {
                  add(UpdateDashboardItemActionsListEvent(
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

    on<GetDashboardLastFiveItemActionsEvent>((event, emit) async {
      if (_locations.isEmpty) {
        emit(
          DashboardItemActionLoadedState(
            allActions: const ItemActionsListModel(
              allItemActions: [],
            ),
          ),
        );
      } else {
        emit(DashboardItemActionLoadingState());
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
              await getDashboardLastFiveItemsActionsStream(params);
          await failureOrItemActionsStream.fold(
            (failure) async =>
                emit(DashboardItemActionErrorState(message: failure.message)),
            (actionsStream) async {
              final streamSubscription =
                  actionsStream.allItemActions.listen((snapshot) {
                add(
                  UpdateDashboardItemActionsListEvent(
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

    on<UpdateDashboardItemActionsListEvent>(
      (event, emit) async {
        List<ItemAction>? oldItemActions;
        // save old actions if this is not a first chunk
        if (state is DashboardItemActionLoadedState) {
          oldItemActions = (state as DashboardItemActionLoadedState)
              .allActions
              .allItemActions;
        }
        emit(DashboardItemActionLoadingState());
        // gets actions list
        ItemActionsListModel itemActionsList =
            ItemActionsListModel.fromSnapshot(
                event.snapshot as QuerySnapshot<Map<String, dynamic>>);
        // merge actions list if this is not a first chunk
        if (oldItemActions != null) {
          for (var action in itemActionsList.allItemActions) {
            final index = oldItemActions.indexOf(action);
            if (index >= 0) {
              oldItemActions.removeAt(index);
            }
          }
          // merge and sort by date
          List<ItemAction> tmpList = [
            ...oldItemActions,
            ...itemActionsList.allItemActions,
          ]..sort((a, b) => b.date.compareTo(a.date));
          // limit list
          if (event.limit > 0 && tmpList.length > event.limit) {
            tmpList = tmpList.sublist(0, event.limit);
          }
          itemActionsList = ItemActionsListModel(
            allItemActions: tmpList,
          );
        }
        emit(DashboardItemActionLoadedState(
          allActions: itemActionsList,
          isAllItems: event.limit == 0,
        ));
      },
    );
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    _filterStreamSubscription.cancel();
    if (_actionStreamSubscriptions.isNotEmpty) {
      for (var actionSubscription in _actionStreamSubscriptions) {
        actionSubscription?.cancel();
      }
    }
    return super.close();
  }
}
