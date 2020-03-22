import 'package:covid19_tracker/models/breakdowns.dart';
import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  int totalCases;
  int newCases;
  String topLabel;
  String bottomLabel;
  List<Breakdowns> breakdowns = [];
  DataCard({
    this.totalCases = 0,
    this.newCases = 0,
    @required this.topLabel,
    @required this.bottomLabel,
    this.breakdowns,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          print('Tapped');
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
