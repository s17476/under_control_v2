import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/notifications/data/models/uc_notification_model.dart';
import 'package:under_control_v2/features/notifications/domain/entities/uc_notification.dart';

import '../../t_notification_instance.dart';

void main() {
  group('UcNotificationModel', () {
    test('should be a subclass of [UcNotification]', () {
      // assert
      expect(tUcNotificationModel, isA<UcNotification>());
    });
    test(
      'should return a valid model from a map',
      () async {
        // act
        final result =
            UcNotificationModel.fromMap(tUcNotificationFromMap, 'id');
        // assert
        expect(result, tUcNotificationModel);
      },
    );
    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tUcNotificationModel.toMap();
        // assert
        expect(result, tUcNotificationToMap);
      },
    );
  });
}
