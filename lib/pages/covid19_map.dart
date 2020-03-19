import 'dart:async';

import 'package:covid19_tracker/models/data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class COVIDMap extends StatefulWidget {
  @override
  _COVIDMapState createState() => _COVIDMapState();
}

class _COVIDMapState extends State<COVIDMap>
    with AutomaticKeepAliveClientMixin {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMap _map;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<COVIDDataProvider>(context);
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
        markers: Set.from(provider.markers),
      );
    }
    return _map;
  }
}
