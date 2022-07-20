import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/groups/data/models/feature_model.dart';
import 'package:under_control_v2/features/groups/data/models/group_model.dart';
import 'package:under_control_v2/features/groups/domain/entities/group.dart';

void main() {
  const tGroupModel = GroupModel(
    id: 'id',
    name: 'name',
    locations: [],
    features: [],
  );

  const tGroupModelMap = {
    'name': 'name',
    'locations': [],
    'features': [],
  };

  group('Groups', () {
    test(
      'should be a subclass of [Group] entity',
      () async {
        // assert
        expect(tGroupModel, isA<Group>());
      },
    );
    test(
      'should return a valid model from a map',
      () async {
        // act
        final result = GroupModel.fromMap(tGroupModelMap, 'id');
        // assert
        expect(result, tGroupModel);
      },
    );
    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tGroupModel.toMap();
        // assert
        expect(result, tGroupModelMap);
      },
    );
  });
}
