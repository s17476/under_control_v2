part of 'device_token_cubit.dart';

abstract class DeviceTokenState extends Equatable {
  const DeviceTokenState();

  @override
  List<Object> get props => [];
}

class DeviceTokenEmpty extends DeviceTokenState {}

class DeviceTokenLoading extends DeviceTokenState {}

class DeviceTokenLoaded extends DeviceTokenState {}
