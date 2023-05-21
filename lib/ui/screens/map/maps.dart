import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  List<String> itemList = [
    'Item 1',
    'Item 2',
    'Item 3',
  ];

  List<LatLng> _markerCoordinates = [
    LatLng(37.7749, -122.4194), // 좌표 1
    LatLng(37.7805, -122.4128), // 좌표 2
    LatLng(37.7880, -122.4056), // 좌표 3
  ];

  @override
  void initState() {
    super.initState();
    _addMarkers();
    _getDirections();
  }

  void _addMarkers() {
    for (int i = 0; i < itemList.length; i++) {
      LatLng position = _markerCoordinates[i];
      Marker marker = Marker(
        markerId: MarkerId('Marker $i'),
        position: position,
        infoWindow: InfoWindow(title: '${i + 1}'),
      );
      setState(() {
        _markers.add(marker);
      });
    }
  }

  Future<void> _getDirections() async {
    String apiKey = 'apiAIzaSyB8kES7TqH9XlChyxRgQCTMndQvkqLLfjg'; // Google Maps API 키 입력
    String origin = '${_markerCoordinates[0].latitude},${_markerCoordinates[0].longitude}';
    String destination = '${_markerCoordinates[2].latitude},${_markerCoordinates[2].longitude}';
    String url = 'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      List<dynamic> routes = decodedData['routes'];
      if (routes.isNotEmpty) {
        List<dynamic> legs = routes[0]['legs'];
        if (legs.isNotEmpty) {
          List<dynamic> steps = legs[0]['steps'];
          _drawPolyline(steps);
        }
      }
    } else {
      print('Error: Request failed with status code ${response.statusCode}');
    }
  }

  void _drawPolyline(List<dynamic> steps) {
    List<LatLng> polylineCoordinates = [];

    for (int i = 0; i < steps.length; i++) {
      String polylinePoints = steps[i]['polyline']['points'];
      List<LatLng> decodedPolyline = _decodePolyline(polylinePoints);
      polylineCoordinates.addAll(decodedPolyline);
    }

    Polyline polyline = Polyline(
      polylineId: PolylineId('route'),
      color: Colors.blue,
      width: 4,
      points: polylineCoordinates,
    );

    setState(() {
      _polylines.add(polyline);
    });
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      LatLng position = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(position);
    }

    return poly;
  }

  List<Widget> _getDraggableListItems() {
    return itemList.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      return Draggable<String>(
        data: item,
        feedback: Material(
          child: ListTile(
            leading: CircleAvatar(
              radius: 16.0,
              backgroundColor: Colors.blue,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
            ),
            title: Text(item),
          ),
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 16.0,
            backgroundColor: Colors.blue,
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
          title: Text(item),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _markerCoordinates[0],
                zoom: 11.0,
              ),
              markers: _markers,
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: _getDraggableListItems(),
            ),
          ),
        ],
      ),
    );
  }
}
