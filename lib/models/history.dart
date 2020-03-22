class History {
  String date;
  int confirmed;
  int deaths;
  int recovered;

  History({this.date, this.confirmed, this.deaths, this.recovered});

  History.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    confirmed = json['confirmed'];
    deaths = json['deaths'];
    recovered = json['recovered'];
  }
}
