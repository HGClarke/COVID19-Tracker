import 'package:covid19_tracker/constants.dart';
import 'package:covid19_tracker/models/covid_data.dart';
import 'package:covid19_tracker/services/networking.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_marker.dart';

class COVIDDataProvider extends ChangeNotifier {
  COVIDDataProvider() {
    _stats = COVID19Data();
    getCovidStats();
  }

  COVID19Data _stats;
  List<List<dynamic>> confirmedData = [];
  List<List<dynamic>> deathsData = [];
  List<List<dynamic>> recoveredData = [];
  List<ChartData> _dataPoints = [];
  List<Marker> _markers = [];

  List<ChartData> get dataPoints => _dataPoints;
  COVID19Data get stats => _stats;
  List<Marker> get markers => _markers;

  _parseCSV(url) async {
    final networkService = NetworkService(url);
    final response = await networkService.fetchData();
    List<List<dynamic>> data = [];
    if (response.statusCode == 200) {
      final parsedData = CsvToListConverter(eol: '\n').convert(response.body);
      data = parsedData;
      // print(calculateSum(parsedData));
      // getMarkers(parsedData);
    }
    return data;
  }

  void getCovidStats() async {
    confirmedData = await _parseCSV(kConfirmedURL);
    deathsData = await _parseCSV(kDeathsURL);
    recoveredData = await _parseCSV(kRecoveredURL);
    _stats = COVID19Data(
      confirmed: _calculateSum(confirmedData),
      deaths: _calculateSum(deathsData),
      recovered: _calculateSum(recoveredData),
    );
    notifyListeners();
  }

  int _calculateSum(covidData) {
    int columns = covidData[0].length;
    int sum = 0;

    for (int i = 1; i < covidData.length; i++) {
      sum += covidData[i][columns - 1];
    }
    return sum;
  }

  void createMarkers(data) {
    int countryIndex = 1;
    int latIndex = 2;
    int lonIndex = 3;
    List<MapMarker> markers = [];
    for (int i = 1; i < data.length; i++) {
      MapMarker marker = MapMarker(data[i][countryIndex],
          data[i][latIndex].toDouble(), data[i][lonIndex].toDouble());

      markers.add(marker);
    }
    _markers = markers.map<Marker>((marker) {
      return Marker(
          markerId: MarkerId(marker.id),
          position: LatLng(marker.lat, marker.lon),
          draggable: false);
    }).toList();
  }

  void createDataPoints(data) {
    int columns = data[0].length - 1;
    final numericalData = {};

    for (int i = 1; i < data.length; i++) {
      for (int j = 4; j <= columns; j++) {
        String date = data[0][j];
        numericalData[date] = (numericalData[date] ?? 0) + data[i][j].toInt();
      }
    }
    List<ChartData> dataPoints = [];
    for (var entry in numericalData.entries) {
      ChartData dataPoint =
          ChartData(entry.key.toString(), entry.value.toInt());

      dataPoints.add(dataPoint);
    }
    _dataPoints = dataPoints;
    notifyListeners();
  }
}
