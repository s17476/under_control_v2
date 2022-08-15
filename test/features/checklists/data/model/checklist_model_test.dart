import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/checklists/data/models/checklist_model.dart';
import 'package:under_control_v2/features/checklists/domain/entities/checklist.dart';

void main() {
  const tChecklistModel = ChecklistModel(
    id: 'id',
    description: 'description',
    title: 'title',
    allCheckpoints: [],
  );

  const tChecklistModelMap = {
    'title': 'title',
    'description': 'description',
    'allCheckpoints': [],
  };

  group('Checklists', () {
    test(
      'should be a subclass of [Checklist]',
      () async {
        // assert
        expect(tChecklistModel, isA<Checklist>());
      },
    );

    test(
      'should return a valid model from a map',
      () async {
        // act
        final result = ChecklistModel.fromMap(tChecklistModelMap, 'id');
        // assert
        expect(result, tChecklistModel);
      },
    );

    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tChecklistModel.toMap();
        // assert
        expect(result, tChecklistModelMap);
      },
    );
  });
}
