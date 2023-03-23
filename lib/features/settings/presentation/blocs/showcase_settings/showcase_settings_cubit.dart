import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/bloc_message.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/showcase_settings_model.dart';
import '../../../domain/entities/showcase_settings.dart';
import '../../../domain/usecases/get_showcase_settings.dart';
import '../../../domain/usecases/update_showcase_settings.dart';

part 'showcase_settings_state.dart';

@lazySingleton
class ShowcaseSettingsCubit extends Cubit<ShowcaseSettingsState> {
  final UserProfileBloc userProfileBloc;
  final AuthenticationBloc authenticationBloc;
  final GetShowcaseSettings getShowcaseSettings;
  final UpdateShowcaseSettings updateShowcaseSettings;

  late StreamSubscription _authStreamSubscription;
  ShowcaseSettingsCubit(
    this.userProfileBloc,
    this.authenticationBloc,
    this.getShowcaseSettings,
    this.updateShowcaseSettings,
  ) : super(ShowcaseSettingsEmpty()) {
    _authStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {
        _resetSettings();
      }
    });

    final userState = userProfileBloc.state;
    if (userState is Approved && userState.userProfile.isActive) {
      getSettings(userState.userProfile);
    }
  }

  Future<void> getSettings(UserProfile userProfile) async {
    emit(ShowcaseSettingsLoading());
    final failureOrShowcaseSettings = await getShowcaseSettings(
      UserProfileParams(
        userProfile: userProfile,
      ),
    );
    await failureOrShowcaseSettings.fold(
      (failure) async => emit(ShowcaseSettingsError()),
      (showcaseSettings) async => emit(
        ShowcaseSettingsLoaded(
          settings: showcaseSettings,
        ),
      ),
    );
  }

  Future<void> updateSettings({required ShowcaseSettingsModel settings}) async {
    final userState = userProfileBloc.state;
    final oldState = state;
    if (userState is Approved && oldState is ShowcaseSettingsLoaded) {
      emit(ShowcaseSettingsLoaded(settings: settings));
      final userId = userState.userProfile.id;
      final params = ShowcaseSettingsParams(
        userId: userId,
        settings: settings,
      );
      final failureOrVoidResult = await updateShowcaseSettings(params);
      await failureOrVoidResult.fold(
        (failure) async => emit(
          oldState.copyWith(
            message: BlocMessage.notCompleted,
          ),
        ),
        (_) async => null,
      );
    }
  }

  void _resetSettings() {
    emit(ShowcaseSettingsEmpty());
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    return super.close();
  }
}
