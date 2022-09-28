part of 'instruction_category_management_bloc.dart';

abstract class InstructionCategoryManagementEvent extends Equatable {
  final InstructionCategory instructionCategory;
  const InstructionCategoryManagementEvent({
    required this.instructionCategory,
  });

  @override
  List<Object> get props => [instructionCategory];
}

class AddInstructionCategoryEvent extends InstructionCategoryManagementEvent {
  const AddInstructionCategoryEvent({required super.instructionCategory});
}

class UpdateInstructionCategoryEvent
    extends InstructionCategoryManagementEvent {
  const UpdateInstructionCategoryEvent({required super.instructionCategory});
}

class DeleteInstructionCategoryEvent
    extends InstructionCategoryManagementEvent {
  const DeleteInstructionCategoryEvent({required super.instructionCategory});
}
