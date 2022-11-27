// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:my_city/models/report.dart';
import 'package:my_city/services/apiService.dart';
import 'package:my_city/view/widgets/bottomSheet.dart';
import 'package:my_city/view/widgets/infoWidget.dart';
import 'package:provider/provider.dart';

void main() => runApp(
    ChangeNotifierProvider(create: (_) => ReportsProvider(), child: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainMap(),
    );
  }
}

class MainMap extends StatefulWidget {
  const MainMap({super.key});
  @override
  State<MainMap> createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  late GoogleMapController contoller;
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  bool isLoading = true;
  List<Report> reports = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ApiService.instance.loadMarkers().then((value) {
      Provider.of<ReportsProvider>(context, listen: false).setReports(value);
      isLoading = false;
    });
    // Reports()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              // target: LatLng(0, 0),
              target: LatLng(42.873062, 74.580485),
              zoom: 12,
            ),
            onMapCreated: (GoogleMapController contoller) {
              // mapController = contoller ;
              _customInfoWindowController.googleMapController = contoller;
              // addMarker('test', alatoolocation);
            },
            onTap: (argument) {
              _customInfoWindowController.hideInfoWindow!();
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (builder) {
                  return MyBottomSheet(
                    location: argument,
                  );
                },
              );
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            // markers: Set<Marker>.of(_markers),
            markers: <Marker>{
              // isLoading ?
              ...context.watch<ReportsProvider>().getReportList.map((report) {
                return Marker(
                  markerId: MarkerId(report.id.toString()),
                  position:
                      LatLng(report.location['lat']!, report.location['lng']!),
                  onTap: () {
                    _customInfoWindowController.addInfoWindow!(
                      InfoWidget(title: report.title, text: report.text),
                      LatLng(
                        report.location['lat']!,
                        report.location['lng']!,
                      ),
                    );
                  },
                );
              })
            },
          ),
          // isLoading
          CustomInfoWindow(
            controller: _customInfoWindowController,
            width: 300,
            height: 250,
          )
        ],
      ),
    );
  }
}
