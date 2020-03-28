import 'package:covid19_tracker/models/data_provider.dart';
import 'package:covid19_tracker/utilities/app_colors.dart';
import 'package:covid19_tracker/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GlobalStatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = COVIDDataProvider.of(context).stats;
    var formattedDate = DateFormat("dd, MMM yyyy hh:mm a")
        .format(DateTime.parse(data.updatedDateTime));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          'Global Stats',
          style: Theme.of(context).textTheme.title.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 250,
                child: COVIDPieChart(data.stats),
              ),
              SizedBox(height: 10),
              Text(
                'Last updated $formattedDate',
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
                        data.stats.totalConfirmedCases,
                        data.stats.newlyConfirmedCases,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      buildBox(
                        context,
                        "Recovered",
                        AppColors.salmon,
                        data.stats.totalRecoveredCases,
                        data.stats.newlyRecoveredCases,
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
                        data.stats.totalDeaths,
                        data.stats.newDeaths,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      buildBox(
                        context,
                        "Total",
                        AppColors.eggWhite,
                        data.stats.totalConfirmedCases +
                            data.stats.totalDeaths +
                            data.stats.totalRecoveredCases,
                        data.stats.newlyRecoveredCases +
                            data.stats.newDeaths +
                            data.stats.newlyConfirmedCases,
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
