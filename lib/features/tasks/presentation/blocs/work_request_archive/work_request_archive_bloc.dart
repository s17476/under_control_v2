import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../data/models/work_request/work_request_list_model.dart';
import '../../../domain/entities/work_request/work_request.dart';
import '../../../domain/usecases/work_order/get_archive_work_requests_stream.dart';

part 'work_request_archive_event.dart';
part 'work_request_archive_state.dart';

@injectable
class WorkRequestArchiveBloc
    extends Bloc<WorkRequestArchiveEvent, WorkRequestArchiveState> {
  final FilterBloc filterBloc;
  final GetArchiveWorkRequestsStream getArchiveWorkRequestsStream;

  late StreamSubscription _filterStreamSubscription;
  final List<StreamSubscription?> _workRequestArchiveStreamSubscriptions = [];

  String _companyId = '';
  List<String> _locations = [];

  WorkRequestArchiveBloc({
    required this.filterBloc,
    required this.getArchiveWorkRequestsStream,
  }) : super(WorkRequestArchiveEmptyState()) {
    _filterStreamSubscription = filterBloc.stream.listen(
      (state) {
        if (state is FilterLoadedState) {
          if (_workRequestArchiveStreamSubscriptions.isNotEmpty) {
            // cancel old subscriptions
            for (var workRequestSubscription
                in _workRequestArchiveStreamSubscriptions) {
              workRequestSubscription?.cancel();
            }
            // clear subscriptions list
            _workRequestArchiveStreamSubscriptions.clear();
          }

          _companyId = state.companyId;
          if (state.isAdmin && state.groups.isEmpty) {
            _locations = state.locations.map((loc) => loc.id).toList();
          } else {
            _locations =
                state.getAvailableLocations.map((loc) => loc.id).toList();
          }

          add(GetWorkRequestsArchiveStreamEvent());
        }
      },
    );

    on<GetWorkRequestsArchiveStreamEvent>((event, emit) async {
      if (_locations.isEmpty) {
        emit(
          WorkRequestArchiveLoadedState(
            allWorkRequests: const WorkRequestsListModel(
              allWorkRequests: [],
            ),
          ),
        );
      } else {
        emit(WorkRequestArchiveLoadingState());
        if (_workRequestArchiveStreamSubscriptions.isNotEmpty) {
          // cancel old subscriptions
          for (var workRequestSubscription
              in _workRequestArchiveStreamSubscriptions) {
            workRequestSubscription?.cancel();
          }
          // clear subscriptions list
          _workRequestArchiveStreamSubscriptions.clear();
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
              await getArchiveWorkRequestsStream(params);
          await failureOrWorkRequestsStream.fold(
            (failure) async =>
                emit(WorkRequestArchiveErrorState(message: failure.message)),
            (assetsStream) async {
              final streamSubscription =
                  assetsStream.allWorkRequests.listen((snapshot) {
                add(UpdateWorkRequestsArchiveListEvent(
                  snapshot: snapshot,
                  locations: chunk,
                ));
              });
              _workRequestArchiveStreamSubscriptions.add(streamSubscription);
            },
          );
        }
      }
    });

    on<UpdateWorkRequestsArchiveListEvent>((event, emit) async {
      List<WorkRequest>? oldWorkRequests;
      // save old work orders if this is not a first chunk
      if (state is WorkRequestArchiveLoadedState) {
        oldWorkRequests = (state as WorkRequestArchiveLoadedState)
            .allWorkRequests
            .allWorkRequests;
      }
      emit(WorkRequestArchiveLoadingState());
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
        ]..sort((a, b) => b.date.compareTo(a.date));

        workRequestsList = WorkRequestsListModel(
          allWorkRequests: tmpList,
        );
      }
      emit(WorkRequestArchiveLoadedState(
        allWorkRequests: workRequestsList,
      ));
    });
  }

  @override
  Future<void> close() {
    _filterStreamSubscription.cancel();
    if (_workRequestArchiveStreamSubscriptions.isNotEmpty) {
      for (var assetSubscription in _workRequestArchiveStreamSubscriptions) {
        assetSubscription?.cancel();
      }
    }
    return super.close();
  }
}
