import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

import '../../../data/models/task/tasks_list_model.dart';
import '../../../domain/entities/task/task.dart';
import '../../../domain/usecases/task/get_tasks_stream_for_asset.dart';

part 'tasks_for_asset_event.dart';
part 'tasks_for_asset_state.dart';

@injectable
class TasksForAssetBloc extends Bloc<TasksForAssetEvent, TasksForAssetState> {
  final UserProfileBloc userProfileBloc;
  final GetTasksStreamForAsset getTasksStreamForAsset;

  late StreamSubscription tasksForAssetStreamSubscription;

  TasksForAssetBloc({
    required this.userProfileBloc,
    required this.getTasksStreamForAsset,
  }) : super(TasksForAssetEmpty()) {
    on<GetTasksForAssetEvent>((event, emit) async {
      emit(TasksForAssetLoading());
      final userState = userProfileBloc.state;
      if (userState is Approved) {
        final params = IdParams(
          id: event.assetId,
          companyId: userState.userProfile.companyId,
        );
        final failureOrTasksStream = await getTasksStreamForAsset(params);
        await failureOrTasksStream.fold(
          (failure) async => emit(TasksForAssetError(message: failure.message)),
          (tasksStream) async {
            tasksForAssetStreamSubscription =
                tasksStream.allTasks.listen((snapshot) {
              add(
                UpdateTasksForAssetListEvent(
                  assetId: event.assetId,
                  snapshot: snapshot,
                ),
              );
            });
          },
        );
      } else {
        emit(TasksForAssetError(message: 'User not approved'));
      }
    });

    on<UpdateTasksForAssetListEvent>((event, emit) async {
      TasksListModel tasks = TasksListModel.fromSnapshot(
        event.snapshot as QuerySnapshot<Map<String, dynamic>>,
      );

      emit(TasksForAssetLoaded(assetId: event.assetId, tasks: tasks));
    });
  }

  @override
  Future<void> close() {
    tasksForAssetStreamSubscription.cancel();
    return super.close();
  }
}
