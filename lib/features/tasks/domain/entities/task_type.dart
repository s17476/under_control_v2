enum TaskType {
  unknown(''),
  maintenance('maintenence'),
  reparation('reparation'),
  inspection('inspection'),
  event('event');

  final String name;

  const TaskType(this.name);

  factory TaskType.fromString(String name) {
    switch (name) {
      case 'maintenence':
        return TaskType.maintenance;
      case 'reparation':
        return TaskType.reparation;
      case 'inspection':
        return TaskType.inspection;
      case 'event':
        return TaskType.event;
      default:
        return TaskType.unknown;
    }
  }
}
