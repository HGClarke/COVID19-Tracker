import 'package:covid19_tracker/models/chart_data.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class COVIDPieChart extends StatelessWidget {
  final stats;
  COVIDPieChart(this.stats);
  @override
  Widget build(BuildContext context) {
    final dataPoints = [
      ChartData(
        label: "Confirmed",
        count: stats.totalConfirmedCases,
        color: Color(0xFFf0134d),
      ),
      ChartData(
        label: "Recovered",
        count: stats.totalRecoveredCases,
        color: Color(0XFFff6f5e),
      ),
      ChartData(
        label: "Deaths",
        count: stats.totalDeaths,
        color: Color(
          0xFFffd31d,
        ),
      ),
    ];
    final series = [
      charts.Series<ChartData, String>(
          id: 'CumulativeData',
          domainFn: (ChartData chartData, _) => chartData.label,
          measureFn: (ChartData chartData, _) => chartData.count,
          colorFn: (ChartData chartData, _) =>
              charts.ColorUtil.fromDartColor(chartData.color),
          data: dataPoints,
          labelAccessorFn: (ChartData chartData, _) => '${chartData.count}'),
    ];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: charts.PieChart(
        series,
        animate: true,
        behaviors: [
          charts.DatumLegend(
            entryTextStyle: charts.TextStyleSpec(
              color: charts.MaterialPalette.white,
              fontSize: 16,
            ),
            position: charts.BehaviorPosition.bottom,
            outsideJustification: charts.OutsideJustification.middleDrawArea,
            // horizontalFirst: false,
            // desiredMaxRows: 2,
          )
        ],
        defaultRenderer: charts.ArcRendererConfig(
          arcWidth: 80,
        ),
      ),
    );
  }
}
