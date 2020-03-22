import 'package:covid19_tracker/models/breakdowns.dart';
import 'package:covid19_tracker/models/history.dart';

class Stats {
  int totalConfirmedCases;
  int newlyConfirmedCases;
  int totalDeaths;
  int newDeaths;
  int totalRecoveredCases;
  int newlyRecoveredCases;
  List<History> history;
  List<Breakdowns> breakdowns;

  Stats(
      {this.totalConfirmedCases = 0,
      this.newlyConfirmedCases,
      this.totalDeaths,
      this.newDeaths,
      this.totalRecoveredCases,
      this.newlyRecoveredCases,
      this.history,
      this.breakdowns});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      totalConfirmedCases: json['totalConfirmedCases'],
      newlyConfirmedCases: json['newlyConfirmedCases'],
      totalDeaths: json['totalDeaths'],
      newDeaths: json['newDeaths'],
      totalRecoveredCases: json['totalRecoveredCases'],
      newlyRecoveredCases: json['newlyRecoveredCases'],
      history: json['history']
          .map<History>(
            (v) => History.fromJson(v),
          )
          .toList(),
      breakdowns: json['breakdowns']
          .map<Breakdowns>(
            (v) => Breakdowns.fromJson(v),
          )
          .toList(),
    );

    // if (json['history'] != null) {
    //   history = List<History>();
    //   json['history'].forEach((v) {
    //     history.add(History.fromJson(v));
    //   });
    // }
    // if (json['breakdowns'] != null) {
    //   breakdowns = List<Breakdowns>();
    //   json['breakdowns'].forEach((v) {
    //     breakdowns.add(Breakdowns.fromJson(v));
    //   });
    // }
  }
}
