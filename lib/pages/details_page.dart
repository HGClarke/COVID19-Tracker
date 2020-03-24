import 'package:covid19_tracker/models/chart_data.dart';
import 'package:covid19_tracker/models/covid_stats_choice.dart';
import 'package:covid19_tracker/models/data_page_args.dart';
import 'package:covid19_tracker/utilities/app_colors.dart';
import 'package:covid19_tracker/widgets/country_card_info.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'covid19_map.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final DetailsPageArguments args = ModalRoute.of(context).settings.arguments;
    String title = "";
    switch (args.statChoice) {
      case COVIDStatChoice.confirmed:
        title = "Confirmed";
        break;
      case COVIDStatChoice.recovered:
        title = "Recovered";
        break;
      case COVIDStatChoice.deaths:
        title = "Deaths";
    }
    var series = [
      charts.Series(
        domainFn: (ChartData data, _) => data.label,
        measureFn: (ChartData data, _) => data.count,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(AppColors.eggWhite),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.red,
          indicatorWeight: 4,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.info_outline,
              ),
            ),
            Tab(
              icon: Icon(Icons.map),
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
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
          ),
          COVIDMap(args.statChoice),
        ],
      ),
    );
  }
}
