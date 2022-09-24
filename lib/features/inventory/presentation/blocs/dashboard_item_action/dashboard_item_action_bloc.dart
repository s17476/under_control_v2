import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../data/models/item_action/item_actions_list_model.dart';
import '../../../domain/entities/item_action/item_action.dart';
import '../../../domain/usecases/item_action/get_dashboard_item_actions_stream.dart';
import '../../../domain/usecases/item_action/get_dashboard_last_five_item_actions_stream.dart';

part 'dashboard_item_action_event.dart';
part 'dashboard_item_action_state.dart';

@injectable
class DashboardItemActionBloc
    extends Bloc<DashboardItemActionEvent, DashboardItemActionState> {
  final FilterBloc filterBloc;
  final GetDashboardItemsActionsStream getDashboardItemsActionsStream;
  final GetDashboardLastFiveItemsActionsStream
      getDashboardLastFiveItemsActionsStream;
  late StreamSubscription filterStreamSubscription;
  List<StreamSubscription?> actionStreamSubscriptions = [];

  String companyId = '';
  List<String> locations = [];

  DashboardItemActionBloc({
    required this.filterBloc,
    required this.getDashboardItemsActionsStream,
    required this.getDashboardLastFiveItemsActionsStream,
  }) : super(DashboardItemActionEmptyState()) {
    filterStreamSubscription = filterBloc.stream.listen(
      (state) {
        if (state is FilterLoadedState) {
          if (actionStreamSubscriptions.isNotEmpty) {
            // cancel old subscriptions
            for (var actionSubscription in actionStreamSubscriptions) {
              actionSubscription?.cancel();
            }
            // clear subscriptions list
            actionStreamSubscriptions.clear();
          }

          companyId = state.companyId;
          locations = state.locations.map((loc) => loc.id).toList();
          // gets latest five actions
          add(GetDashboardLastFiveItemActionsEvent());
        }
      },
    );

    on<GetDashboardItemActionsEvent>((event, emit) async {
      // avoids loading same data multiple times
      if (filterBloc.state is FilterLoadedState &&
          locations !=
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
        if (locations.isEmpty) {
          emit(
            DashboardItemActionLoadedState(
              allActions: const ItemActionsListModel(
                allItemActions: [],
              ),
            ),
          );
        } else {
          emit(DashboardItemActionLoadingState());
          if (actionStreamSubscriptions.isNotEmpty) {
            // cancel old subscriptions
            for (var actionSubscription in actionStreamSubscriptions) {
              actionSubscription?.cancel();
            }
            // clear subscriptions list
            actionStreamSubscriptions.clear();
          }

          final List<List<String>> chunkedLocations = [];
          // chunks list size, because of DB limitations
          int chunkSize = 10;
          for (var i = 0; i < locations.length; i += chunkSize) {
            chunkedLocations.add(
              locations.sublist(
                i,
                i + chunkSize > locations.length
                    ? locations.length
                    : i + chunkSize,
              ),
            );
          }
          for (int j = 0; j < chunkedLocations.length; j++) {
            var chunk = chunkedLocations[j];
            final params =
                ItemsInLocationsParams(locations: chunk, companyId: companyId);
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
                actionStreamSubscriptions.add(streamSubscription);
              },
            );
          }
        }
      }
    });

    on<GetDashboardLastFiveItemActionsEvent>((event, emit) async {
      if (locations.isEmpty) {
        emit(
          DashboardItemActionLoadedState(
            allActions: const ItemActionsListModel(
              allItemActions: [],
            ),
          ),
        );
      } else {
        emit(DashboardItemActionLoadingState());
        if (actionStreamSubscriptions.isNotEmpty) {
          // cancel old subscriptions
          for (var actionSubscription in actionStreamSubscriptions) {
            actionSubscription?.cancel();
          }
          // clear subscriptions list
          actionStreamSubscriptions.clear();
        }

        final List<List<String>> chunkedLocations = [];
        // chunks list size, because of DB limitations
        int chunkSize = 10;
        for (var i = 0; i < locations.length; i += chunkSize) {
          chunkedLocations.add(
            locations.sublist(
              i,
              i + chunkSize > locations.length
                  ? locations.length
                  : i + chunkSize,
            ),
          );
        }
        for (int j = 0; j < chunkedLocations.length; j++) {
          var chunk = chunkedLocations[j];
          final params =
              ItemsInLocationsParams(locations: chunk, companyId: companyId);
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
              actionStreamSubscriptions.add(streamSubscription);
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
          // TODO
          if (event.limit > 0 && tmpList.length > event.limit) {
            tmpList = tmpList.sublist(0, event.limit);
          }
          itemActionsList = ItemActionsListModel(
            allItemActions: tmpList,
          );
        }
        emit(DashboardItemActionLoadedState(allActions: itemActionsList));
      },
    );
  }

  @override
  Future<void> close() {
    filterStreamSubscription.cancel();
    if (actionStreamSubscriptions.isNotEmpty) {
      for (var actionSubscription in actionStreamSubscriptions) {
        actionSubscription?.cancel();
      }
    }
    return super.close();
  }
}
