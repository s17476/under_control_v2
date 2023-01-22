import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';

import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/checklists_list_model.dart';
import '../../../domain/usecases/get_checklists_stream.dart';

part 'checklist_event.dart';
part 'checklist_state.dart';

@singleton
class ChecklistBloc extends Bloc<ChecklistEvent, ChecklistState> {
  late StreamSubscription _authProfileStreamSubscription;
  late StreamSubscription _userProfileStreamSubscription;
  StreamSubscription? _checklistsStreamSubscription;
  final AuthenticationBloc authenticationBloc;
  final UserProfileBloc userProfileBloc;
  final GetChecklistStream getChecklistsStream;

  String _companyId = '';

  ChecklistBloc({
    required this.authenticationBloc,
    required this.userProfileBloc,
    required this.getChecklistsStream,
  }) : super(ChecklistEmptyState()) {
    _authProfileStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {
        add(ResetEvent());
      }
    });
    _userProfileStreamSubscription = userProfileBloc.stream.listen((state) {
      if (_companyId.isEmpty && state is Approved) {
        _companyId = state.userProfile.companyId;
        add(GetAllChecklistsEvent());
      }
    });

    on<ResetEvent>(
      (event, emit) {
        _companyId = '';
        _checklistsStreamSubscription?.cancel();
        emit(ChecklistEmptyState());
      },
    );

    on<GetAllChecklistsEvent>((event, emit) async {
      emit(ChecklistLoadingState());

      final failureOrChecklistsStream = await getChecklistsStream(_companyId);
      await failureOrChecklistsStream.fold(
          (failure) async =>
              emit(ChecklistErrorState(message: failure.message)),
          (checklistsStream) async {
        _checklistsStreamSubscription =
            checklistsStream.allChecklists.listen((snapshot) {
          add(UpdateChecklistsListEvent(snapshot: snapshot));
        });
      });
    });

    on<UpdateChecklistsListEvent>(
      (event, emit) async {
        emit(ChecklistLoadingState());
        final checklistsList = ChecklistsListModel.fromSnapshot(
          event.snapshot as QuerySnapshot<Map<String, dynamic>>,
        );
        emit(ChecklistLoadedState(allChecklists: checklistsList));
      },
    );
  }

  @override
  Future<void> close() {
    _authProfileStreamSubscription.cancel();
    _userProfileStreamSubscription.cancel();
    _checklistsStreamSubscription?.cancel();
    return super.close();
  }
}
