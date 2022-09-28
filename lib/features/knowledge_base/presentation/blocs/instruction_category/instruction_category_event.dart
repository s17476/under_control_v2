part of 'instruction_category_bloc.dart';

abstract class InstructionCategoryEvent extends Equatable {
  final List properties;

  const InstructionCategoryEvent({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class GetAllInstructionsCategoriesEvent extends InstructionCategoryEvent {}

class UpdateInstructionsCategoriesListEvent extends InstructionCategoryEvent {
  final QuerySnapshot<Object?> snapshot;
  UpdateInstructionsCategoriesListEvent({
    required this.snapshot,
  }) : super(properties: [snapshot]);
}
