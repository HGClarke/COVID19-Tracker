import 'package:covid19_tracker/models/chart_data.dart';

import 'package:covid19_tracker/models/data_page_args.dart';
import 'package:covid19_tracker/utilities/app_colors.dart';
import 'package:covid19_tracker/widgets/country_card_info.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class InfoTab extends StatelessWidget {
  Widget build(BuildContext context) {
    final DetailPageArguments args = ModalRoute.of(context).settings.arguments;
    var series = [
      charts.Series<ChartData, DateTime>(
        domainFn: (ChartData data, _) => DateTime.parse(data.label),
        measureFn: (ChartData data, _) => data.count,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(AppColors.eggWhite),
        id: 'Clicks',
        data: args.chartData,
      ),
    ];

    var chart = charts.TimeSeriesChart(
      series,
      animate: false,
      // domainAxis: charts.OrdinalAxisSpec(
      //   renderSpec: charts.NoneRenderSpec(),
      // ),
      // defaultInteractions: false,
      behaviors: [],
      domainAxis: charts.EndPointsTimeAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelOffsetFromAxisPx: 18,
          labelStyle: charts.TextStyleSpec(
            color: charts.ColorUtil.fromDartColor(
              AppColors.eggWhite,
            ),
            fontSize: 15,
          ),
        ),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec:
            charts.BasicNumericTickProviderSpec(desiredTickCount: 8),
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 15,
            color: charts.ColorUtil.fromDartColor(AppColors.eggWhite),
          ),
          lineStyle: charts.LineStyleSpec(
            color: charts.ColorUtil.fromDartColor(AppColors.eggWhite),
          ),
        ),
      ),
    );

    var chartWidget = Padding(
      padding: EdgeInsets.all(32.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: chart,
      ),
    );
    var countryCards = args.globalData.map(
      (v) {
        return CountryInfoCard(v);
      },
    ).toList();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: chartWidget,
          ),
          GridView.count(
            shrinkWrap: true,
            mainAxisSpacing: 2,
            childAspectRatio: 1.3,
            physics: ScrollPhysics(),
            crossAxisCount: 2,
            children: countryCards,
          ),
        ],
      ),
    );
  }
}
