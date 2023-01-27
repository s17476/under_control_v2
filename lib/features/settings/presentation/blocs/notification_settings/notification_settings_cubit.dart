import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../../notifications/domain/entities/notification_type.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/notification_settings_model.dart';
import '../../../domain/entities/notification_settings.dart';
import '../../../domain/usecases/get_notification_settings.dart';
import '../../../domain/usecases/update_notification_settings.dart';

part 'notification_settings_state.dart';

@lazySingleton
class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  final UserProfileBloc userProfileBloc;
  final AuthenticationBloc authenticationBloc;
  final GetNotificationSettings getNotificationSettings;
  final UpdateNotificationSettings updateNotificationSettings;

  late StreamSubscription _userStreamSubscription;
  late StreamSubscription _authStreamSubscription;
  NotificationSettingsCubit(
    this.userProfileBloc,
    this.authenticationBloc,
    this.getNotificationSettings,
    this.updateNotificationSettings,
  ) : super(NotificationSettingsEmpty()) {
    _authStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {
        _resetSettings();
      }
    });

    _userStreamSubscription = userProfileBloc.stream.listen((state) {
      if (state is Approved && state.userProfile.isActive) {
        getSettings(state.userProfile);
      }
    });
  }

  Future<void> getSettings(UserProfile userProfile) async {
    emit(NotificationSettingsLoading());
    final failureOrNotificationSettings = await getNotificationSettings(
      UserProfileParams(
        userProfile: userProfile,
      ),
    );
    await failureOrNotificationSettings.fold(
      (failure) async => emit(NotificationSettingsError()),
      (notificationSettings) async => emit(
        NotificationSettingsLoaded(
          settings: notificationSettings,
        ),
      ),
    );
  }

  Future<void> updateSettings({
    required NotificationType type,
    required bool value,
  }) async {
    final userState = userProfileBloc.state;
    final oldState = state;
    if (userState is Approved && oldState is NotificationSettingsLoaded) {
      final settingsMap =
          NotificationSettingsModel.fromDomain(oldState.settings).toMap();
      settingsMap.update(type.name, (oldValue) => oldValue = value);
      final newState = NotificationSettingsLoaded(
        settings: NotificationSettingsModel.fromMap(
          settingsMap,
        ),
      );
      emit(newState);
      final userId = userState.userProfile.id;
      final params = NotificationSettingsParams(
        userId: userId,
        type: type,
        value: value,
      );
      final failureOrVoidResult = await updateNotificationSettings(params);
      await failureOrVoidResult.fold(
        (failure) async => emit(
          oldState.copyWith(
            message: BlocMessage.notCompleted,
          ),
        ),
        (_) async => null,
      );
    }
  }

  void _resetSettings() {
    emit(NotificationSettingsEmpty());
  }

  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    _authStreamSubscription.cancel();
    return super.close();
  }
}
