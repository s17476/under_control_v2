import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/groups/data/models/group_model.dart';
import 'package:under_control_v2/features/groups/data/models/groups_list_model.dart';
import 'package:under_control_v2/features/groups/domain/entities/groups_list.dart';

void main() {
  const tGroupModel = GroupModel(
    id: 'id',
    name: 'name',
    locations: [],
    features: [],
  );
  const tGroupsListModel = GroupsListModel(
    allGroups: [tGroupModel],
  );

  group('Groups', () {
    test(
      'should ba a subclass of [GroupsList] entity',
      () async {
        // assert
        expect(tGroupsListModel, isA<GroupsList>());
      },
    );
  });
}
