import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:my_city/services/apiService.dart';

part 'report.g.dart';

@JsonSerializable()
class Report {
  int id;
  String title;
  String text;
  Map<String, double> location;
  bool importance;
  int catergory;
  List<Map<String, String>> comments;

  Report({
    required this.id,
    required this.title,
    required this.text,
    required this.location,
    required this.importance,
    required this.catergory,
    required this.comments,
    // required this.date,
  });

  factory Report.fromJson(Map<String, dynamic> json) => _$ReportFromJson(json);

  Map<String, dynamic> toJson() => _$ReportToJson(this);
}

// LatLng(42.87660, 74.60374),
//     LatLng(),

class ReportsProvider extends ChangeNotifier {
  List<Report> reportList = [
    // Report(
    //   id: 1,
    //   title: "Мусор",
    //   text: "Уберите мусор",
    //   location: {'lat': 42.87660, 'lng': 74.60374},
    //   importance: false,
    //   catergory: 0,
    //   // date: DateTime.now(),
    // ),
    // Report(
    //   id: 2,
    //   title: "Рекламы",
    //   text: "Уберите баннеры",
    //   location: {'lat': 42.875696, 'lng': 74.587993},
    //   importance: false,
    //   catergory: 0,
    //   // date: DateTime.now()
    // ),
  ];

  void add(Report report) {
    ApiService.instance.postCalf(report);
    reportList.add(report);
    print(reportList.length);
    notifyListeners();
  }

  // set reports\
  void setReports(List<Report> newReportList) {
    print('СУКАААА');
    reportList = newReportList;
    notifyListeners();
  }

  List<Report> get getReportList => reportList;

  // void get()
}
