import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/uc_notifications_list_model.dart';
import '../../../domain/usecases/delete_notification.dart';
import '../../../domain/usecases/get_notifications.dart';
import '../../../domain/usecases/mark_as_read.dart';
import '../../../domain/usecases/mark_as_unread.dart';

part 'uc_notification_event.dart';
part 'uc_notification_state.dart';

@singleton
class UcNotificationBloc
    extends Bloc<UcNotificationEvent, UcNotificationState> {
  final AuthenticationBloc authenticationBloc;
  final UserProfileBloc userProfileBloc;
  final GetNotifications getNotifications;
  final MarkAsRead markAsRead;
  final MarkAsUnread markAsUnread;
  final DeleteNotification deleteNotification;

  late StreamSubscription _authStreamSubscription;
  late StreamSubscription _userStreamSubscription;
  StreamSubscription? _notificationsStreamSubscription;

  UcNotificationBloc({
    required this.authenticationBloc,
    required this.userProfileBloc,
    required this.getNotifications,
    required this.markAsRead,
    required this.markAsUnread,
    required this.deleteNotification,
  }) : super(UcNotificationEmpty()) {
    _authStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {
        add(ResetEvent());
      }
    });
    _userStreamSubscription = userProfileBloc.stream.listen((state) {
      if (state is Approved) {
        add(GetNotificationsStreamEvent(userProfile: state.userProfile));
      }
    });

    on<ResetEvent>((event, emit) {
      emit(UcNotificationEmpty());
    });

    on<GetNotificationsStreamEvent>(
      (event, emit) async {
        emit(UcNotificationLoading());
        final params = UserProfileParams(userProfile: event.userProfile);
        final failureOrNotificationsStream = await getNotifications(params);
        await failureOrNotificationsStream.fold(
          (failure) async => UcNotificationError(message: failure.message),
          (notificationsStream) async => _notificationsStreamSubscription =
              notificationsStream.allNotifications.listen((snapshot) {
            add(UpdateNotificationsListEvent(snapshot: snapshot));
          }),
        );
      },
    );

    on<UpdateNotificationsListEvent>(
      (event, emit) async {
        emit(UcNotificationLoading());

        final ucNotificationsList = UcNotificationsListModel.fromSnapshot(
          event.snapshot as QuerySnapshot<Map<String, dynamic>>,
        );

        emit(UcNotificationLoaded(allNotifications: ucNotificationsList));
      },
    );
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    _userStreamSubscription.cancel();
    _notificationsStreamSubscription?.cancel();
    return super.close();
  }
}
