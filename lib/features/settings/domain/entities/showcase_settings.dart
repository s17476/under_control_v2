import 'package:equatable/equatable.dart';

class ShowcaseSettings extends Equatable {
  final bool adminLocationsEmpty;
  final bool adminAddLocations;
  final bool adminUsersEmpty;
  final bool adminGroupsEmpty;
  final bool filterLocations;
  final bool filterGroups;
  final bool fabMenu;
  final bool notifications;
  final bool taskFilter;
  final bool calendar;
  final bool screenTask;
  final bool screenInventory;
  final bool screenDashboard;
  final bool screenAssets;
  final bool screenInstructions;

  const ShowcaseSettings({
    required this.adminLocationsEmpty,
    required this.adminAddLocations,
    required this.adminUsersEmpty,
    required this.adminGroupsEmpty,
    required this.filterLocations,
    required this.filterGroups,
    required this.fabMenu,
    required this.notifications,
    required this.taskFilter,
    required this.calendar,
    required this.screenTask,
    required this.screenInventory,
    required this.screenDashboard,
    required this.screenAssets,
    required this.screenInstructions,
  });

  @override
  List<Object> get props {
    return [
      adminLocationsEmpty,
      adminAddLocations,
      adminUsersEmpty,
      adminGroupsEmpty,
      filterLocations,
      filterGroups,
      fabMenu,
      notifications,
      taskFilter,
      calendar,
      screenTask,
      screenInventory,
      screenDashboard,
      screenAssets,
      screenInstructions,
    ];
  }

  @override
  String toString() {
    return 'ShowcaseSettings(adminLocationsEmpty: $adminLocationsEmpty, adminAddLocations: $adminAddLocations, adminUsersEmpty: $adminUsersEmpty, adminGroupsEmpty: $adminGroupsEmpty, filterLocations: $filterLocations, filterGroups: $filterGroups, fabMenu: $fabMenu, notifications: $notifications, taskFilter: $taskFilter, calendar: $calendar, screenTask: $screenTask, screenInventory: $screenInventory, screenDashboard: $screenDashboard, screenAssets: $screenAssets, screenInstructions: $screenInstructions)';
  }
}
