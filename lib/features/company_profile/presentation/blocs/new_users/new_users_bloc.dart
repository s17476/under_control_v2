import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../company_profile/domain/entities/company_users_list.dart';
import '../../../data/models/company_users_list_model.dart';
import '../../../domain/usecases/fetch_new_users.dart';
import '../company_profile/company_profile_bloc.dart';

part 'new_users_event.dart';
part 'new_users_state.dart';

@injectable
class NewUsersBloc extends Bloc<NewUsersEvent, NewUsersState> {
  late StreamSubscription _companyProfileSubscription;
  StreamSubscription? _newUsersStreamSubscription;
  final CompanyProfileBloc companyProfileBloc;
  final FetchNewUsers fetchNewUsers;

  NewUsersBloc(
    this.companyProfileBloc,
    this.fetchNewUsers,
  ) : super(NewUsersEmptyState()) {
    _companyProfileSubscription = companyProfileBloc.stream.listen(
      (state) {
        if (state is CompanyProfileLoaded) {
          add(
            FetchNewUsersEvent(companyId: state.company.id),
          );
        }
      },
    );

    on<FetchNewUsersEvent>((event, emit) async {
      emit(NewUsersLoadingState());
      final failureOrNewUsers = await fetchNewUsers(event.companyId);

      failureOrNewUsers.fold(
        (failure) async => emit(const NewUsersErrorState()),
        (newUsers) async {
          _newUsersStreamSubscription = newUsers.allUsers.listen((snapshot) {
            add(UpdateNewUsersEvent(snapshot: snapshot));
          });
          emit(
            NewUsersLoadedState(
              newUsers: const CompanyUsersList(
                activeUsers: [],
                passiveUsers: [],
              ),
            ),
          );
        },
      );
    });

    on<UpdateNewUsersEvent>(
      (event, emit) async {
        CompanyUsersList usersList = CompanyUsersListModel.fromSnapshot(
            event.snapshot as QuerySnapshot<Map<String, dynamic>>);
        emit(
          NewUsersLoadedState(
            newUsers: usersList,
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    _companyProfileSubscription.cancel();
    _newUsersStreamSubscription?.cancel();
    return super.close();
  }
}
