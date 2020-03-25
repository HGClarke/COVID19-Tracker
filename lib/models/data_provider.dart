import 'package:covid19_tracker/models/covid_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class COVIDDataProvider extends ChangeNotifier {
  COVID19Data _data;
  // List<ChartData> _dataPoints = [];

  // List<ChartData> get dataPoints => _dataPoints;
  COVID19Data get stats => _data;
  bool get hasData => _data != null;

  static COVIDDataProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<COVIDDataProvider>(context, listen: listen);

  void setData(COVID19Data data) {
    _data = data;
    notifyListeners();
  }

  void resetData() {
    _data = null;
    notifyListeners();
  }
}
