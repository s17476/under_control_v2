import 'package:equatable/equatable.dart';

class InstructionsCategoriesStream extends Equatable {
  final Stream allInstructionsCategories;

  const InstructionsCategoriesStream({
    required this.allInstructionsCategories,
  });

  @override
  List<Object> get props => [allInstructionsCategories];

  @override
  String toString() =>
      'InstructionsCategoriesStream(allInstructionsCategories: $allInstructionsCategories)';
}
