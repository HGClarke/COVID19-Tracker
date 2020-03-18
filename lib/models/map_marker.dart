import 'package:uuid/uuid.dart';

class MapMarker {
  final double lat;
  final double lon;
  final String country;
  final markerID = Uuid().v4();

  MapMarker(this.country, this.lat, this.lon);

  @override
  String toString() {
    return "Country: $country, Latitude: $lat, Longitude: $lon";
  }
}
