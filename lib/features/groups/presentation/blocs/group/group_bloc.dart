import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

import 'package:under_control_v2/features/groups/domain/entities/groups_list.dart';
import 'package:under_control_v2/features/groups/domain/usecases/add_group.dart';
import 'package:under_control_v2/features/groups/domain/usecases/delete_group.dart';
import 'package:under_control_v2/features/groups/domain/usecases/get_groups_stream.dart';
import 'package:under_control_v2/features/groups/domain/usecases/update_group.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../domain/entities/group.dart';

part 'group_event.dart';
part 'group_state.dart';

const String addedMessage = 'added';
const String deleteFailed = 'deleteFailed';
const String deleteSuccess = 'deleteSuccess';
const String updateSuccess = 'updateSuccess';

@injectable
class GroupBloc extends Bloc<GroupEvent, GroupState> {
  late StreamSubscription companyProfileStreamSubscription;
  StreamSubscription? groupsStreamSubscription;
  final CompanyProfileBloc companyProfileBloc;
  final AddGroup addGroup;
  final UpdateGroup updateGroup;
  final DeleteGroup deleteGroup;
  final GetGroupsStream getGroupsStream;
  String companyId = '';

  GroupBloc({
    required this.companyProfileBloc,
    required this.addGroup,
    required this.updateGroup,
    required this.deleteGroup,
    required this.getGroupsStream,
  }) : super(GroupEmptyState()) {
    companyProfileStreamSubscription = companyProfileBloc.stream.listen(
      (state) {
        if (state is CompanyProfileLoaded) {
          companyId = state.company.id;
          add(FetchAllGroupsEvent());
        }
      },
    );
    on<AddGroupEvent>((event, emit) async {
      final failureOrString = await addGroup(
        GroupParams(group: event.group, companyId: companyId),
      );
      await failureOrString.fold(
        (failure) async => emit(GroupErrorState(message: failure.message)),
        (groupId) async {
          emit(
            (state as GroupLoadedState).copyWith(message: addedMessage),
          );
        },
      );
    });
    on<UpdateGroupEvent>((event, emit) async {
      final failureOrVoidResult = await updateGroup(
        GroupParams(group: event.group, companyId: companyId),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(GroupErrorState(message: failure.message)),
        (_) async {
          emit(
            (state as GroupLoadedState).copyWith(message: updateSuccess),
          );
        },
      );
    });
    on<DeleteGroupEvent>((event, emit) async {
      final failureOrVoidResult = await deleteGroup(
        GroupParams(group: event.group, companyId: companyId),
      );
      await failureOrVoidResult.fold(
        (failure) async => emit(const GroupErrorState(message: deleteFailed)),
        (_) async {
          emit(
            (state as GroupLoadedState).copyWith(message: deleteSuccess),
          );
        },
      );
    });
    on<FetchAllGroupsEvent>(
      (event, emit) async {
        emit(GroupLoadingState());
        final failureOrGroupsStream = await getGroupsStream(companyId);
        await failureOrGroupsStream.fold(
          (failure) async => emit(GroupErrorState(message: failure.message)),
          (groupsStream) async {
            // update groups list
            groupsStreamSubscription =
                groupsStream.allGroups.listen((snapshot) {
              add(UpdateGroupsListEvent(snapshot: snapshot));
            });
            emit(
              GroupLoadedState(
                allGroups: const GroupsList(allGroups: []),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Future<void> close() {
    companyProfileStreamSubscription.cancel();
    groupsStreamSubscription?.cancel();
    return super.close();
  }
}
