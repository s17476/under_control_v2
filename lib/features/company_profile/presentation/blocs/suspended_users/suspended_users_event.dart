part of 'suspended_users_bloc.dart';

abstract class SuspendedUsersEvent extends Equatable {
  const SuspendedUsersEvent({
    this.properties = const [],
  });

  final List properties;

  @override
  List<Object> get props => [properties];
}

class FetchSuspendedUsersEvent extends SuspendedUsersEvent {
  final String companyId;
  FetchSuspendedUsersEvent({
    required this.companyId,
  }) : super(properties: [companyId]);
}

class UpdateSuspendedUsersEvent extends SuspendedUsersEvent {
  final QuerySnapshot<Object?> snapshot;
  UpdateSuspendedUsersEvent({
    required this.snapshot,
  }) : super(properties: [snapshot]);
}
