import 'package:covid19_tracker/models/location.dart';

class Breakdowns {
  Location location;
  int totalConfirmedCases;
  int newlyConfirmedCases;
  int totalDeaths;
  int newDeaths;
  int totalRecoveredCases;
  int newlyRecoveredCases;

  Breakdowns(
      {this.location,
      this.totalConfirmedCases,
      this.newlyConfirmedCases,
      this.totalDeaths,
      this.newDeaths,
      this.totalRecoveredCases,
      this.newlyRecoveredCases});

  Breakdowns.fromJson(Map<String, dynamic> json) {
    location = Location.fromJson(json['location']);
    totalConfirmedCases = json['totalConfirmedCases'];
    newlyConfirmedCases = json['newlyConfirmedCases'];
    totalDeaths = json['totalDeaths'];
    newDeaths = json['newDeaths'];
    totalRecoveredCases = json['totalRecoveredCases'];
    newlyRecoveredCases = json['newlyRecoveredCases'];
  }
}
