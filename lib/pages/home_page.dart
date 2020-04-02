import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid19_tracker/models/covid_data.dart';
import 'package:covid19_tracker/models/data_provider.dart';

import 'package:covid19_tracker/services/networking.dart';
import 'package:covid19_tracker/utilities/api_service.dart';
import 'package:covid19_tracker/utilities/app_colors.dart';
import 'package:covid19_tracker/utilities/page_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final Firestore _db = Firestore.instance;

  @override
  void initState() {
    _registerPushNotifications();

    super.initState();
  }

  void _registerPushNotifications() {
    _fcm.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _fcm.onIosSettingsRegistered.listen((settings) {
      print('Settings registered $settings');
    });
    _fcm.getToken().then((String token) {
      if (token != null) {
        var tokens = _db.collection('tokens');
        tokens.document(token).setData({
          'token': token, // optional
          'platform': Platform.operatingSystem
        });
        print('Saved token $token');
      }
    });
  }

  @override
  void didChangeDependencies() {
    COVIDDataProvider data = COVIDDataProvider.of(context);
    if (!data.hasData) {
      getCovidStats(context).then(data.setData);
    }
    super.didChangeDependencies();
  }

  Future<COVID19Data> getCovidStats(BuildContext context) async {
    final networkService = NetworkService(
        APIService.baseDataURL + 'global', APIService.covidStatsHeaders);
    var data;
    try {
      final response = await networkService.fetchData();
      data = COVID19Data.fromJson(
        jsonDecode(
          response.body,
        ),
      );
    } catch (e) {
      print(e);
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.red,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'COVID-19 Tracker',
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(height: 10),
                Text(
                  "Select any option below",
                  style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: 32,
                ),
                Column(
                  children: <Widget>[
                    HomePageCard(
                      icon: FontAwesomeIcons.globe,
                      title: "Global Stats",
                      subtitle: "See global COVID-19 Data",
                      route: PageRoutes.globalStatsPage,
                      // args: StatsPageArgs('Global', 'global'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    HomePageCard(
                      icon: FontAwesomeIcons.globeAmericas,
                      title: "Countries",
                      subtitle: "See specific country data",
                      route: PageRoutes.countriesPage,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    HomePageCard(
                      icon: FontAwesomeIcons.newspaper,
                      title: "News",
                      subtitle: "Stay up-to-date",
                      route: PageRoutes.newsPage,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    HomePageCard(
                      icon: Icons.info,
                      title: "Info",
                      subtitle: "Learn more about COVID-19",
                      route: PageRoutes.infoPage,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePageCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String route;
  final args;

  HomePageCard({this.icon, this.title, this.subtitle, this.route, this.args});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: () {
              COVIDDataProvider.of(context, listen: false).setIndex(-1);
              Navigator.pushNamed(context, route, arguments: args);
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    5.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 32.0,
                    color: AppColors.teal,
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
