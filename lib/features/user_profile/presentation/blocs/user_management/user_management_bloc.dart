import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_group_admin.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart';

import '../../../domain/usecases/approve_user_and_make_admin.dart';
import '../../../domain/usecases/approve_user.dart';
import '../../../domain/usecases/assign_user_to_group.dart';
import '../../../domain/usecases/reject_user.dart';
import '../../../domain/usecases/suspend_user.dart';
import '../../../domain/usecases/unassign_user_from_group.dart';

part 'user_management_event.dart';
part 'user_management_state.dart';

const userAssignedToGroup = 'usserAssignedToGroup';
const assignedGroupAdmin = 'assignedGroupAdmin';
const userUnassignedFromGroup = 'usserUnassignedFromGroup';
const unassignedGroupAdmin = 'unassignedGroupAdmin';
const updateUnsuccessful = 'updateUnsuccessful';

@injectable
class UserManagementBloc
    extends Bloc<UserManagementEvent, UserManagementState> {
  final ApproveUser approveUser;
  final ApproveUserAndMakeAdmin approveUserAndMakeAdmin;
  final RejectUser rejectUser;
  final SuspendUser suspendUser;
  final UpdateUserData updateUserData;
  final AssignUserToGroup assignUserToGroup;
  final UnassignUserFromGroup unassignUserFromGroup;
  final AssignGroupAdmin assignGroupAdmin;
  final UnassignGroupAdmin unassignGroupAdmin;

  UserManagementBloc({
    required this.approveUser,
    required this.approveUserAndMakeAdmin,
    required this.rejectUser,
    required this.suspendUser,
    required this.updateUserData,
    required this.assignUserToGroup,
    required this.unassignUserFromGroup,
    required this.assignGroupAdmin,
    required this.unassignGroupAdmin,
  }) : super(UserManagementEmpty()) {
    on<ApproveUserEvent>((event, emit) async {
      emit(UserManagementLoading());
      final failureOrVoidResult = await approveUser(event.userId);
      failureOrVoidResult.fold(
        (failure) async => emit(UserManagementError(message: failure.message)),
        (voidResult) async => emit(const UserManagementSuccessful(message: '')),
      );
    });

    on<ApproveUserAndMakeAdminEvent>((event, emit) async {
      emit(UserManagementLoading());
      final failureOrVoidResult = await approveUserAndMakeAdmin(event.userId);
      failureOrVoidResult.fold(
        (failure) async => emit(UserManagementError(message: failure.message)),
        (voidResult) async => emit(const UserManagementSuccessful()),
      );
    });

    on<RejectUserEvent>((event, emit) async {
      emit(UserManagementLoading());
      final failureOrVoidResult = await rejectUser(event.userId);
      failureOrVoidResult.fold(
        (failure) async => emit(UserManagementError(message: failure.message)),
        (voidResult) async => emit(const UserManagementSuccessful()),
      );
    });

    on<SuspendUserEvent>((event, emit) async {
      emit(UserManagementLoading());
      final failureOrVoidResult = await suspendUser(event.userId);
      failureOrVoidResult.fold(
        (failure) async => emit(UserManagementError(message: failure.message)),
        (voidResult) async => emit(const UserManagementSuccessful()),
      );
    });

    on<AssignUserToGroupEvent>(
      (event, emit) async {
        emit(UserManagementLoading());
        final params = UserAndGroupParams(
          userId: event.userId,
          groupId: event.groupId,
        );
        final failureOrVoidResult = await assignUserToGroup(params);
        failureOrVoidResult.fold(
          (failure) async =>
              emit(const UserManagementError(message: updateUnsuccessful)),
          (voidResult) async => emit(
              const UserManagementSuccessful(message: userAssignedToGroup)),
        );
      },
    );

    on<UnassignUserFromGroupEvent>(
      (event, emit) async {
        emit(UserManagementLoading());
        final params = UserAndGroupParams(
          userId: event.userId,
          groupId: event.groupId,
        );
        final failureOrVoidResult = await unassignUserFromGroup(params);
        failureOrVoidResult.fold(
          (failure) async =>
              emit(const UserManagementError(message: updateUnsuccessful)),
          (voidResult) async => emit(
            const UserManagementSuccessful(message: userUnassignedFromGroup),
          ),
        );
      },
    );

    on<AssignGroupAdminEvent>(
      (event, emit) async {
        emit(UserManagementLoading());
        final params = AssignGroupAdminParams(
          userId: event.userId,
          groupId: event.groupId,
          companyId: event.companyId,
        );
        final failureOrVoidResult = await assignGroupAdmin(params);
        failureOrVoidResult.fold(
          (failure) async =>
              emit(const UserManagementError(message: updateUnsuccessful)),
          (voidResult) async =>
              emit(const UserManagementSuccessful(message: assignedGroupAdmin)),
        );
      },
    );

    on<UnassignGroupAdminEvent>(
      (event, emit) async {
        emit(UserManagementLoading());
        final params = AssignGroupAdminParams(
          userId: event.userId,
          groupId: event.groupId,
          companyId: event.companyId,
        );
        final failureOrVoidResult = await unassignGroupAdmin(params);
        failureOrVoidResult.fold(
          (failure) async =>
              emit(const UserManagementError(message: updateUnsuccessful)),
          (voidResult) async => emit(
            const UserManagementSuccessful(message: unassignedGroupAdmin),
          ),
        );
      },
    );
  }
}
