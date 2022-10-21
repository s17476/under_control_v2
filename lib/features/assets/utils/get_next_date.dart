import '../../core/utils/duration_unit.dart';

DateTime getNextDate(
    DateTime lastDate, DurationUnit durationUnit, int duration) {
  int hour = 0;
  int day = 0;
  int week = 0;
  int month = 0;
  int year = 0;

  switch (durationUnit) {
    case DurationUnit.hour:
      hour += duration;
      break;
    case DurationUnit.day:
      day += duration;
      break;
    case DurationUnit.week:
      week += duration;
      break;
    case DurationUnit.month:
      month += duration;
      break;
    case DurationUnit.year:
      year += duration;
      break;
    default:
      break;
  }
  final nextDate = DateTime(
    lastDate.year + year,
    lastDate.month + month,
    lastDate.day + day + week * 7,
    lastDate.hour + hour,
    lastDate.minute,
  );

  return nextDate;
}
