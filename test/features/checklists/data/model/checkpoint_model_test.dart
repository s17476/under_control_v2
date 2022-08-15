import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/checklists/data/models/checkpoint_model.dart';
import 'package:under_control_v2/features/checklists/domain/entities/checkpoint.dart';

void main() {
  const tCheckpointModel = CheckpointModel(
    title: 'title',
    isChecked: false,
  );

  const tCheckpointModelMap = {
    'title': 'title',
    'isChecked': false,
  };

  group(
    'Checklists',
    () {
      test(
        'should be a subclass of [Checkpoint]',
        () async {
          // assert
          expect(tCheckpointModel, isA<Checkpoint>());
        },
      );

      test(
        'should return a valid model from a map',
        () async {
          // act
          final result = CheckpointModel.fromMap(tCheckpointModelMap);
          // assert
          expect(result, tCheckpointModel);
        },
      );

      test(
        'should return a map containing proper data',
        () async {
          // act
          final result = tCheckpointModel.toMap();
          // assert
          expect(result, tCheckpointModelMap);
        },
      );
    },
  );
}
