part of 'notification_settings_cubit.dart';

abstract class NotificationSettingsState extends Equatable {
  final List properties;
  const NotificationSettingsState({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class NotificationSettingsEmpty extends NotificationSettingsState {}

class NotificationSettingsLoading extends NotificationSettingsState {}

class NotificationSettingsError extends NotificationSettingsState {}

class NotificationSettingsLoaded extends NotificationSettingsState {
  final NotificationSettings settings;
  final BlocMessage message;
  NotificationSettingsLoaded({
    required this.settings,
    this.message = BlocMessage.completed,
  }) : super(properties: [settings, message]);

  NotificationSettingsLoaded copyWith({
    NotificationSettingsModel? settings,
    BlocMessage? message,
  }) {
    return NotificationSettingsLoaded(
      settings: settings ?? this.settings,
      message: message ?? this.message,
    );
  }
}
