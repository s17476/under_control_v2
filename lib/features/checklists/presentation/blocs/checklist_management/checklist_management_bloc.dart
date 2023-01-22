import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
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
  final UserProfileBloc userProfileBloc;
  final AddChecklist addChecklist;
  final UpdateChecklist updateChecklist;
  final DeleteChecklist deleteChecklist;

  String _companyId = '';

  ChecklistManagementBloc({
    required this.userProfileBloc,
    required this.addChecklist,
    required this.updateChecklist,
    required this.deleteChecklist,
  }) : super(ChecklistManagementEmptyState()) {
    on<AddChecklistEvent>((event, emit) async {
      emit(ChecklistManagementLoadingState());
      _getCompanyId();
      final failureOrString = await addChecklist(
        ChecklistParams(
          checklist: event.checklist,
          companyId: _companyId,
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
      _getCompanyId();
      final failureOrVoidResult = await updateChecklist(
        ChecklistParams(
          checklist: event.checklist,
          companyId: _companyId,
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
      _getCompanyId();
      final failureOrVoidResult = await deleteChecklist(
        ChecklistParams(
          checklist: event.checklist,
          companyId: _companyId,
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

  void _getCompanyId() {
    final userState = userProfileBloc.state;
    if (userState is Approved) {
      _companyId = userState.userProfile.companyId;
    }
  }
}
