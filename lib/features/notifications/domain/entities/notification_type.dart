enum NotificationType {
  unknown(''),
  workRequests('workRequests'),
  tasks('tasks'),
  items('items'),
  assets('assets');

  final String name;

  const NotificationType(this.name);

  factory NotificationType.fromString(String name) {
    switch (name) {
      case 'workRequests':
        return NotificationType.workRequests;
      case 'tasks':
        return NotificationType.tasks;
      case 'items':
        return NotificationType.items;
      case 'assets':
        return NotificationType.assets;
      default:
        return NotificationType.unknown;
    }
  }
}
