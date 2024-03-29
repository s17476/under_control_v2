import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../data/models/user_profile_model.dart';
import '../../../domain/entities/user_profile.dart';
import '../../../domain/usecases/add_user_avatar.dart';
import '../../../domain/usecases/approve_passive_user.dart';
import '../../../domain/usecases/approve_user.dart';
import '../../../domain/usecases/approve_user_and_make_admin.dart';
import '../../../domain/usecases/assign_group_admin.dart';
import '../../../domain/usecases/assign_user_to_group.dart';
import '../../../domain/usecases/make_user_administrator.dart';
import '../../../domain/usecases/reject_user.dart';
import '../../../domain/usecases/suspend_user.dart';
import '../../../domain/usecases/unassign_group_admin.dart';
import '../../../domain/usecases/unassign_user_from_group.dart';
import '../../../domain/usecases/unmake_user_administrator.dart';
import '../../../domain/usecases/unsuspend_user.dart';
import '../../../domain/usecases/update_user_data.dart';

part 'user_management_event.dart';
part 'user_management_state.dart';

const userAssignedToGroup = 'usserAssignedToGroup';
const assignedGroupAdmin = 'assignedGroupAdmin';
const userUnassignedFromGroup = 'usserUnassignedFromGroup';
const unassignedGroupAdmin = 'unassignedGroupAdmin';
const updateUnsuccessful = 'updateUnsuccessful';
const userApproved = 'userApproved';
const userRejected = 'userRejected';
const userSuspended = 'userSuspended';
const userUnsuspended = 'userunsuspended';
const userUpdated = 'userUpdated';
const avatarUpdated = 'avatarUpdated';

@injectable
class UserManagementBloc
    extends Bloc<UserManagementEvent, UserManagementState> {
  final ApproveUser approveUser;
  final ApprovePassiveUser approvePassiveUser;
  final MakeUserAdministrator makeUserAdministrator;
  final UnmakeUserAdministrator unmakeUserAdministrator;
  final ApproveUserAndMakeAdmin approveUserAndMakeAdmin;
  final RejectUser rejectUser;
  final SuspendUser suspendUser;
  final UnsuspendUser unsuspendUser;
  final UpdateUserData updateUserData;
  final AssignUserToGroup assignUserToGroup;
  final UnassignUserFromGroup unassignUserFromGroup;
  final AssignGroupAdmin assignGroupAdmin;
  final UnassignGroupAdmin unassignGroupAdmin;
  final AddUserAvatar addUserAvatar;

  UserManagementBloc({
    required this.approveUser,
    required this.approvePassiveUser,
    required this.makeUserAdministrator,
    required this.unmakeUserAdministrator,
    required this.approveUserAndMakeAdmin,
    required this.rejectUser,
    required this.suspendUser,
    required this.unsuspendUser,
    required this.updateUserData,
    required this.assignUserToGroup,
    required this.unassignUserFromGroup,
    required this.assignGroupAdmin,
    required this.unassignGroupAdmin,
    required this.addUserAvatar,
  }) : super(UserManagementEmpty()) {
    on<ApproveUserEvent>((event, emit) async {
      emit(UserManagementLoading());
      final failureOrVoidResult = await approveUser(event.userId);
      failureOrVoidResult.fold(
        (failure) async => emit(UserManagementError(message: failure.message)),
        (voidResult) async => emit(const UserManagementSuccessful(
          message: userApproved,
        )),
      );
    });

    on<ApprovePassiveUserEvent>((event, emit) async {
      emit(UserManagementLoading());
      final failureOrVoidResult = await approvePassiveUser(event.userId);
      failureOrVoidResult.fold(
        (failure) async => emit(UserManagementError(message: failure.message)),
        (voidResult) async => emit(const UserManagementSuccessful(
          message: userApproved,
        )),
      );
    });

    on<MakeUserAdministratorEvent>((event, emit) async {
      emit(UserManagementLoading());
      final failureOrVoidResult = await makeUserAdministrator(event.userId);
      failureOrVoidResult.fold(
        (failure) async => emit(UserManagementError(message: failure.message)),
        (voidResult) async => emit(const UserManagementSuccessful()),
      );
    });

    on<UnmakeUserAdministratorEvent>((event, emit) async {
      emit(UserManagementLoading());
      final failureOrVoidResult = await unmakeUserAdministrator(event.userId);
      failureOrVoidResult.fold(
        (failure) async => emit(UserManagementError(message: failure.message)),
        (voidResult) async => emit(const UserManagementSuccessful()),
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
        (voidResult) async => emit(const UserManagementSuccessful(
          message: userRejected,
        )),
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

    on<UnsuspendUserEvent>((event, emit) async {
      emit(UserManagementLoading());
      final failureOrVoidResult = await unsuspendUser(event.userId);
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
            const UserManagementSuccessful(
              message: userUnassignedFromGroup,
              error: true,
            ),
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
            const UserManagementSuccessful(
              message: unassignedGroupAdmin,
              error: true,
            ),
          ),
        );
      },
    );

    on<UpdateUserDataEvent>(
      (event, emit) async {
        emit(UserManagementLoading());
        final failureOrVoidResult = await updateUserData(event.userProfile);
        failureOrVoidResult.fold(
          (failure) async => emit(
            UserManagementError(message: failure.message),
          ),
          (_) async =>
              emit(const UserManagementSuccessful(message: userUpdated)),
        );
      },
    );

    on<UpdateUserAvatarEvent>(
      (event, emit) async {
        emit(UserManagementLoading());
        // saves avatar in DB
        final failureOrAvatarUrl = await addUserAvatar(
          AvatarParams(id: event.userProfile.id, avatar: event.avatar!),
        );
        await failureOrAvatarUrl.fold(
          (failure) async => UserManagementError(message: failure.message),
          (avatarUrl) async {
            // updates user profile
            UserProfileModel updatedUser =
                (event.userProfile as UserProfileModel)
                    .copyWith(avatarUrl: avatarUrl);
            final failureOrVoidResult = await updateUserData(updatedUser);
            await failureOrVoidResult.fold(
              (failure) async => UserManagementError(message: failure.message),
              (_) async {
                emit(const UserManagementSuccessful(message: avatarUpdated));
              },
            );
          },
        );
      },
    );
  }
}
