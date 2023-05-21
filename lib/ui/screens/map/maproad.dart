import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapRoadPage extends StatefulWidget {
  @override
  _MapRoadPageState createState() => _MapRoadPageState();
}

class _MapRoadPageState extends State<MapRoadPage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  List<String> _trafficData = [];

  @override
  void initState() {
    super.initState();
    _addMarkers();
    _getTrafficData();
  }

  void _addMarkers() {
    LatLng position = LatLng(37.5665, 126.9780); // 좌표 설정

    Marker marker = Marker(
      markerId: MarkerId('Marker'),
      position: position,
      infoWindow: InfoWindow(title: 'Marker'),
    );

    setState(() {
      _markers.add(marker);
    });
  }

  Future<void> _getTrafficData() async {
    String apiKey = 'YOUR_API_KEY'; // Google Maps API 키 입력
    String origin = '37.5665,126.9780'; // 출발지 좌표 입력
    String destination = '37.5642,127.0017'; // 도착지 좌표 입력
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      List<dynamic> routes = decodedData['routes'];
      if (routes.isNotEmpty) {
        List<dynamic> legs = routes[0]['legs'];
        if (legs.isNotEmpty) {
          List<dynamic> steps = legs[0]['steps'];
          _extractTrafficData(steps);
        }
      }
    } else {
      print('Error: Request failed with status code ${response.statusCode}');
    }
  }

  void _extractTrafficData(List<dynamic> steps) {
    List<String> trafficData = [];

    for (int i = 0; i < steps.length; i++) {
      String traffic = steps[i]['traffic_speed_entry'];
      if (traffic != null) {
        trafficData.add(traffic);
      }
    }

    setState(() {
      _trafficData = trafficData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Road'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.5665, 126.9780),
                zoom: 11.0,
              ),
              markers: _markers,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _trafficData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Traffic: ${_trafficData[index]}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
