import 'package:equatable/equatable.dart';

class UserStream extends Equatable {
  final Stream userStream;
  const UserStream({
    required this.userStream,
  });

  @override
  List<Object> get props => [userStream];

  @override
  String toString() => 'UserStream(userStream: $userStream)';
}
