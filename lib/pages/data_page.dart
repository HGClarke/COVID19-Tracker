import 'package:covid19_tracker/models/covid_data.dart';
import 'package:covid19_tracker/models/data_provider.dart';
import 'package:covid19_tracker/pages/covid19_map.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';

class StatsPage extends StatefulWidget {
  final title;
  StatsPage(this.title);
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<COVIDDataProvider>(context);
    var data = provider.dataPoints;

    var series = [
      charts.Series(
        domainFn: (ChartData data, _) => data.date,
        measureFn: (ChartData data, _) => data.total,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(Theme.of(context).accentColor),
        id: 'Clicks',
        data: data,
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
            color:
                charts.ColorUtil.fromDartColor(Theme.of(context).accentColor),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          tabs: [
            Tab(
              icon: Icon(
                Icons.show_chart,
              ),
            ),
            Tab(
              icon: Icon(Icons.map),
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          chartWidget,
          COVIDMap(),
        ],
      ),
    );
  }
}
