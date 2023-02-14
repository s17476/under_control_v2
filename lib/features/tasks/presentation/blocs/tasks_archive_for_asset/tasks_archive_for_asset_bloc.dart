import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

import '../../../data/models/task/tasks_list_model.dart';
import '../../../domain/usecases/task/get_archive_tasks_stream_for_asset.dart';

part 'tasks_archive_for_asset_event.dart';
part 'tasks_archive_for_asset_state.dart';

@injectable
class TasksArchiveForAssetBloc
    extends Bloc<TasksArchiveForAssetEvent, TasksArchiveForAssetState> {
  final UserProfileBloc userProfileBloc;
  final GetArchiveTasksStreamForAsset getTasksStreamForAsset;

  late StreamSubscription tasksForAssetStreamSubscription;

  TasksArchiveForAssetBloc({
    required this.userProfileBloc,
    required this.getTasksStreamForAsset,
  }) : super(TasksArchiveForAssetEmpty()) {
    on<GetTasksArchiveForAssetEvent>((event, emit) async {
      emit(TasksArchiveForAssetLoading());
      final userState = userProfileBloc.state;
      if (userState is Approved) {
        final params = IdParams(
          id: event.assetId,
          companyId: userState.userProfile.companyId,
          isAll: event.isAll,
        );
        final failureOrTasksStream = await getTasksStreamForAsset(params);
        await failureOrTasksStream.fold(
          (failure) async =>
              emit(TasksArchiveForAssetError(message: failure.message)),
          (tasksStream) async {
            tasksForAssetStreamSubscription =
                tasksStream.allTasks.listen((snapshot) {
              add(
                UpdateTasksArchiveForAssetListEvent(
                  assetId: event.assetId,
                  snapshot: snapshot,
                  isAll: event.isAll,
                ),
              );
            });
          },
        );
      } else {
        emit(TasksArchiveForAssetError(message: 'User not approved'));
      }
    });

    on<UpdateTasksArchiveForAssetListEvent>((event, emit) async {
      TasksListModel tasks = TasksListModel.fromSnapshot(
        event.snapshot as QuerySnapshot<Map<String, dynamic>>,
      );

      emit(
        TasksArchiveForAssetLoaded(
          assetId: event.assetId,
          tasks: tasks,
          isAll: event.isAll,
        ),
      );
    });
  }

  @override
  Future<void> close() {
    tasksForAssetStreamSubscription.cancel();
    return super.close();
  }
}
