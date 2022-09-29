part of 'instruction_management_bloc.dart';

abstract class InstructionManagementEvent extends Equatable {
  final Instruction instruction;

  const InstructionManagementEvent({
    required this.instruction,
  });

  @override
  List<Object> get props => [instruction];
}

class AddInstructionEvent extends InstructionManagementEvent {
  const AddInstructionEvent({required super.instruction});
}

class UpdateInstructionEvent extends InstructionManagementEvent {
  const UpdateInstructionEvent({required super.instruction});
}

class DeleteInstructionEvent extends InstructionManagementEvent {
  const DeleteInstructionEvent({required super.instruction});
}
