import 'package:covid19_tracker/models/breakdowns.dart';
import 'package:covid19_tracker/models/data_provider.dart';
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
    if (COVIDDataProvider.of(context).hasData) {
      breakdowns =
          COVIDDataProvider.of(context).stats.stats.breakdowns.toList();
      setState(() {
        _filteredBreakdowns = breakdowns;
        _filteredBreakdowns
            .sort((a, b) => b.totalDeaths.compareTo(a.totalDeaths));
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                    style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                        ),
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
                              .where((v) => v.location.countryOrRegion
                                  .toLowerCase()
                                  .contains(text.trim().toLowerCase()))
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
                            final provider =
                                COVIDDataProvider.of(context, listen: false);

                            final actualIndex = provider.stats.stats.breakdowns
                                .indexOf(breakdown);
                            provider.setIndex(actualIndex);
                            Navigator.pushNamed(
                              context,
                              PageRoutes.statsPage,
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
