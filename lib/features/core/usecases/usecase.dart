import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:under_control_v2/features/groups/domain/entities/group.dart';

import '../../locations/domain/entities/location.dart';
import '../error/failures.dart';

abstract class FutureUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}

class AuthParams extends Equatable {
  final String email;
  final String password;

  const AuthParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class AddUserParams extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final File? avatar;

  const AddUserParams({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.avatar,
  });

  @override
  List<Object> get props => [firstName, lastName, phoneNumber];
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class VoidResult extends Equatable {
  @override
  List<Object?> get props => [];
}

class AssignParams extends Equatable {
  final String userId;
  final String companyId;

  const AssignParams({
    required this.userId,
    required this.companyId,
  });

  @override
  List<Object> get props => [userId, companyId];
}

class UserAndGroupParams extends Equatable {
  final String userId;
  final String groupId;

  const UserAndGroupParams({
    required this.userId,
    required this.groupId,
  });

  @override
  List<Object> get props => [userId, groupId];
}

class AssignGroupAdminParams extends Equatable {
  final String userId;
  final String groupId;
  final String companyId;

  const AssignGroupAdminParams({
    required this.userId,
    required this.groupId,
    required this.companyId,
  });

  @override
  List<Object> get props => [userId, groupId];
}

class AvatarParams extends Equatable {
  final String userId;
  final File avatar;

  const AvatarParams({
    required this.userId,
    required this.avatar,
  });

  @override
  List<Object> get props => [userId, avatar];
}

class LocationParams extends Equatable {
  final Location location;
  final String comapnyId;

  const LocationParams({
    required this.location,
    required this.comapnyId,
  });

  @override
  List<Object> get props => [location, comapnyId];
}

class SelectedLocationsParams extends Equatable {
  final List<String> locations;
  final List<String> children;

  const SelectedLocationsParams({
    required this.locations,
    required this.children,
  });

  @override
  List<Object> get props => [locations, children];
}

class GroupParams extends Equatable {
  final Group group;
  final String companyId;

  const GroupParams({
    required this.group,
    required this.companyId,
  });

  @override
  List<Object> get props => [group, companyId];
}

class SelectedGroupsParams extends Equatable {
  final List<String> groups;

  const SelectedGroupsParams({
    required this.groups,
  });

  @override
  List<Object> get props => [groups];
}
