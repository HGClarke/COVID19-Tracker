import 'package:covid19_tracker/pages/data_page.dart';
import 'package:covid19_tracker/widgets/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/data_provider.dart';
import 'widgets/data_card.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => COVIDDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<COVIDDataProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 40,
          ),
          // color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              COVIDPieChart(),
              SizedBox(height: 10),
              DataCard(
                totalCases: provider.stats.stats.totalConfirmedCases,
                newCases: provider.stats.stats.newlyConfirmedCases,
                topLabel: 'Total Confirmed',
                bottomLabel: "Newly Confirmed",
              ),
              DataCard(
                totalCases: provider.stats.stats.totalRecoveredCases,
                newCases: provider.stats.stats.newlyRecoveredCases,
                topLabel: 'Total Recovered',
                bottomLabel: "Newly Recovered",
              ),
              DataCard(
                totalCases: provider.stats.stats.totalDeaths,
                newCases: provider.stats.stats.newDeaths,
                topLabel: 'Total Deaths',
                bottomLabel: "New Deaths",
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(
          0xFFf0134d,
        ),
        onPressed: () {
          Provider.of<COVIDDataProvider>(context, listen: false)
              .getCovidStats();
        },
        child: Icon(
          Icons.autorenew,
          color: Colors.white,
        ),
      ),
    );
  }
}
