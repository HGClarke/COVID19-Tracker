import 'dart:convert';
import 'package:covid19_tracker/models/chart_data.dart';
import 'package:covid19_tracker/models/covid_data.dart';
import 'package:covid19_tracker/models/covid_stat_choice.dart';
import 'package:covid19_tracker/models/data_provider.dart';
import 'package:covid19_tracker/models/history.dart';
import 'package:covid19_tracker/models/stats_page_args.dart';
import 'package:covid19_tracker/services/networking.dart';
import 'package:covid19_tracker/utilities/api_service.dart';
import 'package:covid19_tracker/utilities/app_colors.dart';
import 'package:covid19_tracker/utilities/page_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    final networkService = NetworkService(
        APIService.baseDataURL + 'global', APIService.covidStatsHeaders);
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
      // backgroundColor: AppColors.red,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'COVID-19 Tracker',
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(height: 10),
                Text(
                  "Select any option below",
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: 32,
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        createItem(
                          context,
                          FontAwesomeIcons.globe,
                          "Global Stats",
                          "See Global COVID-19 Data",
                          PageRoutes.globalStatsPage,
                          args: StatsPageArgs(
                            'Global',
                            'global',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        createItem(
                          context,
                          FontAwesomeIcons.globeAmericas,
                          "Countries",
                          "See specific country data",
                          PageRoutes.countriesPage,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        createItem(
                          context,
                          FontAwesomeIcons.newspaper,
                          "News",
                          "Stay up-to-date",
                          PageRoutes.newsPage,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        createItem(
                          context,
                          Icons.info,
                          "Info",
                          "Learn more about COVID-19",
                          PageRoutes.home,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        createItem(
                          context,
                          FontAwesomeIcons.solidFrown,
                          "Symptoms/Prevention",
                          "Learn how to stay safe",
                          PageRoutes.home,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.salmon,
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

  Widget createItem(BuildContext context, IconData icon, String title,
      String subtitle, String route,
      {args}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route, arguments: args);
        },
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                color: AppColors.teal,
              ),
              SizedBox(
                height: 24.0,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white,
                    ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
