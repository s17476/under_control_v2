import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../data/models/company_users_list_model.dart';
import '../../../domain/entities/company_users_list.dart';
import '../../../domain/usecases/fetch_suspended_users.dart';
import '../company_profile/company_profile_bloc.dart';

part 'suspended_users_event.dart';
part 'suspended_users_state.dart';

@injectable
class SuspendedUsersBloc
    extends Bloc<SuspendedUsersEvent, SuspendedUsersState> {
  late StreamSubscription _companyProfileSubscription;
  StreamSubscription? _suspendedUsersStreamSubscription;
  final CompanyProfileBloc companyProfileBloc;
  final FetchSuspendedUsers fetchSuspendedUsers;

  SuspendedUsersBloc(
    this.companyProfileBloc,
    this.fetchSuspendedUsers,
  ) : super(SuspendedUsersEmptyState()) {
    _companyProfileSubscription = companyProfileBloc.stream.listen(
      (state) {
        if (state is CompanyProfileLoaded) {
          add(
            FetchSuspendedUsersEvent(companyId: state.company.id),
          );
        }
      },
    );

    on<FetchSuspendedUsersEvent>((event, emit) async {
      emit(SuspendedUsersLoadingState());
      final failureOrNewUsers = await fetchSuspendedUsers(event.companyId);

      failureOrNewUsers.fold(
        (failure) async => emit(const SuspendedUsersErrorState()),
        (suspendedUsers) async {
          _suspendedUsersStreamSubscription =
              suspendedUsers.allUsers.listen((snapshot) {
            add(UpdateSuspendedUsersEvent(snapshot: snapshot));
          });
          emit(
            SuspendedUsersLoadedState(
              suspendedUsers: const CompanyUsersList(
                activeUsers: [],
                passiveUsers: [],
              ),
            ),
          );
        },
      );
    });

    on<UpdateSuspendedUsersEvent>(
      (event, emit) async {
        CompanyUsersList usersList = CompanyUsersListModel.fromSnapshot(
            event.snapshot as QuerySnapshot<Map<String, dynamic>>);
        emit(
          SuspendedUsersLoadedState(
            suspendedUsers: usersList,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _companyProfileSubscription.cancel();
    _suspendedUsersStreamSubscription?.cancel();
    return super.close();
  }
}
