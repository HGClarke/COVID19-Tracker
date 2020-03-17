import 'package:covid19_tracker/services/networking.dart';
import 'package:csv/csv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<dynamic>> myData = [];

  @override
  Widget build(BuildContext context) {
    parseCSV(kConfirmedURL);
    parseCSV(kRecoveredURL);
    parseCSV(kDeathsURL);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COVID-19 Tracker',
        ),
      ),
    );
  }

  int calculateSum(data) {
    int columns = data[0].length;
    int sum = 0;
    for (int i = 1; i < data.length; i++) {
      sum += data[i][columns - 1];
    }
    return sum;
  }

  parseCSV(url) async {
    final networkService = NetworkService(url);
    final response = await networkService.fetchData();
    if (response.statusCode == 200) {
      final parsedData = CsvToListConverter().convert(response.body);
      print(calculateSum(parsedData));
    }
  }
}
