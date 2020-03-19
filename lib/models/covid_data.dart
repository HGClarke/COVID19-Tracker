class COVID19Data {
  final int confirmed;
  final int recovered;
  final int deaths;

  COVID19Data({this.confirmed = 0, this.recovered = 0, this.deaths = 0});
}

abstract class COVIDData {
  String date;
  int total;
  COVIDData() {
    this.total = 0;
    this.date = DateTime.now().toString();
  }
  COVIDData.withArgumentConstructor(String date, int total) {
    this.date = date;
    this.total = total;
  }
}

class ChartData extends COVIDData {
  ChartData(String date, int total)
      : super.withArgumentConstructor(date, total);
}

class COVIDRecoveryData extends COVIDData {
  COVIDRecoveryData(String date, int total)
      : super.withArgumentConstructor(date, total);
}

class COVIDDeathsData extends COVIDData {
  COVIDDeathsData(String date, int total)
      : super.withArgumentConstructor(date, total);
}

class COVIDConfirmedData extends COVIDData {
  COVIDConfirmedData(String date, int total)
      : super.withArgumentConstructor(date, total);
}
