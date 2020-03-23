import 'package:covid19_tracker/models/covid_data.dart';
import 'package:covid19_tracker/models/data_provider.dart';
import 'package:covid19_tracker/widgets/data_card.dart';
import 'package:covid19_tracker/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<COVIDDataProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 40,
          ),
          // color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<COVID19Data>(
            future: provider.getCovidStats(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final stats = snapshot.data.stats;
                  return Column(
                    children: <Widget>[
                      COVIDPieChart(),
                      SizedBox(height: 10),
                      DataCard(
                        totalCases: stats.totalConfirmedCases,
                        newCases: stats.newlyConfirmedCases,
                        topLabel: 'Total Confirmed',
                        bottomLabel: "Newly Confirmed",
                        history: provider.confirmedHistory,
                      ),
                      DataCard(
                        totalCases: stats.totalRecoveredCases,
                        newCases: stats.newlyRecoveredCases,
                        topLabel: 'Total Recovered',
                        bottomLabel: "Newly Recovered",
                        history: provider.recoveredHistory,
                      ),
                      DataCard(
                        totalCases: stats.totalDeaths,
                        newCases: stats.newDeaths,
                        topLabel: 'Total Deaths',
                        bottomLabel: "New Deaths",
                        history: provider.deathsHistory,
                      ),
                    ],
                  );
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SpinKitCircle(
                          color: Color(
                            0xFFf0134d,
                          ),
                          size: 80,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Loading data...',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                  break;
                case ConnectionState.none:
                  return Center(
                    child: Text(
                      'No connection found. Please try again.',
                    ),
                  );
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'An error has occured. Please check your connection',
                      ),
                    );
                  } else {
                    return Container();
                  }
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(
          0xFFf0134d,
        ),
        onPressed: () {
          Provider.of<COVIDDataProvider>(context, listen: false)
              .getCovidStats();
          // Navigator.pu
        },
        child: Icon(
          Icons.autorenew,
          color: Colors.white,
        ),
      ),
    );
  }
}
