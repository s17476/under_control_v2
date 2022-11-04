import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../data/models/work_order/work_order_model.dart';
import '../../../domain/entities/work_order/work_order.dart';
import '../../../domain/usecases/work_order/add_work_order.dart';
import '../../../domain/usecases/work_order/cancel_work_order.dart';
import '../../../domain/usecases/work_order/delete_work_order.dart';
import '../../../domain/usecases/work_order/update_work_order.dart';

part 'work_order_management_event.dart';
part 'work_order_management_state.dart';

@injectable
class WorkOrderManagementBloc
    extends Bloc<WorkOrderManagementEvent, WorkOrderManagementState> {
  final CompanyProfileBloc companyProfileBloc;
  final AddWorkOrder addWorkOrder;
  final DeleteWorkOrder deleteWorkOrder;
  final UpdateWorkOrder updateWorkOrder;
  final CancelWorkOrder cancelWorkOrder;

  late StreamSubscription _companyProfileStreamSubscription;
  String _companyId = '';

  WorkOrderManagementBloc({
    required this.companyProfileBloc,
    required this.addWorkOrder,
    required this.deleteWorkOrder,
    required this.updateWorkOrder,
    required this.cancelWorkOrder,
  }) : super(WorkOrderManagementEmptyState()) {
    _companyProfileStreamSubscription =
        companyProfileBloc.stream.listen((state) {
      if (state is CompanyProfileLoaded && _companyId.isEmpty) {
        _companyId = state.company.id;
      }
    });

    on<AddWorkOrderEvent>(
      (event, emit) async {
        emit(WorkOrderManagementLoadingState());
        final failureOrString = await addWorkOrder(
          WorkOrderParams(
            workOrder: event.workOrder,
            companyId: _companyId,
            images: event.images,
            video: event.video,
          ),
        );
        await failureOrString.fold(
          (failure) async => emit(
            WorkOrderManagementErrorState(
              message: BlocMessage.notAdded,
            ),
          ),
          (_) async => emit(
            WorkOrderManagementSuccessState(
              message: BlocMessage.added,
            ),
          ),
        );
      },
    );

    on<DeleteWorkOrderEvent>(
      (event, emit) async {
        emit(WorkOrderManagementLoadingState());
        final failureOrVoidResult = await deleteWorkOrder(
          WorkOrderParams(
            workOrder: event.workOrder,
            companyId: _companyId,
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            WorkOrderManagementErrorState(
              message: BlocMessage.notDeleted,
            ),
          ),
          (_) async => emit(
            WorkOrderManagementSuccessState(
              message: BlocMessage.deleted,
            ),
          ),
        );
      },
    );

    on<CancelWorkOrderEvent>(
      (event, emit) async {
        emit(WorkOrderManagementLoadingState());
        String updatedDescription = '';
        if (event.workOrder.description.isEmpty) {
          updatedDescription = event.comment;
        } else {
          updatedDescription =
              '${event.comment} \n\n ${event.workOrder.description}';
        }
        final updatedWorkOrder =
            WorkOrderModel.fromWorkOrder(event.workOrder).copyWith(
          description: updatedDescription,
        );
        final failureOrVoidResult = await cancelWorkOrder(
          WorkOrderParams(
            workOrder: updatedWorkOrder,
            companyId: _companyId,
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            WorkOrderManagementErrorState(
              message: BlocMessage.notUpdated,
            ),
          ),
          (_) async => emit(
            WorkOrderManagementSuccessState(
              message: BlocMessage.updated,
            ),
          ),
        );
      },
    );

    on<UpdateWorkOrderEvent>(
      (event, emit) async {
        emit(WorkOrderManagementLoadingState());
        final failureOrVoidResult = await updateWorkOrder(
          WorkOrderParams(
            workOrder: event.workOrder,
            companyId: _companyId,
            images: event.images,
            video: event.video,
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            WorkOrderManagementErrorState(
              message: BlocMessage.notUpdated,
            ),
          ),
          (_) async => emit(
            WorkOrderManagementSuccessState(
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
