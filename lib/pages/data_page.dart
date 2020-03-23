import 'package:covid19_tracker/models/chart_data.dart';
import 'package:covid19_tracker/models/data_page_args.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DataPageArguments args = ModalRoute.of(context).settings.arguments;
    var series = [
      charts.Series(
        domainFn: (ChartData data, _) => data.label,
        measureFn: (ChartData data, _) => data.count,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFf5f0e3)),
        id: 'Clicks',
        data: args.chartData,
      ),
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 15,
            color: charts.ColorUtil.fromDartColor(Color(0xFFf5f0e3)),
          ),
          lineStyle: charts.LineStyleSpec(
            color: charts.MaterialPalette.white,
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
    // return Scaffold(
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: chartWidget,
            )
          ]),
        ),
      ),
    );
  }
}
