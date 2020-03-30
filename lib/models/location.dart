class Location {
  double long;
  String countryOrRegion;
  Null provinceOrState;
  Null county;
  String isoCode;
  double lat;

  Location(
      {this.long,
      this.countryOrRegion,
      this.provinceOrState,
      this.county,
      this.isoCode,
      this.lat});

  Location.fromJson(Map<String, dynamic> json) {
    long = json['long'];
    countryOrRegion = json['countryOrRegion'];
    isoCode = json['isoCode'];
    lat = json['lat'];
  }
}
