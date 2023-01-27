enum NotificationType {
  unknown(''),
  workRequest('workRequest'),
  task('task'),
  item('item'),
  asset('asset');

  final String name;

  const NotificationType(this.name);

  factory NotificationType.fromString(String name) {
    switch (name) {
      case 'workRequest':
        return NotificationType.workRequest;
      case 'task':
        return NotificationType.task;
      case 'item':
        return NotificationType.item;
      case 'asset':
        return NotificationType.asset;
      default:
        return NotificationType.unknown;
    }
  }
}
