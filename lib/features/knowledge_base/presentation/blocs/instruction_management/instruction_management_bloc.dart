import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/knowledge_base/data/models/instruction_model.dart';
import 'package:under_control_v2/features/knowledge_base/domain/usecases/add_instruction.dart';
import 'package:under_control_v2/features/knowledge_base/domain/usecases/delete_instruction.dart';
import 'package:under_control_v2/features/knowledge_base/domain/usecases/update_instruction.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../domain/entities/instruction.dart';
part 'instruction_management_event.dart';
part 'instruction_management_state.dart';

@injectable
class InstructionManagementBloc
    extends Bloc<InstructionManagementEvent, InstructionManagementState> {
  final CompanyProfileBloc companyProfileBloc;
  final AddInstruction addInstruction;
  final DeleteInstruction deleteInstruction;
  final UpdateInstruction updateInstruction;

  late StreamSubscription _companyProfileStreamSubscription;
  String _companyId = '';

  InstructionManagementBloc({
    required this.companyProfileBloc,
    required this.addInstruction,
    required this.deleteInstruction,
    required this.updateInstruction,
  }) : super(InstructionManagementEmptyState()) {
    _companyProfileStreamSubscription =
        companyProfileBloc.stream.listen((state) {
      if (state is CompanyProfileLoaded && _companyId.isEmpty) {
        _companyId = state.company.id;
      }
    });

    on<AddInstructionEvent>((event, emit) async {
      emit(InstructionManagementLoadingState());
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

  @override
  Future<void> close() {
    _companyProfileStreamSubscription.cancel();
    return super.close();
  }
}
