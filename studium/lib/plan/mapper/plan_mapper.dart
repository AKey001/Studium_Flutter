import 'package:studium/modules/entities/models.dart';
import 'package:studium/plan/mapper/datetime_mapper.dart';
import 'package:studium/plan/models/models.dart';

List<Entry> mapToEntries(ActivityCollection? activities, {DateTime? date}) {
  List<Entry> entries = [];

  for (var day in activities!.days) {
    entries.add(TitleEntry(calculateDayName(day.date.weekday)));
    day.activities.isEmpty ? entries.add(InfoEntry("Freier Tag")) : entries.addAll(mapDayActivities(day.activities));
  }

  return entries;
}

List<Entry> mapDayActivities(List<Activity> activities) {
  List<TableEntry> entries = [];

  for (var activity in activities) {
    TableEntry tableEntry = TableEntry();
    tableEntry.time = "${activity.startTime.substring(0, 5)}\n-\n${activity.endTime.substring(0, 5)}";
    tableEntry.module = activity.name;
    tableEntry.teacher = activity.staff.map((person) => person.name).join(",");;
    tableEntry.room = activity.rooms.map((room) => room.name.trim()).join(",");
    tableEntry.type = activity.type;

    entries.add(tableEntry);
  }

  return entries;
}