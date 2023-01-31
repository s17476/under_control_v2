part of 'items_management_bloc.dart';

abstract class UcNotificationManagementState extends Equatable {
  final BlocMessage message;
  final bool error;
  final List properties;

  const UcNotificationManagementState({
    this.message = BlocMessage.empty,
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class UcNotificationManagementEmptyState
    extends UcNotificationManagementState {}

class UcNotificationManagementLoadingState
    extends UcNotificationManagementState {}

class UcNotificationManagementErrorState extends UcNotificationManagementState {
  UcNotificationManagementErrorState({
    required super.message,
    super.error = true,
  }) : super(properties: [error, message]);
}

class UcNotificationManagementSuccessState
    extends UcNotificationManagementState {
  UcNotificationManagementSuccessState({
    required super.message,
  }) : super(properties: [message]);
}
