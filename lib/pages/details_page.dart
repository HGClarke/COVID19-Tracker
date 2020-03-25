import 'package:covid19_tracker/models/covid_stats_choice.dart';
import 'package:covid19_tracker/models/data_page_args.dart';
import 'package:covid19_tracker/pages/info_tab.dart';
import 'package:covid19_tracker/utilities/app_colors.dart';
import 'package:flutter/material.dart';

import 'covid19_map.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

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
    final DetailPageArguments args = ModalRoute.of(context).settings.arguments;
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
          InfoTab(),
          COVIDMap(args.statChoice),
        ],
      ),
    );
  }
}
