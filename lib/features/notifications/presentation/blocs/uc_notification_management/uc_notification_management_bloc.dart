import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../domain/entities/uc_notification.dart';
import '../../../domain/usecases/delete_notification.dart';
import '../../../domain/usecases/mark_as_read.dart';
import '../../../domain/usecases/mark_as_unread.dart';

part 'uc_notification_management_event.dart';
part 'uc_notification_management_state.dart';

@injectable
class UcNotificationManagementBloc
    extends Bloc<UcNotificationManagementEvent, UcNotificationManagementState> {
  final UserProfileBloc userProfileBloc;
  final MarkAsRead markAsRead;
  final MarkAsUnread markAsUnread;
  final DeleteNotification deleteNotification;

  UcNotificationManagementBloc({
    required this.markAsRead,
    required this.markAsUnread,
    required this.deleteNotification,
    required this.userProfileBloc,
  }) : super(UcNotificationManagementEmptyState()) {
    on<MarkAsReadEvent>(
      (event, emit) async {
        emit(UcNotificationManagementLoadingState());
        final userId = _getUserId();
        if (userId != null) {
          final params = UcNotificationParams(
            userId: userId,
            notificationId: event.notificationId,
          );
          final failureOrVoidResult = await markAsRead(params);
          await failureOrVoidResult.fold(
            (failure) async => emit(
              UcNotificationManagementErrorState(
                message: BlocMessage.notCompleted,
              ),
            ),
            (_) async => UcNotificationManagementSuccessState(
              message: BlocMessage.completed,
            ),
          );
        } else {
          emit(
            UcNotificationManagementErrorState(
              message: BlocMessage.notCompleted,
            ),
          );
        }
      },
    );
    on<MarkAsUnreadEvent>(
      (event, emit) async {
        emit(UcNotificationManagementLoadingState());
        final userId = _getUserId();
        if (userId != null) {
          final params = UcNotificationParams(
            userId: userId,
            notificationId: event.notificationId,
          );
          final failureOrVoidResult = await markAsUnread(params);
          await failureOrVoidResult.fold(
            (failure) async => emit(
              UcNotificationManagementErrorState(
                message: BlocMessage.notCompleted,
              ),
            ),
            (_) async => UcNotificationManagementSuccessState(
              message: BlocMessage.completed,
            ),
          );
        } else {
          emit(
            UcNotificationManagementErrorState(
              message: BlocMessage.notCompleted,
            ),
          );
        }
      },
    );
    on<DeleteNotificationEvent>(
      (event, emit) async {
        emit(UcNotificationManagementLoadingState());
        final userId = _getUserId();
        if (userId != null) {
          final params = UcNotificationParams(
            userId: userId,
            notificationId: event.notificationId,
          );
          final failureOrVoidResult = await deleteNotification(params);
          await failureOrVoidResult.fold(
            (failure) async => emit(
              UcNotificationManagementErrorState(
                message: BlocMessage.notCompleted,
              ),
            ),
            (_) async => UcNotificationManagementSuccessState(
              message: BlocMessage.completed,
            ),
          );
        } else {
          emit(
            UcNotificationManagementErrorState(
              message: BlocMessage.notCompleted,
            ),
          );
        }
      },
    );
  }

  String? _getUserId() {
    final userState = userProfileBloc.state;
    if (userState is Approved) {
      return userState.userProfile.id;
    }
    return null;
  }
}
