import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../data/models/work_request/work_request_list_model.dart';
import '../../../domain/entities/work_request/work_request.dart';
import '../../../domain/usecases/work_order/get_work_requests_stream.dart';

part 'work_request_event.dart';
part 'work_request_state.dart';

@injectable
class WorkRequestBloc extends Bloc<WorkRequestEvent, WorkRequestState> {
  final FilterBloc filterBloc;
  final GetWorkRequestsStream getWorkRequestsStream;

  late StreamSubscription _filterStreamSubscription;
  final List<StreamSubscription?> _workRequestStreamSubscriptions = [];

  String _companyId = '';
  List<String> _locations = [];

  WorkRequestBloc({
    required this.filterBloc,
    required this.getWorkRequestsStream,
  }) : super(WorkRequestEmptyState()) {
    _filterStreamSubscription = filterBloc.stream.listen(
      (state) {
        if (state is FilterLoadedState) {
          if (_workRequestStreamSubscriptions.isNotEmpty) {
            // cancel old subscriptions
            for (var workRequestSubscription
                in _workRequestStreamSubscriptions) {
              workRequestSubscription?.cancel();
            }
            // clear subscriptions list
            _workRequestStreamSubscriptions.clear();
          }

          _companyId = state.companyId;
          if (state.isAdmin && state.groups.isEmpty) {
            _locations = state.locations.map((loc) => loc.id).toList();
          } else {
            _locations =
                state.getAvailableLocations.map((loc) => loc.id).toList();
          }

          add(GetWorkRequestsStreamEvent());
        }
      },
    );

    on<GetWorkRequestsStreamEvent>((event, emit) async {
      if (_locations.isEmpty) {
        emit(
          WorkRequestLoadedState(
            allWorkRequests: const WorkRequestsListModel(
              allWorkRequests: [],
            ),
          ),
        );
      } else {
        emit(WorkRequestLoadingState());
        if (_workRequestStreamSubscriptions.isNotEmpty) {
          // cancel old subscriptions
          for (var workRequestSubscription in _workRequestStreamSubscriptions) {
            workRequestSubscription?.cancel();
          }
          // clear subscriptions list
          _workRequestStreamSubscriptions.clear();
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

          final failureOrWorkRequestsStream =
              await getWorkRequestsStream(params);
          await failureOrWorkRequestsStream.fold(
            (failure) async =>
                emit(WorkRequestErrorState(message: failure.message)),
            (assetsStream) async {
              final streamSubscription =
                  assetsStream.allWorkRequests.listen((snapshot) {
                add(UpdateWorkRequestsListEvent(
                  snapshot: snapshot,
                  locations: chunk,
                ));
              });
              _workRequestStreamSubscriptions.add(streamSubscription);
            },
          );
        }
      }
    });

    on<UpdateWorkRequestsListEvent>((event, emit) async {
      List<WorkRequest>? oldWorkRequests;
      // save old work orders if this is not a first chunk
      if (state is WorkRequestLoadedState) {
        oldWorkRequests =
            (state as WorkRequestLoadedState).allWorkRequests.allWorkRequests;
      }
      emit(WorkRequestLoadingState());
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
        // merge and sort by priority
        List<WorkRequest> tmpList = [
          ...oldWorkRequests,
          ...workRequestsList.allWorkRequests,
        ]..sort((a, b) => a.date.compareTo(b.date));

        workRequestsList = WorkRequestsListModel(
          allWorkRequests: tmpList,
        );
      }
      emit(WorkRequestLoadedState(
        allWorkRequests: workRequestsList,
      ));
    });
  }

  @override
  Future<void> close() {
    _filterStreamSubscription.cancel();
    if (_workRequestStreamSubscriptions.isNotEmpty) {
      for (var assetSubscription in _workRequestStreamSubscriptions) {
        assetSubscription?.cancel();
      }
    }
    return super.close();
  }
}
