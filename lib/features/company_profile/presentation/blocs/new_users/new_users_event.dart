part of 'new_users_bloc.dart';

abstract class NewUsersEvent extends Equatable {
  const NewUsersEvent({
    this.properties = const [],
  });

  final List properties;

  @override
  List<Object> get props => [properties];
}

class FetchNewUsersEvent extends NewUsersEvent {
  final String companyId;
  FetchNewUsersEvent({
    required this.companyId,
  }) : super(properties: [companyId]);
}

class UpdateNewUsersEvent extends NewUsersEvent {
  final QuerySnapshot<Object?> snapshot;
  UpdateNewUsersEvent({
    required this.snapshot,
  }) : super(properties: [snapshot]);
}
