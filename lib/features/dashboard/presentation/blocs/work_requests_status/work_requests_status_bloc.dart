import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../../groups/domain/entities/feature.dart';
import '../../../../tasks/data/models/work_request/work_request_list_model.dart';
import '../../../../tasks/domain/entities/work_request/work_request.dart';
import '../../../domain/usecases/get_awaiting_work_requests_count.dart';
import '../../../domain/usecases/get_cancelled_work_requests_count.dart';
import '../../../domain/usecases/get_converted_work_requests_count.dart';

part 'work_requests_status_event.dart';
part 'work_requests_status_state.dart';

@singleton
class WorkRequestsStatusBloc
    extends Bloc<WorkRequestsStatusEvent, WorkRequestsStatusState> {
  final FilterBloc filterBloc;
  final GetAwaitingWorkRequestsCount getAwaitingWorkRequestsCount;
  final GetConvertedWorkRequestsCount getConvertedWorkRequestsCount;
  final GetCancelledWorkRequestsCount getCancelledWorkRequestsCount;

  late StreamSubscription _filterStreamSubscription;
  final List<StreamSubscription?> _awaitingWorkRequestStreamSubscriptions = [];
  final List<StreamSubscription?> _convertedWorkRequestStreamSubscriptions = [];
  final List<StreamSubscription?> _cancelledWorkRequestStreamSubscriptions = [];

  String _companyId = '';
  List<String> _locations = [];

  WorkRequestsStatusBloc({
    required this.filterBloc,
    required this.getAwaitingWorkRequestsCount,
    required this.getConvertedWorkRequestsCount,
    required this.getCancelledWorkRequestsCount,
  }) : super(WorkRequestsStatusEmptyState()) {
    _filterStreamSubscription = filterBloc.stream.listen(
      (state) {
        if (state is FilterLoadedState) {
          // _clearSubscriptions();
          _companyId = state.companyId;
          if (state.isAdmin && state.groups.isEmpty) {
            _locations = state.locations.map((loc) => loc.id).toList();
          } else {
            _locations = state
                .getAvailableLocations(FeatureType.tasks)
                .map((loc) => loc.id)
                .toList();
          }

          add(GetWorkRequestsStatusEvent());
        }
      },
    );

    on<GetWorkRequestsStatusEvent>((event, emit) async {
      if (_locations.isEmpty) {
        emit(WorkRequestsStatusLoadedState());
      } else {
        emit(WorkRequestsStatusLoadingState());
        _clearSubscriptions();

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

          // awaiting
          final failureOrAwaitingWorkRequestsStream =
              await getAwaitingWorkRequestsCount(params);
          await failureOrAwaitingWorkRequestsStream.fold(
            (failure) async =>
                emit(WorkRequestsStatusErrorState(message: failure.message)),
            (stream) async {
              final streamSubscription =
                  stream.allWorkRequests.listen((snapshot) {
                add(UpdateAwaitingStatusEvent(
                  snapshot: snapshot,
                  locations: chunk,
                ));
              });
              _awaitingWorkRequestStreamSubscriptions.add(streamSubscription);
            },
          );
          // converted
          final failureOrConvertedWorkRequestsStream =
              await getConvertedWorkRequestsCount(params);
          await failureOrConvertedWorkRequestsStream.fold(
            (failure) async {
              emit(WorkRequestsStatusErrorState(message: failure.message));
            },
            (stream) async {
              final streamSubscription =
                  stream.allWorkRequests.listen((snapshot) {
                add(UpdateConvertedStatusEvent(
                  snapshot: snapshot,
                  locations: chunk,
                ));
              });
              _convertedWorkRequestStreamSubscriptions.add(streamSubscription);
            },
          );
          // cancelled
          final failureOrCancelledWorkRequestsStream =
              await getCancelledWorkRequestsCount(params);
          await failureOrCancelledWorkRequestsStream.fold(
            (failure) async =>
                emit(WorkRequestsStatusErrorState(message: failure.message)),
            (stream) async {
              final streamSubscription =
                  stream.allWorkRequests.listen((snapshot) {
                add(UpdateCancelledStatusEvent(
                  snapshot: snapshot,
                  locations: chunk,
                ));
              });
              _cancelledWorkRequestStreamSubscriptions.add(streamSubscription);
            },
          );
        }
      }
    });

    on<UpdateAwaitingStatusEvent>((event, emit) async {
      List<WorkRequest>? oldWorkRequests;
      WorkRequestsStatusLoadedState? oldState;
      // save old work orders if this is not a first chunk
      if (state is WorkRequestsStatusLoadedState) {
        oldState = state as WorkRequestsStatusLoadedState;
        oldWorkRequests =
            (state as WorkRequestsStatusLoadedState).awaiting.allWorkRequests;
      }
      emit(WorkRequestsStatusLoadingState());
      // gets work orders list
      WorkRequestsListModel workRequestsList =
          WorkRequestsListModel.fromSnapshot(
        event.snapshot as QuerySnapshot<Map<String, dynamic>>,
      );

      // merge work orders list if this is not a first chunk
      if (oldWorkRequests != null) {
        List<WorkRequest> workRequestsToRemove = [];
        for (var oldWorkRequest in oldWorkRequests) {
          if (event.locations.contains(oldWorkRequest.locationId)) {
            workRequestsToRemove.add(oldWorkRequest);
          }
        }
        for (var workRequestToRemove in workRequestsToRemove) {
          oldWorkRequests.remove(workRequestToRemove);
        }
        // merge and sort by date
        List<WorkRequest> tmpList = [
          ...oldWorkRequests,
          ...workRequestsList.allWorkRequests,
        ]..sort((a, b) => a.date.compareTo(b.date));

        workRequestsList = WorkRequestsListModel(
          allWorkRequests: tmpList,
        );
      }
      emit(
        oldState?.copyWith(awaiting: workRequestsList) ??
            WorkRequestsStatusLoadedState(awaiting: workRequestsList),
      );
    });

    on<UpdateConvertedStatusEvent>((event, emit) async {
      List<WorkRequest>? oldWorkRequests;
      WorkRequestsStatusLoadedState? oldState;
      // save old work orders if this is not a first chunk
      if (state is WorkRequestsStatusLoadedState) {
        oldState = state as WorkRequestsStatusLoadedState;
        oldWorkRequests =
            (state as WorkRequestsStatusLoadedState).converted.allWorkRequests;
      }
      emit(WorkRequestsStatusLoadingState());
      // gets work orders list
      WorkRequestsListModel workRequestsList =
          WorkRequestsListModel.fromSnapshot(
        event.snapshot as QuerySnapshot<Map<String, dynamic>>,
      );

      // merge work orders list if this is not a first chunk
      if (oldWorkRequests != null) {
        List<WorkRequest> workRequestsToRemove = [];
        for (var oldWorkRequest in oldWorkRequests) {
          if (event.locations.contains(oldWorkRequest.locationId)) {
            workRequestsToRemove.add(oldWorkRequest);
          }
        }
        for (var workRequestToRemove in workRequestsToRemove) {
          oldWorkRequests.remove(workRequestToRemove);
        }
        // merge and sort by date
        List<WorkRequest> tmpList = [
          ...oldWorkRequests,
          ...workRequestsList.allWorkRequests
              .where((element) => element.taskId.isNotEmpty),
        ]..sort((a, b) => a.date.compareTo(b.date));

        workRequestsList = WorkRequestsListModel(
          allWorkRequests: tmpList,
        );
      }
      emit(
        oldState?.copyWith(converted: workRequestsList) ??
            WorkRequestsStatusLoadedState(converted: workRequestsList),
      );
    });

    on<UpdateCancelledStatusEvent>((event, emit) async {
      List<WorkRequest>? oldWorkRequests;
      WorkRequestsStatusLoadedState? oldState;
      // save old work orders if this is not a first chunk
      if (state is WorkRequestsStatusLoadedState) {
        oldState = state as WorkRequestsStatusLoadedState;
        oldWorkRequests =
            (state as WorkRequestsStatusLoadedState).cancelled.allWorkRequests;
      }
      emit(WorkRequestsStatusLoadingState());
      // gets work orders list
      WorkRequestsListModel workRequestsList =
          WorkRequestsListModel.fromSnapshot(
        event.snapshot as QuerySnapshot<Map<String, dynamic>>,
      );

      // merge work orders list if this is not a first chunk
      if (oldWorkRequests != null) {
        List<WorkRequest> workRequestsToRemove = [];
        for (var oldWorkRequest in oldWorkRequests) {
          if (event.locations.contains(oldWorkRequest.locationId)) {
            workRequestsToRemove.add(oldWorkRequest);
          }
        }
        for (var workRequestToRemove in workRequestsToRemove) {
          oldWorkRequests.remove(workRequestToRemove);
        }
        // merge and sort by date
        List<WorkRequest> tmpList = [
          ...oldWorkRequests,
          ...workRequestsList.allWorkRequests,
        ]..sort((a, b) => a.date.compareTo(b.date));

        workRequestsList = WorkRequestsListModel(
          allWorkRequests: tmpList,
        );
      }
      emit(
        oldState?.copyWith(cancelled: workRequestsList) ??
            WorkRequestsStatusLoadedState(cancelled: workRequestsList),
      );
    });
  }

  void _clearSubscriptions() {
    if (_awaitingWorkRequestStreamSubscriptions.isNotEmpty) {
      for (var subscription in _awaitingWorkRequestStreamSubscriptions) {
        subscription?.cancel();
      }
      _awaitingWorkRequestStreamSubscriptions.clear();
    }
    if (_cancelledWorkRequestStreamSubscriptions.isNotEmpty) {
      for (var subscription in _cancelledWorkRequestStreamSubscriptions) {
        subscription?.cancel();
      }
      _cancelledWorkRequestStreamSubscriptions.clear();
    }
    if (_convertedWorkRequestStreamSubscriptions.isNotEmpty) {
      for (var subscription in _convertedWorkRequestStreamSubscriptions) {
        subscription?.cancel();
      }
      _convertedWorkRequestStreamSubscriptions.clear();
    }
  }

  @override
  Future<void> close() {
    _filterStreamSubscription.cancel();
    if (_awaitingWorkRequestStreamSubscriptions.isNotEmpty) {
      for (var subscription in _awaitingWorkRequestStreamSubscriptions) {
        subscription?.cancel();
      }
    }
    if (_cancelledWorkRequestStreamSubscriptions.isNotEmpty) {
      for (var subscription in _cancelledWorkRequestStreamSubscriptions) {
        subscription?.cancel();
      }
    }
    if (_convertedWorkRequestStreamSubscriptions.isNotEmpty) {
      for (var subscription in _convertedWorkRequestStreamSubscriptions) {
        subscription?.cancel();
      }
    }
    return super.close();
  }
}
