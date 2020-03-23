import 'package:covid19_tracker/models/chart_data.dart';
import 'package:covid19_tracker/models/country_card_data.dart';

class DataPageArguments {
  final List<ChartData> chartData;
  final List<CountryCardData> globalData;
  DataPageArguments(this.chartData, this.globalData);
}
