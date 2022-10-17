enum DurationUnit {
  year('year'),
  month('month'),
  week('week'),
  day('day'),
  hour('hour'),
  unknown('');

  final String name;

  const DurationUnit(this.name);

  factory DurationUnit.fromString(String name) {
    switch (name) {
      case 'year':
        return DurationUnit.year;
      case 'month':
        return DurationUnit.month;
      case 'week':
        return DurationUnit.week;
      case 'day':
        return DurationUnit.day;
      case 'hour':
        return DurationUnit.hour;
      default:
        return DurationUnit.unknown;
    }
  }
}
