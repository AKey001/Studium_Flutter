import 'dart:convert';
import 'dart:core';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<http.Response> fetchActivities(
    DateTime startDate, DateTime endDate, String matrikel) async {
  // get semesterId
  Uri uriSemester = Uri.https("timetable.hszg.de", "/api/v1/semesters");
  final responseSemester = await http.get(uriSemester);
  final List<dynamic> parsedSemester = jsonDecode(utf8.decode(responseSemester.bodyBytes));
  Map<String, dynamic> dataSemester = parsedSemester.first;
  String semesterId = dataSemester["id"];

  // get Class
  Uri uriMatrikel = Uri.https(
      "timetable.hszg.de",
      "/api/v1/semesters/$semesterId/classes",
      {
        'query': matrikel,
      });
  final responseMatrikel = await http.get(uriMatrikel);
  final List<dynamic> parsedMatrikel = jsonDecode(utf8.decode(responseMatrikel.bodyBytes));
  Map<String, dynamic> dataMatrikel = parsedMatrikel.first;
  String matrikelId = dataMatrikel["id"];


  // get activities
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String start = formatter.format(startDate);
  final String end = formatter.format(endDate);
  Uri uri = Uri.https(
      "timetable.hszg.de",
      "/api/v1/semesters/$semesterId/classes/$matrikelId/activities",
      {
        'from': start,
        'to': end,
      });

  log(uri.toString());

  final response = await http.get(uri);
  return response;
}


Future<http.Response> fetchData(int week, String matrikel) async {
  Uri uri = Uri.https(
      "timetable.hszg.de",
      "/schedule",
      // fsel=1&site=schedule&id=&lecturer=&aktion=&kalview=&ActiveCollege=ws&SemWeek=41&StudentSets=IIM23
      {
        'fsel': '1',
        'site': 'schedule',
        'id': '',
        'lecturer': '',
        'aktion': '',
        'kalview': '',
        'ActiveCollege': 'ws',
        'SemWeek': '$week',
        'StudentSets': matrikel,
      });
  log('start fetching for week $week...');
  log(uri.toString());

  final response = await http.get(uri);
  return response;
}
