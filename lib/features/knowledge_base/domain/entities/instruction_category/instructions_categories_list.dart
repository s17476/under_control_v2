import 'package:equatable/equatable.dart';

import 'instruction_category.dart';

class InstructionsCategoriesList extends Equatable {
  final List<InstructionCategory> allInstructionsCategories;

  const InstructionsCategoriesList({
    required this.allInstructionsCategories,
  });

  @override
  List<Object> get props => [allInstructionsCategories];

  @override
  String toString() =>
      'InstructionsCategoriesList(allInstructionsCategories: $allInstructionsCategories)';
}
