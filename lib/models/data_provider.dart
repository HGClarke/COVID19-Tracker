import 'dart:convert';
import 'package:covid19_tracker/models/api_service.dart';
import 'package:covid19_tracker/models/chart_data.dart';
import 'package:covid19_tracker/models/covid_data.dart';
import 'package:covid19_tracker/services/networking.dart';
import 'package:flutter/material.dart';

class COVIDDataProvider extends ChangeNotifier {
  COVIDDataProvider() {
    updateData();
  }

  COVID19Data _data;
  // List<ChartData> _dataPoints = [];

  // List<ChartData> get dataPoints => _dataPoints;
  COVID19Data get stats => _data;
  List<ChartData> get confirmedHistory => _confirmedCaseHistory;
  List<ChartData> get deathsHistory => _deathsHistory;
  List<ChartData> get recoveredHistory => _recoveredHistory;

  List<ChartData> _confirmedCaseHistory;
  List<ChartData> _deathsHistory;
  List<ChartData> _recoveredHistory;
  Future<COVID19Data> getCovidStats() async {
    final networkService = NetworkService(APIService.globalDataURL);
    var data;
    try {
      final response = await networkService.fetchData();
      data = COVID19Data.fromJson(
        jsonDecode(
          response.body,
        ),
      );
    } catch (e) {
      print(e);
    }

    return data;
  }

  void updateData() async {
    _data = await getCovidStats();
    mapConfirmedHistory();
    mapRecoveredHistory();
    mapDeathsHistory();
    notifyListeners();
  }

  void mapConfirmedHistory() {
    _confirmedCaseHistory = _data.stats.history
        .map<ChartData>(
          (v) => ChartData(
            label: v.date,
            count: v.confirmed,
          ),
        )
        .toList();
  }

  void mapDeathsHistory() {
    _deathsHistory = _data.stats.history
        .map(
          (v) => ChartData(
            label: v.date,
            count: v.deaths,
          ),
        )
        .toList();
  }

  void mapRecoveredHistory() {
    _recoveredHistory = _data.stats.history
        .map(
          (v) => ChartData(
            label: v.date,
            count: v.recovered,
          ),
        )
        .toList();
  }
}
