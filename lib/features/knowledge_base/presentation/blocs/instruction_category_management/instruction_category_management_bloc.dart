import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
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
  final CompanyProfileBloc companyProfileBloc;
  final AddInstructionCategory addInstructionCategory;
  final UpdateInstructionCategory updateInstructionCategory;
  final DeleteInstructionCategory deleteInstructionCategory;

  late StreamSubscription _companyProfileStreamSubscription;
  String _companyId = '';

  InstructionCategoryManagementBloc({
    required this.companyProfileBloc,
    required this.addInstructionCategory,
    required this.updateInstructionCategory,
    required this.deleteInstructionCategory,
  }) : super(InstructionCategoryManagementEmptyState()) {
    _companyProfileStreamSubscription =
        companyProfileBloc.stream.listen((state) {
      if (state is CompanyProfileLoaded && _companyId.isEmpty) {
        _companyId = state.company.id;
      }
    });

    on<AddInstructionCategoryEvent>((event, emit) async {
      emit(InstructionCategoryManagementLoadingState());
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

  @override
  Future<void> close() {
    _companyProfileStreamSubscription.cancel();
    return super.close();
  }
}
