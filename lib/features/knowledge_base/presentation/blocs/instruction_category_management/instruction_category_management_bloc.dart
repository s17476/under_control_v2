import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../domain/entities/instruction_category/instruction_category.dart';
import '../../../domain/usecases/item_category/add_instruction_category.dart';
import '../../../domain/usecases/item_category/delete_instruction_category.dart';
import '../../../domain/usecases/item_category/update_instruction_category.dart';

part 'instruction_category_management_event.dart';
part 'instruction_category_management_state.dart';

enum InstructionCategoryMessage {
  empty,
  itemCategoryAdded,
  itemCategoryNotAdded,
  itemCategoryUpdated,
  itemCategoryNotUpdated,
  itemCategoryDeleted,
  itemCategoryNotDeleted,
  itemCategoryNotEmpty,
}

@injectable
class InstructionCategoryManagementBloc extends Bloc<
    InstructionCategoryManagementEvent, InstructionCategoryManagementState> {
  final UserProfileBloc userProfileBloc;
  final AddInstructionCategory addInstructionCategory;
  final UpdateInstructionCategory updateInstructionCategory;
  final DeleteInstructionCategory deleteInstructionCategory;

  String _companyId = '';

  InstructionCategoryManagementBloc({
    required this.userProfileBloc,
    required this.addInstructionCategory,
    required this.updateInstructionCategory,
    required this.deleteInstructionCategory,
  }) : super(InstructionCategoryManagementEmptyState()) {
    on<AddInstructionCategoryEvent>((event, emit) async {
      emit(InstructionCategoryManagementLoadingState());
      _getCompanyId();
      final failureOrString = await addInstructionCategory(
        InstructionCategoryParams(
          instructionCategory: event.instructionCategory,
          companyId: _companyId,
        ),
      );
      await failureOrString.fold(
        (failure) async => emit(
          InstructionCategoryManagementErrorState(
            message: InstructionCategoryMessage.itemCategoryNotAdded,
          ),
        ),
        (_) async => emit(
          InstructionCategoryManagementSuccessState(
            message: InstructionCategoryMessage.itemCategoryAdded,
          ),
        ),
      );
    });

    on<UpdateInstructionCategoryEvent>((event, emit) async {
      emit(InstructionCategoryManagementLoadingState());
      _getCompanyId();
      final failureOrVoidResult = await updateInstructionCategory(
        InstructionCategoryParams(
          instructionCategory: event.instructionCategory,
          companyId: _companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(
          InstructionCategoryManagementErrorState(
            message: InstructionCategoryMessage.itemCategoryNotUpdated,
          ),
        ),
        (_) async => emit(
          InstructionCategoryManagementSuccessState(
            message: InstructionCategoryMessage.itemCategoryUpdated,
          ),
        ),
      );
    });

    on<DeleteInstructionCategoryEvent>((event, emit) async {
      emit(InstructionCategoryManagementLoadingState());
      _getCompanyId();
      final failureOrVoidResult = await deleteInstructionCategory(
        InstructionCategoryParams(
          instructionCategory: event.instructionCategory,
          companyId: _companyId,
        ),
      );
      await failureOrVoidResult.fold(
        (failure) async {
          if (failure is CategoryNotEmptyFailure) {
            emit(
              InstructionCategoryManagementErrorState(
                message: InstructionCategoryMessage.itemCategoryNotEmpty,
              ),
            );
          } else {
            emit(
              InstructionCategoryManagementErrorState(
                message: InstructionCategoryMessage.itemCategoryNotDeleted,
              ),
            );
          }
        },
        (_) async => emit(
          InstructionCategoryManagementSuccessState(
            message: InstructionCategoryMessage.itemCategoryDeleted,
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
