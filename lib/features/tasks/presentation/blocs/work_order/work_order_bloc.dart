import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../data/models/work_order/work_order_list_model.dart';
import '../../../domain/entities/work_order/work_order.dart';
import '../../../domain/usecases/work_order/get_work_orders_stream.dart';

part 'work_order_event.dart';
part 'work_order_state.dart';

@injectable
class WorkOrderBloc extends Bloc<WorkOrderEvent, WorkOrderState> {
  final FilterBloc filterBloc;
  final GetWorkOrdersStream getWorkOrdersStream;

  late StreamSubscription _filterStreamSubscription;
  final List<StreamSubscription?> _workOrderStreamSubscriptions = [];

  String _companyId = '';
  List<String> _locations = [];

  WorkOrderBloc({
    required this.filterBloc,
    required this.getWorkOrdersStream,
  }) : super(WorkOrderEmptyState()) {
    _filterStreamSubscription = filterBloc.stream.listen(
      (state) {
        if (state is FilterLoadedState) {
          if (_workOrderStreamSubscriptions.isNotEmpty) {
            // cancel old subscriptions
            for (var workOrderSubscription in _workOrderStreamSubscriptions) {
              workOrderSubscription?.cancel();
            }
            // clear subscriptions list
            _workOrderStreamSubscriptions.clear();
          }

          _companyId = state.companyId;
          if (state.isAdmin && state.groups.isEmpty) {
            _locations = state.locations.map((loc) => loc.id).toList();
          } else {
            _locations =
                state.getAvailableLocations.map((loc) => loc.id).toList();
          }

          add(GetWorkOrdersStreamEvent());
        }
      },
    );

    on<GetWorkOrdersStreamEvent>((event, emit) async {
      if (_locations.isEmpty) {
        emit(
          WorkOrderLoadedState(
            allWorkOrders: const WorkOrdersListModel(
              allWorkOrders: [],
            ),
          ),
        );
      } else {
        emit(WorkOrderLoadingState());
        if (_workOrderStreamSubscriptions.isNotEmpty) {
          // cancel old subscriptions
          for (var workOrderSubscription in _workOrderStreamSubscriptions) {
            workOrderSubscription?.cancel();
          }
          // clear subscriptions list
          _workOrderStreamSubscriptions.clear();
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
          final params = ItemsInLocationsParams(
            locations: chunk,
            companyId: _companyId,
          );

          final failureOrWorkOrdersStream = await getWorkOrdersStream(params);
          await failureOrWorkOrdersStream.fold(
            (failure) async =>
                emit(WorkOrderErrorState(message: failure.message)),
            (assetsStream) async {
              final streamSubscription =
                  assetsStream.allWorkOrders.listen((snapshot) {
                add(UpdateWorkOrdersListEvent(
                  snapshot: snapshot,
                  locations: chunk,
                ));
              });
              _workOrderStreamSubscriptions.add(streamSubscription);
            },
          );
        }
      }
    });

    on<UpdateWorkOrdersListEvent>((event, emit) async {
      List<WorkOrder>? oldWorkOrders;
      // save old work orders if this is not a first chunk
      if (state is WorkOrderLoadedState) {
        oldWorkOrders =
            (state as WorkOrderLoadedState).allWorkOrders.allWorkOrders;
      }
      emit(WorkOrderLoadingState());
      // gets work orders list
      WorkOrdersListModel workOrdersList = WorkOrdersListModel.fromSnapshot(
        event.snapshot as QuerySnapshot<Map<String, dynamic>>,
      );

      // merge work orders list if this is not a first chunk
      if (oldWorkOrders != null) {
        List<WorkOrder> workOrdersToRemove = [];
        for (var oldWorkOrder in oldWorkOrders) {
          if (event.locations.contains(oldWorkOrder.locationId)) {
            workOrdersToRemove.add(oldWorkOrder);
          }
        }
        for (var workOrderToRemove in workOrdersToRemove) {
          oldWorkOrders.remove(workOrderToRemove);
        }
        // merge and sort by priority
        List<WorkOrder> tmpList = [
          ...oldWorkOrders,
          ...workOrdersList.allWorkOrders,
        ]..sort((a, b) => a.date.compareTo(b.date));

        workOrdersList = WorkOrdersListModel(
          allWorkOrders: tmpList,
        );
      }
      emit(WorkOrderLoadedState(
        allWorkOrders: workOrdersList,
      ));
    });
  }

  @override
  Future<void> close() {
    _filterStreamSubscription.cancel();
    if (_workOrderStreamSubscriptions.isNotEmpty) {
      for (var assetSubscription in _workOrderStreamSubscriptions) {
        assetSubscription?.cancel();
      }
    }
    return super.close();
  }
}
