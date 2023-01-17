import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/dashboard/domain/usecases/get_awaiting_work_requests_count.dart';
import 'package:under_control_v2/features/dashboard/domain/usecases/get_cancelled_work_requests_count.dart';
import 'package:under_control_v2/features/dashboard/domain/usecases/get_converted_work_requests_count.dart';

import '../../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../../groups/domain/entities/feature.dart';

part 'work_requests_status_event.dart';
part 'work_requests_status_state.dart';

@injectable
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

    on<GetWorkRequestsStatusEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
  // TODO add update handlers

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
