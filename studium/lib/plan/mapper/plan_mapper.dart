import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:studium/plan/mapper/datetime_mapper.dart';
import 'package:studium/plan/models/models.dart';

PlanModel mapRawHtml(String html) {
  PlanModel plan = PlanModel();
  
  Document document = parser.parse(html);
  List<Element> imgs = document.getElementsByTagName('img');
  List<String> dayNames = imgs
      .where((Element element) => element.attributes.containsKey('alt'))
      .where((Element element) => element.attributes['alt'] != '')
      .map((element) => '${element.attributes['alt']}')
      .toList();

  for (String? day in dayNames) {
    List<TableEntry> entriesOfDay = [];

    List<Element> rawEntries = document.getElementsByTagName('img')
        .where((Element element) => element.attributes['alt'] == day)
        .first.parent?.parent?.parent
        ?.getElementsByTagName('table')
        .where((Element element) => element.getElementsByClassName('tabcell_blue3').isNotEmpty)
        .toList() as List<Element>;

    for (Element rawEntry in rawEntries) {
      TableEntry tableEntry = TableEntry();
      tableEntry.time = rawEntry.getElementsByClassName('tabhead_blue').first.innerHtml.replaceAll('Uhr', '').trim();
      tableEntry.module = rawEntry.getElementsByClassName('tabcell_blue3').first.innerHtml.trim();
      tableEntry.room = rawEntry.getElementsByClassName('tabcell_blue2')[1].children[0].innerHtml.trim();
      tableEntry.type = rawEntry.getElementsByClassName('tabcell_blue')[1].innerHtml.trim();
      tableEntry.teacher = _extractTeacherNames(rawEntry.getElementsByClassName('tabcell_blue2').first.children).trim();
      entriesOfDay.add(tableEntry);
    }
    _mapRawEntryToDay(plan, day!, entriesOfDay);
  }
  return plan;
}

void _mapRawEntryToDay(PlanModel plan, String day, List<TableEntry> entriesOfDay) {
  if (day == "Montag") {
    plan.monday = entriesOfDay;
    return;
  }
  if (day == "Dienstag") {
    plan.tuesday = entriesOfDay;
    return;
  }
  if (day == "Mittwoch") {
    plan.wednesday = entriesOfDay;
    return;
  }
  if (day == "Donnerstag") {
    plan.thursday = entriesOfDay;
    return;
  }
  if (day == "Freitag") {
    plan.friday = entriesOfDay;
    return;
  }
  if (day == "Samstag") {
    plan.saturday = entriesOfDay;
    return;
  }
  if (day == "Sonntag") {
    plan.sunday = entriesOfDay;
    return;
  }
}

List<TableEntry> mapDay(PlanModel plan, int day) {
  switch (day) {
    case 1:
      return plan.monday;
    case 2:
      return plan.tuesday;
    case 3:
      return plan.wednesday;
    case 4:
      return plan.thursday;
    case 5:
      return plan.friday;
    case 6:
      return plan.saturday;
    case 7:
      return plan.sunday;
    default:
      return plan.today();
  }
}

String _extractTeacherNames(List<Element> teachers) {
  String teacher = '';
  for (int i = 0; i < teachers.length; i++) {
    Element element = teachers[i];
    if (i == 0 || i == teachers.length - 1) {
      teacher += element.innerHtml.trim();
    } else {
      teacher += ', ${element.innerHtml.trim()}';
    }
  }
  return teacher;
}

List<Entry> mapToEntries(PlanModel plan, DisplayType displayType, {DateTime? date}) {
  List<Entry> entries = [];

  switch (displayType) {
    case DisplayType.single_day:

      DateTime dateTime = date ?? DateTime.now();
      List<Entry> today = mapDay(plan, dateTime.weekday);
      entries.add(TitleEntry('${calculateDayName(dateTime.weekday)}, ${dateTime.day}.${dateTime.month}.${dateTime.year}'));
      today.isEmpty ? entries.add(InfoEntry("Freier Tag")) : entries.addAll(today);
      return entries;
    case DisplayType.two_days:
      List<Entry> today = plan.today();
      List<Entry> tomorrow = plan.tomorrow();

      entries.add(TitleEntry(calculateDayName(DateTime.now().weekday)));
      today.isEmpty ? entries.add(InfoEntry("Freier Tag")) : entries.addAll(today);
      entries.add(TitleEntry(calculateDayName(DateTime.now().weekday + 1)));
      tomorrow.isEmpty ? entries.add(InfoEntry("Freier Tag")) : entries.addAll(tomorrow);
      return entries;
    case DisplayType.week:
      List<Entry> monday = plan.monday;
      List<Entry> tuesday = plan.tuesday;
      List<Entry> wednesday = plan.wednesday;
      List<Entry> thursday = plan.thursday;
      List<Entry> friday = plan.friday;
      List<Entry> saturday = plan.saturday;
      List<Entry> sunday = plan.sunday;

      entries.add(TitleEntry('Montag'));
      monday.isEmpty ? entries.add(InfoEntry("Freier Tag")) : entries.addAll(monday);
      entries.add(TitleEntry('Dienstag'));
      tuesday.isEmpty ? entries.add(InfoEntry("Freier Tag")) : entries.addAll(tuesday);
      entries.add(TitleEntry('Mittwoch'));
      wednesday.isEmpty ? entries.add(InfoEntry("Freier Tag")) : entries.addAll(wednesday);
      entries.add(TitleEntry('Donnerstag'));
      thursday.isEmpty ? entries.add(InfoEntry("Freier Tag")) : entries.addAll(thursday);
      entries.add(TitleEntry('Freitag'));
      friday.isEmpty ? entries.add(InfoEntry("Freier Tag")) : entries.addAll(friday);
      entries.add(TitleEntry('Samstag'));
      saturday.isEmpty ? entries.add(InfoEntry("Freier Tag")) : entries.addAll(saturday);
      entries.add(TitleEntry('Sonntag'));
      sunday.isEmpty ? entries.add(InfoEntry("Freier Tag")) : entries.addAll(sunday);
      return entries;
  }
}