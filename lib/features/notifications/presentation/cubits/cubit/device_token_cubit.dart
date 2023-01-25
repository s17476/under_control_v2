import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../domain/usecases/register_device_token.dart';
import '../../../domain/usecases/remove_device_token.dart';

part 'device_token_state.dart';

@singleton
class DeviceTokenCubit extends Cubit<DeviceTokenState> {
  final UserProfileBloc userProfileBloc;

  final RegisterDeviceToken registerDeviceToken;
  final RemoveDeviceToken removeDeviceToken;

  late StreamSubscription _userProfileStreamSubscription;

  DeviceTokenCubit({
    required this.userProfileBloc,
    required this.registerDeviceToken,
    required this.removeDeviceToken,
  }) : super(DeviceTokenEmpty()) {
    _userProfileStreamSubscription = userProfileBloc.stream.listen((userState) {
      if (userState is Approved) {
        registerToken(userState.userProfile);
      } else if (userState is UserProfileEmpty) {
        resetState();
      }
    });
  }

  void resetState() => emit(DeviceTokenEmpty());

  Future<void> registerToken(UserProfile user) async {
    emit(DeviceTokenLoading());
    final params = UserProfileParams(userProfile: user);
    final failureOrVoidresult = await registerDeviceToken(params);
    await failureOrVoidresult.fold(
      (failure) async => emit(
        DeviceTokenError(
          message: failure.message,
        ),
      ),
      (_) async => emit(
        DeviceTokenLoaded(
          userProfile: user,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _userProfileStreamSubscription.cancel();
    return super.close();
  }
}
