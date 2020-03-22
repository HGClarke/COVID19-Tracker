import 'package:covid19_tracker/models/stats.dart';

class COVID19Data {
  String updatedDateTime;
  Stats stats;

  COVID19Data({this.updatedDateTime, this.stats});

  COVID19Data.fromJson(Map<String, dynamic> json) {
    updatedDateTime = json['updatedDateTime'];
    stats = json['stats'] = Stats.fromJson(json['stats']);
  }
}
