import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/instruction.dart';
import '../../domain/entities/instructions_list.dart';
import 'instruction_model.dart';

class InstructionsListModel extends InstructionsList {
  const InstructionsListModel({required super.allInstructions});

  factory InstructionsListModel.fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    List<Instruction> itemslist = [];
    itemslist = snapshot.docs
        .map(
          (DocumentSnapshot doc) => InstructionModel.fromMap(
            doc.data() as Map<String, dynamic>,
            doc.id,
          ),
        )
        .toList()
      ..sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
    return InstructionsListModel(allInstructions: itemslist);
  }
}
