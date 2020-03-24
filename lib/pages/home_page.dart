import 'package:covid19_tracker/models/covid_data.dart';
import 'package:covid19_tracker/models/covid_stats_choice.dart';
import 'package:covid19_tracker/models/data_provider.dart';
import 'package:covid19_tracker/widgets/data_card.dart';
import 'package:covid19_tracker/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static bool _didBuild = false;

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
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.none ||
                  (snapshot.connectionState == ConnectionState.waiting &&
                      _didBuild == false)) {
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
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'An error has occurred',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              }
              final data = snapshot.data;
              _didBuild = true;
              return Column(
                children: [
                  COVIDPieChart(data.stats),
                  SizedBox(height: 10),
                  DataCard(
                    totalCases: data.stats.totalConfirmedCases,
                    newCases: data.stats.newlyConfirmedCases,
                    topLabel: 'Total Confirmed',
                    bottomLabel: "Newly Confirmed",
                    history: provider.confirmedHistory,
                    choice: COVIDStatChoice.confirmed,
                  ),
                  DataCard(
                    totalCases: data.stats.totalRecoveredCases,
                    newCases: data.stats.newlyRecoveredCases,
                    topLabel: 'Total Recovered',
                    bottomLabel: "Newly Recovered",
                    history: provider.recoveredHistory,
                    choice: COVIDStatChoice.recovered,
                  ),
                  DataCard(
                    totalCases: data.stats.totalDeaths,
                    newCases: data.stats.newDeaths,
                    topLabel: 'Total Deaths',
                    bottomLabel: "New Deaths",
                    history: provider.deathsHistory,
                    choice: COVIDStatChoice.deaths,
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(
          0xFFf0134d,
        ),
        onPressed: () {
          _didBuild = false;

          Provider.of<COVIDDataProvider>(context, listen: false).updateData();
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
