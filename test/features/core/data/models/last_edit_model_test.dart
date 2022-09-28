import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/core/data/models/last_edit_model.dart';
import 'package:under_control_v2/features/core/domain/entities/last_edit.dart';

void main() {
  final tTimeDate = DateTime.now();

  final tLastEditModel = LastEditModel(
    userId: 'userId',
    dateTime: tTimeDate,
  );

  final tLastEditMap = {
    'userId': 'userId',
    'dateTime': tTimeDate.toIso8601String(),
  };

  group('LastEditModel', () {
    test(
      'should ba a subclass of [LastEdit] entity',
      () async {
        // assert
        expect(tLastEditModel, isA<LastEdit>());
      },
    );

    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tLastEditModel.toMap();
        // assert
        expect(result, tLastEditMap);
      },
    );

    test(
      'should return proper model from a map',
      () async {
        // act
        final result = LastEditModel.fromMap(tLastEditMap);
        // assert
        expect(result, tLastEditModel);
      },
    );
  });
}
