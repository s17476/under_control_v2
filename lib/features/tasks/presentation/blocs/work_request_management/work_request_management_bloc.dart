import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
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
  final CompanyProfileBloc companyProfileBloc;
  final AddWorkRequest addWorkRequest;
  final DeleteWorkRequest deleteWorkRequest;
  final UpdateWorkRequest updateWorkRequest;
  final CancelWorkRequest cancelWorkRequest;

  late StreamSubscription _companyProfileStreamSubscription;
  String _companyId = '';

  WorkRequestManagementBloc({
    required this.companyProfileBloc,
    required this.addWorkRequest,
    required this.deleteWorkRequest,
    required this.updateWorkRequest,
    required this.cancelWorkRequest,
  }) : super(WorkRequestManagementEmptyState()) {
    _companyProfileStreamSubscription =
        companyProfileBloc.stream.listen((state) {
      if (state is CompanyProfileLoaded && _companyId.isEmpty) {
        _companyId = state.company.id;
      }
    });

    on<AddWorkRequestEvent>(
      (event, emit) async {
        emit(WorkRequestManagementLoadingState());
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
  @override
  Future<void> close() {
    _companyProfileStreamSubscription.cancel();
    return super.close();
  }
}
