import 'package:covid19_tracker/pages/details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/data_provider.dart';
import 'pages/home_page.dart';
import 'utilities/page_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => COVIDDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        initialRoute: PageRoutes.home,
        routes: {
          PageRoutes.home: (context) => HomePage(),
          PageRoutes.detailsPage: (context) => DetailsPage(),
        },
      ),
    );
  }
}
