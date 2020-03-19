import 'package:covid19_tracker/models/covid_data.dart';
import 'package:covid19_tracker/pages/covid19_map.dart';
import 'package:covid19_tracker/pages/data_page.dart';
import 'package:covid19_tracker/services/networking.dart';
import 'package:csv/csv.dart';
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
  COVID19Data covidData = COVID19Data();

  @override
  void initState() {
    super.initState();
    getCovidStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COVID-19 Tracker',
        ),
      ),
      body: SafeArea(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            // color: Colors.white,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: <Widget>[
                ListTile(
                  onTap: () async {
                    final data = await parseCSV(kConfirmedURL);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StatsPage('Confirmed Data', data),
                      ),
                    );
                  },
                  title: Text(
                    'Confirmed Cases: ${covidData.confirmed}',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                ListTile(
                  onTap: () async {
                    final data = await parseCSV(kConfirmedURL);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => COVIDMap(data: data),
                      ),
                    );
                  },
                  title: Text(
                    'Recovered: ${covidData.recovered}',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                ListTile(
                  onTap: () async {
                    final data = await parseCSV(kConfirmedURL);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => COVIDMap(data: data),
                      ),
                    );
                  },
                  title: Text(
                    'Deaths: ${covidData.deaths}',
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
              ],
            )),
      ),
    );
  }

//             )
  Future<List<List<dynamic>>> parseCSV(url) async {
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

  getCovidStats() async {
    final confirmedData = await parseCSV(kConfirmedURL);
    final deathsData = await parseCSV(kDeathsURL);
    final recoveredData = await parseCSV(kRecoveredURL);
    int totalConfirmedCases = calculateSum(confirmedData);
    int totalDeaths = calculateSum(deathsData);
    int totalRecovered = calculateSum(recoveredData);
    setState(() {
      covidData = COVID19Data(
          deaths: totalDeaths,
          confirmed: totalConfirmedCases,
          recovered: totalRecovered);
    });
  }

  int calculateSum(data) {
    int columns = data[0].length;
    int sum = 0;

    for (int i = 1; i < data.length; i++) {
      sum += data[i][columns - 1];
    }
    return sum;
  }
}
