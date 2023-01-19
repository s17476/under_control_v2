import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/work_request/work_request_model.dart';
import '../../../domain/entities/work_request/work_request.dart';
import '../../../domain/usecases/work_order/add_work_request.dart';
import '../../../domain/usecases/work_order/cancel_work_request.dart';
import '../../../domain/usecases/work_order/delete_work_request.dart';
import '../../../domain/usecases/work_order/update_work_request.dart';

part 'work_request_management_event.dart';
part 'work_request_management_state.dart';

@injectable
class WorkRequestManagementBloc
    extends Bloc<WorkRequestManagementEvent, WorkRequestManagementState> {
  final UserProfileBloc userProfileBloc;
  final AddWorkRequest addWorkRequest;
  final DeleteWorkRequest deleteWorkRequest;
  final UpdateWorkRequest updateWorkRequest;
  final CancelWorkRequest cancelWorkRequest;

  String _companyId = '';

  WorkRequestManagementBloc({
    required this.userProfileBloc,
    required this.addWorkRequest,
    required this.deleteWorkRequest,
    required this.updateWorkRequest,
    required this.cancelWorkRequest,
  }) : super(WorkRequestManagementEmptyState()) {
    on<AddWorkRequestEvent>(
      (event, emit) async {
        emit(WorkRequestManagementLoadingState());
        _getCompanyId();
        final failureOrString = await addWorkRequest(
          WorkRequestParams(
            workRequest: event.workRequest,
            companyId: _companyId,
            images: event.images,
            video: event.video,
          ),
        );
        await failureOrString.fold(
          (failure) async => emit(
            WorkRequestManagementErrorState(
              message: BlocMessage.notAdded,
            ),
          ),
          (_) async => emit(
            WorkRequestManagementSuccessState(
              message: BlocMessage.added,
            ),
          ),
        );
      },
    );

    on<DeleteWorkRequestEvent>(
      (event, emit) async {
        emit(WorkRequestManagementLoadingState());
        _getCompanyId();
        final failureOrVoidResult = await deleteWorkRequest(
          WorkRequestParams(
            workRequest: event.workRequest,
            companyId: _companyId,
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            WorkRequestManagementErrorState(
              message: BlocMessage.notDeleted,
            ),
          ),
          (_) async => emit(
            WorkRequestManagementSuccessState(
              message: BlocMessage.deleted,
            ),
          ),
        );
      },
    );

    on<CancelWorkRequestEvent>(
      (event, emit) async {
        emit(WorkRequestManagementLoadingState());
        _getCompanyId();
        String updatedDescription = '';
        if (event.workRequest.description.isEmpty) {
          updatedDescription = event.comment;
        } else {
          updatedDescription =
              '${event.comment} \n---\n ${event.workRequest.description}';
        }
        final updatedWorkRequest =
            WorkRequestModel.fromWorkRequest(event.workRequest).copyWith(
          description: updatedDescription,
        );
        final failureOrVoidResult = await cancelWorkRequest(
          WorkRequestParams(
            workRequest: updatedWorkRequest,
            companyId: _companyId,
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            WorkRequestManagementErrorState(
              message: BlocMessage.notUpdated,
            ),
          ),
          (_) async => emit(
            WorkRequestManagementSuccessState(
              message: BlocMessage.updated,
            ),
          ),
        );
      },
    );

    on<UpdateWorkRequestEvent>(
      (event, emit) async {
        emit(WorkRequestManagementLoadingState());
        _getCompanyId();
        final failureOrVoidResult = await updateWorkRequest(
          WorkRequestParams(
            workRequest: event.workRequest,
            companyId: _companyId,
            images: event.images,
            video: event.video,
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            WorkRequestManagementErrorState(
              message: BlocMessage.notUpdated,
            ),
          ),
          (_) async => emit(
            WorkRequestManagementSuccessState(
              message: BlocMessage.updated,
            ),
          ),
        );
      },
    );
  }
  void _getCompanyId() {
    if (_companyId.isEmpty) {
      final userState = userProfileBloc.state;
      if (userState is Approved) {
        _companyId = userState.userProfile.companyId;
      }
    }
  }
}
