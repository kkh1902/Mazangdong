import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mazangdong/models/SelectedModel.dart';
import 'dart:math';

class MapRoadPage extends StatefulWidget {
  @override
  _MapRoadPageState createState() => _MapRoadPageState();
}

class _MapRoadPageState extends State<MapRoadPage> {

  Set<Polyline> _polylines = {}; // _polylines 변수 선언
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  List<String> _trafficData = [];
  List<Map<String, dynamic>> _attractionsList = [];
  List<LatLng> _coordinatesList = [];

  @override
  void initState() {
    super.initState();

    Provider.of<SelectedModel>(context, listen: false)
        .fetchDataFromDatabase()
        .then((attractionsList) {
      setState(() {
        _attractionsList = attractionsList;
      });
      _addMarkers();
      _fetchAttractionDetails();
    }).catchError((error) {
      print("An error occurred while fetching data: $error");
    });
  }

  Future<void> _fetchAttractionDetails() async {
    try {
      final url = 'https://majangdong.run.goorm.site/find';
      final trip = _attractionsList.map((attraction) => attraction['juso']).toList();
      final body = {
        'trip': trip,
        'busChk': 1,
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("Success");
        print(responseData);
        print("KEY");
        print(responseData[0]);

        print('step2');

        for (final directions in responseData) {
          print('step1');
          print(directions);
          for (final step in directions) {
            print('step');
            print(step);
            final double startX = double.parse(step['sx'].toString());
            final double startY = double.parse(step['sy'].toString());
            final double endX = double.parse(step['ex'].toString());
            final double endY = double.parse(step['ey'].toString());

            LatLng startCoordinates = LatLng(startY, startX);
            LatLng endCoordinates = LatLng(endY, endX);

            print('startCoordinates');
            print(startCoordinates);

            _coordinatesList.add(startCoordinates);
            _coordinatesList.add(endCoordinates);
          }
        }

        print('Coordinates List:');
        print(_coordinatesList);
        setState(() {
          _coordinatesList = _coordinatesList; // 전역 변수에 할당
        });
        _createMarkers();
      } else {
        print('Failed to fetch attraction details. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('An error occurred while fetching attraction details: $error');
    }


    
  }





  void _addMarkers() async {
    for (int i = 0; i < _attractionsList.length; i++) {
      LatLng position = _getCoordinates(_attractionsList[i]['coordinates']);
      String markerImagePath = 'assets/images/marker/${i + 1}.png';

      BitmapDescriptor customMarker = await _getCustomMarker(markerImagePath, i + 1);

      Marker marker = Marker(
        markerId: MarkerId('Marker $i'),
        position: position,
        icon: customMarker,
        infoWindow: InfoWindow(title: _attractionsList[i]['name']),
      );

      setState(() {
        _markers.add(marker);
      });
    }

    // 카메라 위치 업데이트

    LatLngBounds bounds = _getLatLngBounds();
    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50); // 마커 주위에 여유 공간을 추가하여 조정

    GoogleMapController controller = await _controller.future;
    controller.animateCamera(cameraUpdate);
  }

  // 카메라 위치 경계선 계산
  LatLngBounds _getLatLngBounds() {
    double minLat = double.infinity;
    double minLng = double.infinity;
    double maxLat = -double.infinity;
    double maxLng = -double.infinity;

    for (Marker marker in _markers) {
      double lat = marker.position.latitude;
      double lng = marker.position.longitude;

      minLat = min(lat, minLat);
      minLng = min(lng, minLng);
      maxLat = max(lat, maxLat);
      maxLng = max(lng, maxLng);
    }

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    return bounds;
  }


  void _createMarkers() {
    print("createMarkers 실행");
    List<Polyline> polylines = [];

    for (int i = 0; i < _coordinatesList.length - 1; i += 2) {
      LatLng start = _coordinatesList[i];
      LatLng end = _coordinatesList[i + 1];

      Polyline polyline = Polyline(
        polylineId: PolylineId('polyline_$i'),
        points: [start, end],
        color: Colors.blue,
        width: 3,
        patterns: [PatternItem.dot, PatternItem.gap(10)],
      );

      polylines.add(polyline);
    }

    for (int i = 0; i < _coordinatesList.length; i++) {
      Marker marker = Marker(
        markerId: MarkerId('marker_$i'),
        position: _coordinatesList[i],
        infoWindow: InfoWindow(
          title: 'Marker $i',
          snippet: 'Snippet $i',
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      _markers.add(marker);
    }

    setState(() {
      _polylines = polylines.toSet();
    });
  }



  LatLng _getCoordinates(LatLng coordinates) {
    return coordinates;
  }

  Future<BitmapDescriptor> _getCustomMarker(String imagePath, int size) async {
    final ByteData markerImageData = await rootBundle.load(imagePath);
    final Uint8List markerImageBytes = markerImageData.buffer.asUint8List();

    final BitmapDescriptor bitmapDescriptor = BitmapDescriptor.fromBytes(markerImageBytes);
    return bitmapDescriptor;
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
            child: Container(
              height: 300,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.5665, 126.9780),
                  zoom: 11.0,
                ),
                markers: _markers,
                polylines: _polylines,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
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
