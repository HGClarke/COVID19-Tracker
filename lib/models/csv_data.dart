import 'package:flutter/material.dart';

class CSVData extends ChangeNotifier {
  final data;
  CSVData(this.data);
  int _totalDeaths = 0;
  int _totalRecovered = 0;
  int _totalCases = 0;
}
