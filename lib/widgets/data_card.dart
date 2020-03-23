import 'package:covid19_tracker/models/chart_data.dart';
import 'package:covid19_tracker/models/data_page_args.dart';
import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  final int totalCases;
  final int newCases;
  final String topLabel;
  final String bottomLabel;
  final List<ChartData> history;
  DataCard({
    this.totalCases = 0,
    this.newCases = 0,
    @required this.topLabel,
    @required this.bottomLabel,
    @required this.history,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/data-page',
            arguments: DataPageArguments(history),
          );
        },
        child: Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$topLabel: $totalCases cases',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '$bottomLabel: $newCases cases',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
