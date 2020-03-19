import 'package:covid19_tracker/models/covid_data.dart';
import 'package:covid19_tracker/pages/data_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/data_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => COVIDDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomePage(),
      ),
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
    // getCovidStats();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<COVIDDataProvider>(context);
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
                onTap: () {
                  provider.createDataPoints(provider.confirmedData);
                  provider.createMarkers(provider.confirmedData);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => StatsPage('Confirmed Cases')));
                },
                title: Text(
                  'Confirmed Cases: ${provider.stats.confirmed}',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
              Divider(color: Colors.white),
              ListTile(
                onTap: () {
                  provider.createDataPoints(provider.recoveredData);
                  provider.createMarkers(provider.recoveredData);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => StatsPage('Recovery Data')));
                },
                title: Text(
                  'Recovered: ${provider.stats.recovered}',
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
                onTap: () {
                  provider.createDataPoints(provider.deathsData);
                  provider.createMarkers(provider.deathsData);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => StatsPage('Deaths')));
                },
                title: Text(
                  'Deaths: ${provider.stats.deaths}',
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
          ),
        ),
      ),
    );
  }
}

// class COVIDStatsTile extends StatelessWidget {
//   final int total;
//   final String text;
//   COVIDStatsTile(this.text, this.total);
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
