import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/approve_user_and_make_admin.dart';
import '../../../domain/usecases/approve_user.dart';
import '../../../domain/usecases/reject_user.dart';
import '../../../domain/usecases/suspend_user.dart';

part 'user_management_event.dart';
part 'user_management_state.dart';

@injectable
class UserManagementBloc
    extends Bloc<UserManagementEvent, UserManagementState> {
  final ApproveUser approveUser;
  final ApproveUserAndMakeAdmin approveUserAndMakeAdmin;
  final RejectUser rejectUser;
  final SuspendUser suspendUser;

  UserManagementBloc({
    required this.approveUser,
    required this.approveUserAndMakeAdmin,
    required this.rejectUser,
    required this.suspendUser,
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
        (voidResult) async => emit(const UserManagementSuccessful(message: '')),
      );
    });

    on<RejectUserEvent>((event, emit) async {
      emit(UserManagementLoading());
      final failureOrVoidResult = await rejectUser(event.userId);
      failureOrVoidResult.fold(
        (failure) async => emit(UserManagementError(message: failure.message)),
        (voidResult) async => emit(const UserManagementSuccessful(message: '')),
      );
    });

    on<SuspendUserEvent>((event, emit) async {
      emit(UserManagementLoading());
      final failureOrVoidResult = await suspendUser(event.userId);
      failureOrVoidResult.fold(
        (failure) async => emit(UserManagementError(message: failure.message)),
        (voidResult) async => emit(const UserManagementSuccessful(message: '')),
      );
    });
  }
}
