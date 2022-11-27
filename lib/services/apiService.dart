import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_city/models/report.dart';

class ApiService {
  static final ApiService instance = ApiService._internal();
  List<dynamic>? _locations;
  get locations => _locations;

  List<dynamic> cows = [];

  factory ApiService() {
    // instance.appService = appService;
    return instance;
  }
  ApiService._internal();

  Future<void> loadData() async {
    // await loadCows();
    await loadMarkers();
    // await getNameByCode();
  }

  // Calf calfToPost = Calf();

  Future<List<Report>> loadMarkers() async {
    var url = Uri.https(
      '633e-185-117-148-18.ngrok.io',
      '/api/reports/',
      // {
      //   "page": '0',
      //   "size": '5',
      //   "sort": ["name"],
      // },
    );
    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'X-CSRFToken':
          'Bv3BV1Jx73hdN8WOh9SKJEkrck3iCN6ZrszSNsP4ly1oORCpodbhJnSGYy2WbQL3'
    });
    var body = json.decode(utf8.decode(response.bodyBytes))
        // as List<Map<String, Object>>;
        as List<dynamic>;
    // print(json.decode(utf8.decode(response.bodyBytes)));
    return body.map(((el) => Report.fromJson(el))).toList();
    // print(utf8.decode(response.bodyBytes).runtimeType);
    // return response;

    // _inseminators = jsonDecode(response.body)['content'];
  }

  Future<int> postCalf(Report report) async {
    try {
      Uri url = Uri.https(
        '633e-185-117-148-18.ngrok.io',
        '/api/reports/',
      );
      // calfToPost.owner = AuthService.instance.idToken!.sub;
      var rep = report.toJson();
      rep.remove('id');
      rep.remove('catergory');
      final response = await http.post(
        url,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'X-CSRFToken':
              'fMMtenlxWGelDievAlp7Du1d07fGpVnM5JiK6Or4abYwE1U6HpIEDdzsMlekYY2Q'
        },
        body: jsonEncode(rep),
      );

      await loadData();
      return response.statusCode;
    } catch (e) {
      debugPrint(e.toString());
      return 0;
    }
  }

  // Future<int> putCalf(Calf calfToPut) async {
  //   try {
  //     Uri url = Uri.https('api.university.kg', '/animals/api/v1/cow/');
  //     // print(
  //     //   jsonEncode(
  //     //     calfToPut.toJson(),
  //     //   ),
  //     // );
  //     final response = await http.put(
  //       url,
  //       headers: {
  //         'accept': '*/*',
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer ${AuthService.instance.accessToken}'
  //       },
  //       body: jsonEncode(
  //         calfToPut.toJson(),
  //       ),
  //     );
  //     if (response.statusCode == 403) {
  //       await AuthService.instance.refreshAccessToken();
  //       await ApiService.instance.putCalf(calfToPut);
  //     }
  //     await loadData();
  //     return response.statusCode;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return 0;
  //   }
  // }
}
