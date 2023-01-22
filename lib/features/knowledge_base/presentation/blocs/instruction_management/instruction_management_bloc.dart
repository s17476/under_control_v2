import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/instruction_model.dart';
import '../../../domain/usecases/add_instruction.dart';
import '../../../domain/usecases/delete_instruction.dart';
import '../../../domain/usecases/update_instruction.dart';

part 'instruction_management_event.dart';
part 'instruction_management_state.dart';

@injectable
class InstructionManagementBloc
    extends Bloc<InstructionManagementEvent, InstructionManagementState> {
  final UserProfileBloc userProfileBloc;
  final AddInstruction addInstruction;
  final DeleteInstruction deleteInstruction;
  final UpdateInstruction updateInstruction;

  String _companyId = '';

  InstructionManagementBloc({
    required this.userProfileBloc,
    required this.addInstruction,
    required this.deleteInstruction,
    required this.updateInstruction,
  }) : super(InstructionManagementEmptyState()) {
    on<AddInstructionEvent>((event, emit) async {
      emit(InstructionManagementLoadingState());
      _getCompanyId();
      final failureOrString = await addInstruction(
        InstructionParams(
          instruction: event.instruction,
          companyId: _companyId,
        ),
      );
      await failureOrString.fold(
        (failure) async => emit(
          const InstructionManagementErrorState(
            message: BlocMessage.notAdded,
          ),
        ),
        (_) async => emit(
          const InstructionManagementSuccessState(
            message: BlocMessage.added,
          ),
        ),
      );
    });

    on<DeleteInstructionEvent>((event, emit) async {
      emit(InstructionManagementLoadingState());
      _getCompanyId();
      final failureOrVoidResult = await deleteInstruction(
        InstructionParams(
          instruction: event.instruction,
          companyId: _companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(
          const InstructionManagementErrorState(
            message: BlocMessage.notDeleted,
          ),
        ),
        (_) async => emit(
          const InstructionManagementSuccessState(
            message: BlocMessage.deleted,
          ),
        ),
      );
    });

    on<UpdateInstructionEvent>((event, emit) async {
      emit(InstructionManagementLoadingState());
      _getCompanyId();
      final failureOrVoidResult = await updateInstruction(
        InstructionParams(
          instruction: event.instruction,
          companyId: _companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(
          const InstructionManagementErrorState(
            message: BlocMessage.notUpdated,
          ),
        ),
        (_) async => emit(
          const InstructionManagementSuccessState(
            message: BlocMessage.updated,
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
