part of 'showcase_settings_cubit.dart';

abstract class ShowcaseSettingsState extends Equatable {
  final List properties;
  const ShowcaseSettingsState({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class ShowcaseSettingsEmpty extends ShowcaseSettingsState {}

class ShowcaseSettingsLoading extends ShowcaseSettingsState {}

class ShowcaseSettingsError extends ShowcaseSettingsState {}

class ShowcaseSettingsLoaded extends ShowcaseSettingsState {
  final ShowcaseSettings settings;
  final BlocMessage message;
  ShowcaseSettingsLoaded({
    required this.settings,
    this.message = BlocMessage.completed,
  }) : super(properties: [settings, message]);

  ShowcaseSettingsLoaded copyWith({
    ShowcaseSettingsModel? settings,
    BlocMessage? message,
  }) {
    return ShowcaseSettingsLoaded(
      settings: settings ?? this.settings,
      message: message ?? this.message,
    );
  }
}
