import 'package:covid19_tracker/models/map_marker.dart';
import 'package:covid19_tracker/services/networking.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<dynamic>> myData = [];
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];

  @override
  void initState() {
    super.initState();
    getMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'COVID-19 Tracker',
        ),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(40.7128, -74.0060),
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(allMarkers),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit),
        onPressed: () {},
      ),
    );
  }

  void getMarkers() async {
    final data = await parseCSV(kConfirmedURL);

    int countryIndex = 1;
    int latIndex = 2;
    int lonIndex = 3;
    List<MapMarker> markers = [];
    for (int i = 1; i < data.length; i++) {
      MapMarker marker = MapMarker(data[i][countryIndex],
          data[i][latIndex].toDouble(), data[i][lonIndex].toDouble());
      markers.add(marker);
    }
    setState(() {
      allMarkers = markers.map<Marker>((marker) {
        return Marker(
            markerId: MarkerId(marker.markerID),
            position: LatLng(marker.lat, marker.lon),
            draggable: false);
      }).toList();
    });
    // return markers;
  }

  int calculateSum(data) {
    int columns = data[0].length;
    int sum = 0;

    for (int i = 1; i < data.length; i++) {
      sum += data[i][columns - 1];
    }
    return sum;
  }

  Future<List<List<dynamic>>> parseCSV(url) async {
    final networkService = NetworkService(url);
    final response = await networkService.fetchData();
    List<List<dynamic>> data = [];
    if (response.statusCode == 200) {
      final parsedData = CsvToListConverter().convert(response.body);
      data = parsedData;
      // print(calculateSum(parsedData));
      // getMarkers(parsedData);
    }
    return data;
  }
}
