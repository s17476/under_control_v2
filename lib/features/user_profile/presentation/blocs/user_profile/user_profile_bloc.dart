import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/input_validator.dart';
import '../../../domain/usecases/add_user_avatar.dart';
import '../../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../data/models/user_profile_model.dart';
import '../../../domain/entities/user_profile.dart';
import '../../../domain/usecases/add_user.dart';
import '../../../domain/usecases/assign_user_to_company.dart';
import '../../../domain/usecases/get_user_by_id.dart';
import '../../../domain/usecases/get_user_stream_by_id.dart';
import '../../../domain/usecases/reset_company.dart';
import '../../../domain/usecases/update_user_data.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

@injectable
class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  late StreamSubscription streamSubscription;
  StreamSubscription? userStreamSubscription;
  final AuthenticationBloc authenticationBloc;
  final AddUser addUser;
  final AssignUserToCompany assignUserToCompany;
  final ResetCompany resetCompany;
  final GetUserById getUserById;
  final GetUserStreamById getUserStreamById;
  final UpdateUserData updateUserData;
  final AddUserAvatar addUserAvatar;
  final InputValidator inputValidator;

  UserProfileBloc({
    required this.authenticationBloc,
    required this.addUser,
    required this.assignUserToCompany,
    required this.resetCompany,
    required this.getUserById,
    required this.getUserStreamById,
    required this.updateUserData,
    required this.addUserAvatar,
    required this.inputValidator,
  }) : super(UserProfileEmpty()) {
    streamSubscription = authenticationBloc.stream.listen(
      (state) {
        if (state is Authenticated) {
          add(GetUserByIdEvent(userId: state.userId));
        }
      },
    );

    on<AddUserEvent>(
      (event, emit) async {
        emit(Loading());
        final userId = (authenticationBloc.state as Authenticated).userId;
        final email = (authenticationBloc.state as Authenticated).email;
        // input validation
        final failureOrVoid = inputValidator.addUserValidator(
          event.userProfile.firstName,
          event.userProfile.lastName,
          event.userProfile.phoneNumber,
          event.avatar,
        );
        await failureOrVoid.fold(
          (failure) async => emit(NoUserProfileError(message: failure.message)),
          (_) async {
            // add avatar to cloud storage
            final failureOrAvatarString = await addUserAvatar(
                AvatarParams(userId: userId, avatar: event.avatar!));
            await failureOrAvatarString.fold(
              (failure) async => emit(
                DatabaseErrorUserProfile(message: failure.message),
              ),
              (avatarUrl) async {
                UserProfileModel updatedUser =
                    (event.userProfile as UserProfileModel).copyWith(
                  avatarUrl: avatarUrl,
                  id: userId,
                  email: email,
                );
                // add user to cloud DB
                final failureOrVoidResult = await addUser(updatedUser);
                await failureOrVoidResult.fold(
                  (failure) async => emit(
                    DatabaseErrorUserProfile(
                        message: failure.message, error: true),
                  ),
                  (_) async {
                    emit(NoCompanyState(userProfile: updatedUser));
                  },
                );
              },
            );
          },
        );
      },
    );

    on<AssignToCompanyEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrVoidResult = await assignUserToCompany(
          AssignParams(
            userId: event.userProfile.id,
            companyId: event.companyId,
          ),
        );
        failureOrVoidResult.fold(
          (failure) async => emit(
            DatabaseErrorUserProfile(message: failure.message),
          ),
          (userId) async {
            final updatedUser = (event.userProfile as UserProfileModel)
                .copyWith(companyId: event.companyId);
            emit(NotApproved(userProfile: updatedUser));
          },
        );
      },
    );

    on<ResetCompanyEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrVoidResult = await resetCompany(event.userProfile.id);
        failureOrVoidResult.fold(
          (failure) async => emit(
            DatabaseErrorUserProfile(message: failure.message),
          ),
          (userId) async {
            final updatedUser =
                (event.userProfile as UserProfileModel).copyWith(companyId: '');
            emit(NoCompanyState(userProfile: updatedUser));
          },
        );
      },
    );

    on<GetUserByIdEvent>((event, emit) async {
      emit(Loading());
      // final failureOrUserProfile = await getUserById(event.userId);
      // failureOrUserProfile.fold(
      //   (failure) async {
      //     if (failure is UnsuspectedFailure) {
      //       emit(const NoUserProfileError());
      //     } else {
      //       emit(DatabaseErrorUserProfile(message: failure.message));
      //     }
      //   },
      //   (userProfile) async {
      //     // user is not assigned to any company
      //     if (userProfile.companyId.isEmpty) {
      //       emit(NoCompany(userProfile: userProfile));
      //       // user assigned to a company
      //     } else if (!userProfile.approved) {
      //       // user rejected by administrator
      //       if (userProfile.rejected) {
      //         emit(Rejected(userProfile: userProfile));
      //         // user suspended by administrator
      //       } else if (userProfile.suspended) {
      //         emit(Suspended(userProfile: userProfile));
      //         // user awaiting approvement by administrator
      //       } else {
      //         emit(NotApproved(userProfile: userProfile));
      //       }
      //       // user approved by administrator
      //     } else {
      //       emit(Approved(userProfile: userProfile));
      //     }
      //   },
      // );
      final failureOrUserStream = await getUserStreamById(event.userId);
      failureOrUserStream.fold(
        (failure) async {
          if (failure is UnsuspectedFailure) {
            emit(const NoUserProfileError());
          } else {
            emit(DatabaseErrorUserProfile(message: failure.message));
          }
        },
        (userStream) async {
          userStreamSubscription = userStream.userStream.listen((userSnapshot) {
            add(UpdateUserProfileEvent(snapshot: userSnapshot));
          });
        },
      );
    });

    on<UpdateUserProfileEvent>(
      (event, emit) async {
        if (!event.snapshot.exists) {
          emit(const NoUserProfileError());
        } else {
          final userProfile = UserProfileModel.fromSnapshot(
              event.snapshot as DocumentSnapshot<Map<String, dynamic>>);
          // user is not assigned to any company
          if (userProfile.companyId.isEmpty) {
            emit(NoCompanyState(userProfile: userProfile));
            // user assigned to a company
          } else if (!userProfile.approved) {
            // user rejected by administrator
            if (userProfile.rejected) {
              emit(Rejected(userProfile: userProfile));
              // user suspended by administrator
            } else if (userProfile.suspended) {
              emit(Suspended(userProfile: userProfile));
              // user awaiting approvement by administrator
            } else {
              emit(NotApproved(userProfile: userProfile));
            }
            // user approved by administrator
          } else {
            emit(Approved(userProfile: userProfile));
          }
        }
      },
    );
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    userStreamSubscription?.cancel();
    return super.close();
  }
}
