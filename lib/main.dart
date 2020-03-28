import 'package:covid19_tracker/models/news_data_provider.dart';
import 'package:covid19_tracker/pages/countries_page.dart';
import 'package:covid19_tracker/pages/stats_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'models/data_provider.dart';
import 'pages/home_page.dart';
import 'pages/news.dart';
import 'utilities/page_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => COVIDDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        ),
        initialRoute: PageRoutes.home,
        routes: {
          PageRoutes.home: (context) => HomePage(),
          PageRoutes.globalStatsPage: (context) => StatsPage(),
          PageRoutes.newsPage: (context) => NewsPage(),
          PageRoutes.countriesPage: (context) => CountriesPage(),
          PageRoutes.statsPage: (context) => StatsPage(),
        },
      ),
    );
  }
}
