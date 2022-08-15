import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/checklists/data/models/checklists_stream_model.dart';
import 'package:under_control_v2/features/checklists/domain/entities/checklists_stream.dart';

void main() {
  final tChecklistsStreamModel = ChecklistsStreamModel(
    allChecklists: Stream.fromIterable([]),
  );

  group('Checklists', () {
    test(
      'should be a subclass of [ChecklistsStream] entity',
      () async {
        // assert
        expect(tChecklistsStreamModel, isA<ChecklistsStream>());
      },
    );
  });
}
