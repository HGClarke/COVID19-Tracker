import 'dart:async';

import 'package:covid19_tracker/models/map_marker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants.dart';

class COVIDMap extends StatefulWidget {
  final String url;
  final data;
  COVIDMap({this.url = kConfirmedURL, @required this.data});
  @override
  _COVIDMapState createState() => _COVIDMapState();
}

class _COVIDMapState extends State<COVIDMap>
    with AutomaticKeepAliveClientMixin {
  Completer<GoogleMapController> _controller = Completer();
  static List<Marker> allMarkers = [];
  GoogleMap _map;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getMarkers(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    if (_map == null) {
      _map = GoogleMap(
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
            () => new EagerGestureRecognizer(),
          ),
        ].toSet(),
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(40.7128, -74.0060),
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          updateKeepAlive();
        },
        markers: Set.from(allMarkers),
      );
    }
    return _map;
  }

  static void getMarkers(data) async {
    int countryIndex = 1;
    int latIndex = 2;
    int lonIndex = 3;
    List<MapMarker> markers = [];
    for (int i = 1; i < data.length; i++) {
      MapMarker marker = MapMarker(data[i][countryIndex],
          data[i][latIndex].toDouble(), data[i][lonIndex].toDouble());

      markers.add(marker);
    }
    allMarkers = markers.map<Marker>((marker) {
      return Marker(
          markerId: MarkerId(marker.id),
          position: LatLng(marker.lat, marker.lon),
          draggable: false);
    }).toList();

    // return markers;
  }
}
