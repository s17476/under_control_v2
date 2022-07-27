import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../data/models/groups_list_model.dart';
import '../../../domain/entities/group.dart';
import '../../../domain/entities/groups_list.dart';
import '../../../domain/usecases/add_group.dart';
import '../../../domain/usecases/cache_groups.dart';
import '../../../domain/usecases/delete_group.dart';
import '../../../domain/usecases/get_groups_stream.dart';
import '../../../domain/usecases/try_to_get_cached_groups.dart';
import '../../../domain/usecases/update_group.dart';

part 'group_event.dart';
part 'group_state.dart';

const String addedMessage = 'added';
const String deleteFailed = 'deleteFailed';
const String deleteSuccess = 'deleteSuccess';
const String updateSuccess = 'updateSuccess';
const String groupContainsMembers = 'groupContainsMembers';

@injectable
class GroupBloc extends Bloc<GroupEvent, GroupState> {
  late StreamSubscription companyProfileStreamSubscription;
  StreamSubscription? groupsStreamSubscription;
  final CompanyProfileBloc companyProfileBloc;
  final AddGroup addGroup;
  final UpdateGroup updateGroup;
  final DeleteGroup deleteGroup;
  final GetGroupsStream getGroupsStream;
  final CacheGroups cacheGroups;
  final TryToGetCachedGroups tryToGetCachedGroups;
  String companyId = '';

  GroupBloc({
    required this.companyProfileBloc,
    required this.addGroup,
    required this.updateGroup,
    required this.deleteGroup,
    required this.getGroupsStream,
    required this.cacheGroups,
    required this.tryToGetCachedGroups,
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
      // cheks for group members
      final companyMembers = (companyProfileBloc.state as CompanyProfileLoaded)
          .companyUsers
          .allUsers;
      final groupMembers = companyMembers
          .where((member) => member.userGroups.contains(event.group.id));
      if (groupMembers.isNotEmpty) {
        emit((state as GroupLoadedState).copyWith(
          message: groupContainsMembers,
          error: true,
        ));
      } else {
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
      }
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

    on<UpdateGroupsListEvent>(
      (event, emit) async {
        final groupsList = GroupsListModel.fromSnapshot(
          event.snapshot as QuerySnapshot<Map<String, dynamic>>,
        );
        final failureOrSelectedGroupsParams =
            await tryToGetCachedGroups(NoParams());
        await failureOrSelectedGroupsParams.fold(
          // no cached groups found
          (failure) async => emit(GroupLoadedState(allGroups: groupsList)),
          // cached groups found
          (selectedGroupsParams) async {
            final List<Group> cachedGroups = [];
            for (var groupId in selectedGroupsParams.groups) {
              cachedGroups.add(groupsList.allGroups
                  .firstWhere((element) => element.id == groupId));
            }
            emit(GroupLoadedState(
              allGroups: groupsList,
              selectedGroups: cachedGroups,
            ));
          },
        );
      },
    );

    on<SelectGroupEvent>(
      (event, emit) async {
        final currentState = state as GroupLoadedState;
        final selectedGroups = [...currentState.selectedGroups];
        selectedGroups.add(event.group);
        final failureOrVoidResult = await cacheGroups(
          SelectedGroupsParams(
            groups: selectedGroups.map((group) => group.id).toList(),
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            currentState.copyWith(
              selectedGroups: selectedGroups,
            ),
          ),
          (_) async => emit(
            currentState.copyWith(
              selectedGroups: selectedGroups,
            ),
          ),
        );
      },
    );

    on<UnselectGroupEvent>(
      (event, emit) async {
        final currentState = state as GroupLoadedState;
        final selectedGroups = currentState.selectedGroups;
        selectedGroups.remove(event.group);
        final failureOrVoidResult = await cacheGroups(
          SelectedGroupsParams(
            groups: selectedGroups.map((group) => group.id).toList(),
          ),
        );
        await failureOrVoidResult.fold(
          (failure) async => emit(
            currentState.copyWith(
              selectedGroups: selectedGroups,
            ),
          ),
          (_) async => emit(
            currentState.copyWith(
              selectedGroups: selectedGroups,
            ),
          ),
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
