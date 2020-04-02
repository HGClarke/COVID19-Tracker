import 'package:covid19_tracker/models/covid_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class COVIDDataProvider extends ChangeNotifier {
  COVID19Data _data;
  int _index;

  COVID19Data get stats => _data;
  bool get hasData => _data != null;
  int get selectedIndex => _index;
  static COVIDDataProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<COVIDDataProvider>(context, listen: listen);

  void setIndex(index) {
    _index = index;
    notifyListeners();
  }

  void setData(COVID19Data data) {
    _data = data;
    notifyListeners();
  }

  void resetData() {
    _data = null;
    notifyListeners();
  }
}
