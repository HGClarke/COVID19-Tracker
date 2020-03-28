import 'package:covid19_tracker/models/breakdowns.dart';
import 'package:covid19_tracker/models/data_provider.dart';
import 'package:covid19_tracker/models/stats_page_args.dart';
import 'package:covid19_tracker/utilities/app_colors.dart';
import 'package:covid19_tracker/utilities/page_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CountriesPage extends StatefulWidget {
  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<Breakdowns> breakdowns, _filteredBreakdowns;

  @override
  void didChangeDependencies() {
    if (breakdowns == null) {
      breakdowns = COVIDDataProvider.of(context)
          .stats
          .stats
          .breakdowns
          .where((v) =>
              v.location.lat != null &&
              v.location.long != null &&
              v.location.isoCode != null)
          .toList();
      setState(() {
        _filteredBreakdowns = breakdowns;
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // var _filteredBreakdowns = COVIDDataProvider.of(context)
    //     .stats
    //     .stats
    //     .breakdowns
    //     .where((v) =>
    //         v.location.lat != null &&
    //         v.location.long != null &&
    //         v.location.isoCode != null)
    //     .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Countries',
          style: Theme.of(context).textTheme.title.copyWith(
                color: Colors.white,
              ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: _filteredBreakdowns == null
          ? Center(
              child: SpinKitFadingFour(color: AppColors.teal),
            )
          : Container(
              margin: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      hintStyle: Theme.of(context).textTheme.title.copyWith(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                    ),
                    controller: _textEditingController,
                    onChanged: (text) {
                      setState(
                        () {
                          _filteredBreakdowns = breakdowns
                              .where((v) =>
                                  v.location.lat != null &&
                                  v.location.long != null &&
                                  v.location.isoCode != null &&
                                  v.location.countryOrRegion
                                      .toLowerCase()
                                      .contains(text.trim()))
                              .toList();
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredBreakdowns.length,
                      itemBuilder: (context, index) {
                        final breakdown = _filteredBreakdowns[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              PageRoutes.statsPage,
                              arguments: StatsPageArgs(
                                  breakdown.location.countryOrRegion,
                                  breakdown.location.isoCode),
                            );
                          },
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '${breakdown.location.countryOrRegion}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .title
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                ),
                                Icon(Icons.arrow_forward)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
