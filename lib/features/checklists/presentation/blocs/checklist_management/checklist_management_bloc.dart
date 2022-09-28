import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../domain/entities/checklist.dart';
import '../../../domain/usecases/add_checklist.dart';
import '../../../domain/usecases/delete_checklist.dart';
import '../../../domain/usecases/update_checklist.dart';

part 'checklist_management_event.dart';
part 'checklist_management_state.dart';

enum ChecklistMessage {
  empty,
  checklistAdded,
  checklistNotAdded,
  checklistUpdated,
  checklistNotUpdated,
  checklistDeleted,
  checklistNotDeleted,
}

@injectable
class ChecklistManagementBloc
    extends Bloc<ChecklistManagementEvent, ChecklistManagementState> {
  late StreamSubscription _companyProfileStreamSubscription;
  final CompanyProfileBloc companyProfileBloc;
  final AddChecklist addChecklist;
  final UpdateChecklist updateChecklist;
  final DeleteChecklist deleteChecklist;

  String companyId = '';

  ChecklistManagementBloc({
    required this.companyProfileBloc,
    required this.addChecklist,
    required this.updateChecklist,
    required this.deleteChecklist,
  }) : super(ChecklistManagementEmptyState()) {
    _companyProfileStreamSubscription =
        companyProfileBloc.stream.listen((state) {
      if (state is CompanyProfileLoaded && companyId.isEmpty) {
        companyId = state.company.id;
      }
    });

    on<AddChecklistEvent>((event, emit) async {
      emit(ChecklistManagementLoadingState());
      final failureOrString = await addChecklist(
        ChecklistParams(
          checklist: event.checklist,
          companyId: companyId,
        ),
      );
      await failureOrString.fold(
        (failure) async => emit(
          ChecklistManagementErrorState(
            message: ChecklistMessage.checklistNotAdded,
          ),
        ),
        (_) async => emit(
          ChecklistManagementSuccessState(
            message: ChecklistMessage.checklistAdded,
          ),
        ),
      );
    });

    on<UpdateChecklistEvent>((event, emit) async {
      emit(ChecklistManagementLoadingState());
      final failureOrVoidResult = await updateChecklist(
        ChecklistParams(
          checklist: event.checklist,
          companyId: companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(
          ChecklistManagementErrorState(
            message: ChecklistMessage.checklistNotUpdated,
          ),
        ),
        (_) async => emit(
          ChecklistManagementSuccessState(
            message: ChecklistMessage.checklistUpdated,
          ),
        ),
      );
    });

    on<DeleteChecklistEvent>((event, emit) async {
      emit(ChecklistManagementLoadingState());
      final failureOrVoidResult = await deleteChecklist(
        ChecklistParams(
          checklist: event.checklist,
          companyId: companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(
          ChecklistManagementErrorState(
            message: ChecklistMessage.checklistNotDeleted,
          ),
        ),
        (_) async => emit(
          ChecklistManagementSuccessState(
            message: ChecklistMessage.checklistDeleted,
          ),
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _companyProfileStreamSubscription.cancel();
    return super.close();
  }
}
