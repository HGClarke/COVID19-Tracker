import 'dart:convert';

import 'package:covid19_tracker/models/api_service.dart';
import 'package:covid19_tracker/models/covid_data.dart';
import 'package:covid19_tracker/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_marker.dart';

class COVIDDataProvider extends ChangeNotifier {
  COVIDDataProvider() {
    // _data = COVID19Data();
    getCovidStats();
  }

  COVID19Data _data;
  // List<ChartData> _dataPoints = [];
  List<Marker> _markers = [];

  // List<ChartData> get dataPoints => _dataPoints;
  COVID19Data get stats => _data;
  List<Marker> get markers => _markers;

  void getCovidStats() async {
    final networkService = NetworkService(APIService.globalDataURL);
    final response = await networkService.fetchData();
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      _data = COVID19Data.fromJson(jsonData);
    }
    notifyListeners();
  }

  void createMarkers() {
    final breakdowns = _data.stats.breakdowns;
    List<MapMarker> markers = [];
    for (var breakdown in breakdowns) {
      MapMarker marker = MapMarker(breakdown.location.countryOrRegion,
          breakdown.location.lat, breakdown.location.long);
      markers.add(marker);
    }

    _markers = markers.map<Marker>((marker) {
      return Marker(
          markerId: MarkerId(marker.id),
          position: LatLng(marker.lat, marker.lon),
          draggable: false,
          onTap: () {
            print(marker.country);
          });
    }).toList();
    notifyListeners();
  }
}
