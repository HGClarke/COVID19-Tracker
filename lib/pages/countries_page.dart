import 'package:covid19_tracker/models/data_provider.dart';

import 'package:flutter/material.dart';

class CountriesPage extends StatefulWidget {
  @override
  _CountriesPageState createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  @override
  Widget build(BuildContext context) {
    var _filteredBreakdowns = COVIDDataProvider.of(context)
        .stats
        .stats
        .breakdowns
        .where((v) => v.location.lat != null && v.location.long != null)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries'),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        margin: const EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: _filteredBreakdowns.length,
                itemBuilder: (context, index) {
                  final breakdown = _filteredBreakdowns[index];
                  return Container(
                    height: 50,
                    margin: const EdgeInsets.all(6),
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
                          style: Theme.of(context).textTheme.title.copyWith(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                        ),
                        Icon(Icons.arrow_forward)
                      ],
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
