import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
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
import '../../../domain/usecases/update_user_data.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

@injectable
class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  late StreamSubscription streamSubscription;
  final AuthenticationBloc authenticationBloc;
  final AddUser addUser;
  final AssignUserToCompany assignUserToCompany;
  final GetUserById getUserById;
  final UpdateUserData updateUserData;
  final AddUserAvatar addUserAvatar;
  final InputValidator inputValidator;

  UserProfileBloc({
    required this.authenticationBloc,
    required this.addUser,
    required this.assignUserToCompany,
    required this.getUserById,
    required this.updateUserData,
    required this.addUserAvatar,
    required this.inputValidator,
  }) : super(EmptyUserProfileState()) {
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
          (failure) async => emit(NoUserProfileError(msg: failure.message)),
          (_) async {
            // add avatar to cloud storage
            final failureOrAvatarString = await addUserAvatar(
                AvatarParams(userId: userId, avatar: event.avatar!));
            await failureOrAvatarString.fold(
              (failure) async => emit(
                DatabaseErrorUserProfile(msg: failure.message),
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
                    DatabaseErrorUserProfile(msg: failure.message, err: true),
                  ),
                  (_) async {
                    emit(NoCompany(userProfile: updatedUser));
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
            DatabaseErrorUserProfile(msg: failure.message),
          ),
          (userId) async {
            final updatedUser = (event.userProfile as UserProfileModel)
                .copyWith(companyId: event.companyId);
            emit(NotApproved(userProfile: updatedUser));
          },
        );
      },
    );

    on<UpdateUserDataEvent>(
      (event, emit) async {
        emit(Loading());
        final failureOrVoidResult = await updateUserData(event.userProfile);
        failureOrVoidResult.fold(
          (failure) async => emit(
            DatabaseErrorUserProfile(msg: failure.message),
          ),
          (_) async {
            final updatedUser = event.userProfile;
            emit(Approved(userProfile: updatedUser));
          },
        );
      },
    );

    on<GetUserByIdEvent>((event, emit) async {
      emit(Loading());
      final failureOrUserProfile = await getUserById(event.userId);
      failureOrUserProfile.fold(
        (failure) async {
          if (failure is UnsuspectedFailure) {
            emit(const NoUserProfileError());
          } else {
            emit(DatabaseErrorUserProfile(msg: failure.message));
          }
        },
        (userProfile) async {
          // user is not assigned to any company
          if (userProfile.companyId.isEmpty) {
            emit(NoCompany(userProfile: userProfile));
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
        },
      );
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}
