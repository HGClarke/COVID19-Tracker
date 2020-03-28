import 'package:covid19_tracker/models/breakdowns.dart';
import 'package:flutter/material.dart';

class StatsPageArgs {
  final String isoCode;

  final String countryOrRegion;
  StatsPageArgs(this.countryOrRegion, this.isoCode);
}
