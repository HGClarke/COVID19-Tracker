import 'package:covid19_tracker/models/chart_data.dart';
import 'package:covid19_tracker/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class COVIDPieChart extends StatelessWidget {
  final stats;
  const COVIDPieChart(this.stats);
  @override
  Widget build(BuildContext context) {
    final dataPoints = [
      ChartData(
        label: "Confirmed",
        count: stats.totalConfirmedCases,
        color: AppColors.teal,
      ),
      ChartData(
        label: "Recovered",
        count: stats.totalRecoveredCases,
        color: AppColors.salmon,
      ),
      ChartData(
        label: "Deaths",
        count: stats.totalDeaths,
        color: AppColors.yellow,
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
      ),
    ];
    return charts.PieChart(
      series,
      animate: false,
      behaviors: [
        charts.DatumLegend(
          entryTextStyle: charts.TextStyleSpec(
            color: charts.MaterialPalette.white,
            fontSize: 16,
          ),
          position: charts.BehaviorPosition.end,
          outsideJustification: charts.OutsideJustification.middleDrawArea,
        )
      ],
    );
  }
}
