part of 'instruction_category_bloc.dart';

abstract class InstructionCategoryState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const InstructionCategoryState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class InstructionCategoryEmptyState extends InstructionCategoryState {}

class InstructionCategoryLoadingState extends InstructionCategoryState {}

class InstructionCategoryErrorState extends InstructionCategoryState {
  const InstructionCategoryErrorState({
    super.message,
    super.error = true,
  });
}

class InstructionCategoryLoadedState extends InstructionCategoryState {
  final InstructionsCategoriesListModel allInstructionsCategories;
  InstructionCategoryLoadedState({
    required this.allInstructionsCategories,
  }) : super(properties: [allInstructionsCategories]);

  InstructionCategory? getInstructionCategoryById(String id) {
    final categoryIdex = allInstructionsCategories.allInstructionsCategories
        .indexWhere((cat) => cat.id == id);
    if (categoryIdex >= 0) {
      return allInstructionsCategories.allInstructionsCategories[categoryIdex];
    }
    return null;
  }
}
