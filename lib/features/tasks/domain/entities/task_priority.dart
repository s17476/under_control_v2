enum TaskPriority implements Comparable {
  low('low'),
  medium('medium'),
  high('high'),
  unknown('');

  final String name;

  const TaskPriority(this.name);

  factory TaskPriority.fromString(String name) {
    switch (name) {
      case 'low':
        return TaskPriority.low;
      case 'medium':
        return TaskPriority.medium;
      case 'high':
        return TaskPriority.high;
      default:
        return TaskPriority.unknown;
    }
  }

  @override
  int compareTo(priority) => index.compareTo(priority.index);
}
