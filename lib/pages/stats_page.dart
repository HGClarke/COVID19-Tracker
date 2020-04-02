import 'package:covid19_tracker/models/breakdowns.dart';
import 'package:covid19_tracker/models/data_provider.dart';
import 'package:covid19_tracker/models/location.dart';
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
  Breakdowns countryData;

  @override
  void didChangeDependencies() {
    _getCountryData();
    super.didChangeDependencies();
  }

  void _getCountryData() async {
    final provider = COVIDDataProvider.of(context);
    final allStats = provider.stats.stats;
    if (provider.selectedIndex == -1) {
      countryData = Breakdowns(
        location: Location(countryOrRegion: 'Global'),
        totalConfirmedCases: allStats.totalConfirmedCases,
        totalRecoveredCases: allStats.totalRecoveredCases,
        totalDeaths: allStats.totalDeaths,
        newlyConfirmedCases: allStats.newlyConfirmedCases,
        newlyRecoveredCases: allStats.newlyRecoveredCases,
        newDeaths: allStats.newDeaths,
      );
    } else {
      final countryStatsInfo =
          provider.stats.stats.breakdowns[provider.selectedIndex];
      countryData = countryStatsInfo;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = COVIDDataProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          '${countryData.location.countryOrRegion}',
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
                      child: COVIDPieChart(countryData),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Last updated ${DateFormat("dd, MMM yyyy hh:mm a").format(DateTime.parse(provider.stats.updatedDateTime))}',
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
                              countryData.totalConfirmedCases,
                              countryData.newlyConfirmedCases,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            buildBox(
                              context,
                              "Recovered",
                              AppColors.salmon,
                              countryData.totalRecoveredCases,
                              countryData.newlyRecoveredCases,
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
                              countryData.totalDeaths,
                              countryData.newDeaths,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            buildBox(
                              context,
                              "Total",
                              AppColors.eggWhite,
                              countryData.totalConfirmedCases +
                                  countryData.totalDeaths +
                                  countryData.totalRecoveredCases,
                              countryData.newlyRecoveredCases +
                                  countryData.newDeaths +
                                  countryData.newlyConfirmedCases,
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
