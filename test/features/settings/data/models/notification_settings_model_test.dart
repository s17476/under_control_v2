import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/settings/data/models/notification_settings_model.dart';
import 'package:under_control_v2/features/settings/domain/entities/notification_settings.dart';

import '../../t_notification_settings_instance.dart';

void main() {
  group('NotificationSettingsModel', () {
    test(
      'should be a subclass of [NotificationSettings] entity',
      () async {
        // assert
        expect(tNotificationSettingsModel, isA<NotificationSettings>());
      },
    );
    test(
      'should return a valid model from a map',
      () async {
        // act
        final result =
            NotificationSettingsModel.fromMap(tNotificationSettingsModelMap);
        // assert
        expect(result, tNotificationSettingsModel);
      },
    );
    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tNotificationSettingsModel.toMap();
        // assert
        expect(result, tNotificationSettingsModelMap);
      },
    );
  });
}
