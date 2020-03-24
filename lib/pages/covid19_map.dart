import 'dart:async';

import 'package:covid19_tracker/models/covid_stats_choice.dart';
import 'package:covid19_tracker/models/data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class COVIDMap extends StatefulWidget {
  final COVIDStatChoice statChoice;
  COVIDMap(this.statChoice);
  @override
  _COVIDMapState createState() => _COVIDMapState();
}

class _COVIDMapState extends State<COVIDMap>
    with AutomaticKeepAliveClientMixin {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMap _map;
  List<Marker> markers = [];

  Future data;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final breakdowns =
        Provider.of<COVIDDataProvider>(context).stats.stats.breakdowns;
    final filteredList = breakdowns
        .where(
            (item) => item.location.lat != null || item.location.long != null)
        .toList();
    markers = filteredList.map<Marker>(
      (item) {
        var total;
        switch (widget.statChoice) {
          case COVIDStatChoice.confirmed:
            total = item.totalConfirmedCases;
            break;
          case COVIDStatChoice.recovered:
            total = item.totalRecoveredCases;
            break;
          case COVIDStatChoice.deaths:
            total = item.totalDeaths;
        }
        return Marker(
          markerId: MarkerId(Uuid().v4()),
          position: LatLng(
            item.location.lat,
            item.location.long,
          ),
          infoWindow: InfoWindow(
            title: '${item.location.countryOrRegion}: $total cases',
          ),
        );
      },
    ).toList();
    if (_map == null) {
      _map = GoogleMap(
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        ].toSet(),
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(37.0902, -95.7129),
          zoom: 3,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          updateKeepAlive();
        },
        markers: Set.from(markers),
      );
    }
    return _map;
  }
}
