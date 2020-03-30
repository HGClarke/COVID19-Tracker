import 'dart:convert';

import 'package:covid19_tracker/models/covid_data.dart';
import 'package:covid19_tracker/models/stats_page_args.dart';
import 'package:covid19_tracker/services/networking.dart';
import 'package:covid19_tracker/utilities/api_service.dart';
import 'package:covid19_tracker/utilities/app_colors.dart';
import 'package:covid19_tracker/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  COVID19Data countryData;

  @override
  void didChangeDependencies() {
    if (countryData == null) {
      _getCountryData();
    }
    super.didChangeDependencies();
  }

  void _getCountryData() async {
    final StatsPageArgs args = ModalRoute.of(context).settings.arguments;
    final networkService = NetworkService(
        APIService.baseDataURL + args.isoCode, APIService.covidStatsHeaders);

    try {
      final response = await networkService.fetchData();
      var data = COVID19Data.fromJson(jsonDecode(response.body));

      setState(() {
        countryData = data;
      });
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final StatsPageArgs args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          '${args.countryOrRegion}',
          style: Theme.of(context).textTheme.title.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: countryData == null
          ? Center(
              child: SpinKitFadingFour(
                color: AppColors.teal,
              ),
            )
          : SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 250,
                      child: COVIDPieChart(countryData.stats),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Last updated ${DateFormat("dd, MMM yyyy hh:mm a").format(DateTime.parse(countryData.updatedDateTime))}',
                      style: Theme.of(context).textTheme.title.copyWith(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            buildBox(
                              context,
                              "Confirmed",
                              AppColors.teal,
                              countryData.stats.totalConfirmedCases,
                              countryData.stats.newlyConfirmedCases,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            buildBox(
                              context,
                              "Recovered",
                              AppColors.salmon,
                              countryData.stats.totalRecoveredCases,
                              countryData.stats.newlyRecoveredCases,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            buildBox(
                              context,
                              "Deaths",
                              AppColors.yellow,
                              countryData.stats.totalDeaths,
                              countryData.stats.newDeaths,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            buildBox(
                              context,
                              "Total",
                              AppColors.eggWhite,
                              countryData.stats.totalConfirmedCases +
                                  countryData.stats.totalDeaths +
                                  countryData.stats.totalRecoveredCases,
                              countryData.stats.newlyRecoveredCases +
                                  countryData.stats.newDeaths +
                                  countryData.stats.newlyConfirmedCases,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildBox(BuildContext context, String title, Color color, int total,
      int newCases) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 8.0),
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
            SizedBox(
              height: 23.0,
            ),
            Text(
              '$total cases',
              style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
            ),
            SizedBox(height: 6),
            Text(
              '+ $newCases cases',
              style: Theme.of(context).textTheme.subtitle.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
