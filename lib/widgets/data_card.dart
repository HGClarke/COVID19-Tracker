import 'package:covid19_tracker/models/chart_data.dart';
import 'package:covid19_tracker/models/country_card_data.dart';
import 'package:covid19_tracker/models/covid_stats_choice.dart';
import 'package:covid19_tracker/models/data_page_args.dart';
import 'package:covid19_tracker/models/data_provider.dart';
import 'package:covid19_tracker/utilities/page_routes.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DataCard extends StatelessWidget {
  final int totalCases;
  final int newCases;
  final String topLabel;
  final String bottomLabel;
  final List<ChartData> history;
  final COVIDStatChoice choice;
  DataCard({
    this.totalCases = 0,
    this.newCases = 0,
    @required this.topLabel,
    @required this.bottomLabel,
    @required this.history,
    @required this.choice,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          final provider =
              Provider.of<COVIDDataProvider>(context, listen: false);
          final breakdowns = provider.stats.stats.breakdowns
              .where((v) => v.location.lat != null || v.location.long != null);
          var data;
          switch (choice) {
            case COVIDStatChoice.confirmed:
              data = breakdowns
                  .map(
                    (v) => CountryCardData(
                      v.location.countryOrRegion,
                      v.totalConfirmedCases,
                    ),
                  )
                  .toList();
              break;
            case COVIDStatChoice.deaths:
              data = breakdowns
                  .map(
                    (v) => CountryCardData(
                      v.location.countryOrRegion,
                      v.totalDeaths,
                    ),
                  )
                  .toList();
              break;
            case COVIDStatChoice.recovered:
              data = breakdowns
                  .map((v) => CountryCardData(
                      v.location.countryOrRegion, v.totalRecoveredCases))
                  .toList();

              break;
            default:
              data = [];
          }
          data.sort((CountryCardData a, CountryCardData b) =>
              b.number.compareTo(a.number));
          Navigator.pushNamed(
            context,
            PageRoutes.detailsPage,
            arguments: DetailsPageArguments(history, data, choice),
          );
        },
        child: Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$topLabel: $totalCases cases',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      '$bottomLabel: $newCases cases',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
