import 'dart:developer';

import 'package:http/http.dart' as http;

Future<http.Response> fetchData(int week, String matrikel) async {
  Uri uri = Uri.https(
      "service.hszg.de", "/stundenplan/index.php",
      {
        'fsel': '1',
        'sel': 'Stundenplan',
        'id': '',
        'kalview': '',
        'booking': '',
        'ActiveCollege': 'Wintersemester 2022/23',
        'SemWeek': '$week',
        'ViewType': '0',
        'StudentSets': matrikel,
      });
  log('start fetching for week $week...');
  log(uri.toString());

  final response = await http.get(uri);
  return response;
}
