part of 'group_bloc.dart';

abstract class GroupState extends Equatable {
  final String message;
  final bool error;
  final List properties;

  const GroupState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });

  @override
  List<Object> get props => [message, error, properties];
}

class GroupEmptyState extends GroupState {}

class GroupLoadingState extends GroupState {}

class GroupErrorState extends GroupState {
  const GroupErrorState({
    super.message,
    super.error = true,
  });
}

class GroupLoadedState extends GroupState {
  final List<Group> selectedGroups;
  final GroupsList allGroups;

  GroupLoadedState({
    this.selectedGroups = const [],
    required this.allGroups,
    super.error = false,
    super.message = '',
  }) : super(properties: [
          selectedGroups,
          allGroups,
        ]);

  Group? getGroupById(String groupId) {
    final index = allGroups.allGroups.indexWhere((grp) => grp.id == groupId);
    if (index >= 0) {
      return allGroups.allGroups[index];
    }
    return null;
  }

  GroupLoadedState copyWith({
    List<Group>? selectedGroups,
    GroupsList? allGroups,
    String? message,
    bool? error,
  }) {
    return GroupLoadedState(
      selectedGroups: selectedGroups ?? this.selectedGroups,
      allGroups: allGroups ?? this.allGroups,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }
}
