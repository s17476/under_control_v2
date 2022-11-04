import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../data/models/work_order/work_order_list_model.dart';
import '../../../domain/entities/work_order/work_order.dart';
import '../../../domain/usecases/work_order/get_archive_work_orders_stream.dart';

part 'work_order_archive_event.dart';
part 'work_order_archive_state.dart';

@injectable
class WorkOrderArchiveBloc
    extends Bloc<WorkOrderArchiveEvent, WorkOrderArchiveState> {
  final FilterBloc filterBloc;
  final GetArchiveWorkOrdersStream getArchiveWorkOrdersStream;

  late StreamSubscription _filterStreamSubscription;
  final List<StreamSubscription?> _workOrderStreamSubscriptions = [];

  String _companyId = '';
  List<String> _locations = [];

  WorkOrderArchiveBloc({
    required this.filterBloc,
    required this.getArchiveWorkOrdersStream,
  }) : super(WorkOrderArchiveEmptyState()) {
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

          add(GetWorkOrdersArchiveStreamEvent());
        }
      },
    );

    on<GetWorkOrdersArchiveStreamEvent>((event, emit) async {
      if (_locations.isEmpty) {
        emit(
          WorkOrderArchiveLoadedState(
            allWorkOrders: const WorkOrdersListModel(
              allWorkOrders: [],
            ),
          ),
        );
      } else {
        emit(WorkOrderArchiveLoadingState());
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

          final failureOrWorkOrdersStream =
              await getArchiveWorkOrdersStream(params);
          await failureOrWorkOrdersStream.fold(
            (failure) async =>
                emit(WorkOrderArchiveErrorState(message: failure.message)),
            (assetsStream) async {
              final streamSubscription =
                  assetsStream.allWorkOrders.listen((snapshot) {
                add(UpdateWorkOrdersArchiveListEvent(
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

    on<UpdateWorkOrdersArchiveListEvent>((event, emit) async {
      List<WorkOrder>? oldWorkOrders;
      // save old work orders if this is not a first chunk
      if (state is WorkOrderArchiveLoadedState) {
        oldWorkOrders =
            (state as WorkOrderArchiveLoadedState).allWorkOrders.allWorkOrders;
      }
      emit(WorkOrderArchiveLoadingState());
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
      emit(WorkOrderArchiveLoadedState(
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
