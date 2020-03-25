import 'dart:convert';

import 'package:covid19_tracker/models/chart_data.dart';
import 'package:covid19_tracker/models/covid_data.dart';
import 'package:covid19_tracker/models/covid_stats_choice.dart';
import 'package:covid19_tracker/models/data_provider.dart';
import 'package:covid19_tracker/models/history.dart';
import 'package:covid19_tracker/services/networking.dart';
import 'package:covid19_tracker/utilities/api_service.dart';
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
  void didChangeDependencies() {
    COVIDDataProvider data = COVIDDataProvider.of(context);
    if (!data.hasData) {
      getCovidStats(context).then(data.setData);
    }
    super.didChangeDependencies();
  }

  Future<COVID19Data> getCovidStats(BuildContext context) async {
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

  List<ChartData> _createChartData(
      List<History> history, COVIDStatChoice choice) {
    return history.map((History v) {
      ChartData data;
      switch (choice) {
        case COVIDStatChoice.confirmed:
          data = ChartData(
            label: v.date,
            count: v.confirmed,
          );
          break;
        case COVIDStatChoice.recovered:
          data = ChartData(
            label: v.date,
            count: v.recovered,
          );
          break;
        case COVIDStatChoice.deaths:
          data = ChartData(
            label: v.date,
            count: v.deaths,
          );
          break;
      }
      return data;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
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
            child: Consumer<COVIDDataProvider>(
              builder: (context, covidData, child) {
                if (!covidData.hasData) {
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
                } else {
                  final stats = covidData.stats.stats;
                  return Column(
                    children: [
                      COVIDPieChart(stats),
                      SizedBox(height: 10),
                      DataCard(
                        totalCases: covidData.stats.stats.totalConfirmedCases,
                        newCases: covidData.stats.stats.newlyConfirmedCases,
                        topLabel: 'Total Confirmed',
                        bottomLabel: "Newly Confirmed",
                        chartData: _createChartData(
                            stats.history, COVIDStatChoice.confirmed),
                        choice: COVIDStatChoice.confirmed,
                      ),
                      DataCard(
                        totalCases: stats.totalRecoveredCases,
                        newCases: stats.newlyRecoveredCases,
                        topLabel: 'Total Recovered',
                        bottomLabel: "Newly Recovered",
                        chartData: _createChartData(
                            stats.history, COVIDStatChoice.recovered),
                        choice: COVIDStatChoice.recovered,
                      ),
                      DataCard(
                        totalCases: stats.totalDeaths,
                        newCases: stats.newDeaths,
                        topLabel: 'Total Deaths',
                        bottomLabel: "New Deaths",
                        chartData: _createChartData(
                            stats.history, COVIDStatChoice.deaths),
                        choice: COVIDStatChoice.deaths,
                      ),
                    ],
                  );
                }
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(
          0xFFf0134d,
        ),
        onPressed: () {
          COVIDDataProvider covidData =
              COVIDDataProvider.of(context, listen: false);
          covidData.resetData();
        },
        child: Icon(
          Icons.autorenew,
          color: Colors.white,
        ),
      ),
    );
  }
}
