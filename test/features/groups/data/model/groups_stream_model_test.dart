import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/groups/data/models/groups_stream_model.dart';
import 'package:under_control_v2/features/groups/domain/entities/groups_stream.dart';

void main() {
  final tGroupsStreamModel =
      GroupsStreamModel(allGroups: Stream.fromIterable([]));

  group('Groups', () {
    test(
      'should be subclass of [GroupsStream] entity',
      () async {
        // assert
        expect(tGroupsStreamModel, isA<GroupsStream>());
      },
    );
  });
}
