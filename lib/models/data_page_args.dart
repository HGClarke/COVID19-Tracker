import 'package:covid19_tracker/models/chart_data.dart';
import 'package:covid19_tracker/models/country_card_data.dart';
import 'package:covid19_tracker/models/covid_stats_choice.dart';

class DetailPageArguments {
  final List<ChartData> chartData;
  final List<CountryCardData> globalData;
  final COVIDStatChoice statChoice;
  DetailPageArguments(this.chartData, this.globalData, this.statChoice);
}
