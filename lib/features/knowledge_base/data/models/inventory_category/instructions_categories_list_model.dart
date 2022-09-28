import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/instruction_category/instruction_category.dart';
import '../../../domain/entities/instruction_category/instructions_categories_list.dart';
import 'instruction_category_model.dart';

class InstructionsCategoriesListModel extends InstructionsCategoriesList {
  const InstructionsCategoriesListModel(
      {required super.allInstructionsCategories});

  factory InstructionsCategoriesListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<InstructionCategory> itemsCategoriesList = [];
    itemsCategoriesList = snapshot.docs
        .map(
          (DocumentSnapshot doc) => InstructionCategoryModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList()
      ..sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
    return InstructionsCategoriesListModel(
        allInstructionsCategories: itemsCategoriesList);
  }
}
