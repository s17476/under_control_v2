part of 'device_token_cubit.dart';

abstract class DeviceTokenState extends Equatable {
  final List properties;
  const DeviceTokenState({
    this.properties = const [],
  });

  @override
  List<Object> get props => [properties];
}

class DeviceTokenEmpty extends DeviceTokenState {}

class DeviceTokenError extends DeviceTokenState {
  final String message;
  DeviceTokenError({
    required this.message,
  }) : super(properties: [message]);
}

class DeviceTokenLoading extends DeviceTokenState {}

class DeviceTokenLoaded extends DeviceTokenState {
  final UserProfile userProfile;

  DeviceTokenLoaded({required this.userProfile})
      : super(properties: [userProfile]);
}
