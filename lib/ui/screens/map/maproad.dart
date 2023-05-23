import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mazangdong/models/SelectedModel.dart';

class MapRoadPage extends StatefulWidget {
  @override
  _MapRoadPageState createState() => _MapRoadPageState();
}

class _MapRoadPageState extends State<MapRoadPage> {
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
      _createMarkers();
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

        List<LatLng> _coordinatesList = [];

        for (final directions in responseData[0]) {
          for (final step in directions) {
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
      } else {
        print('Failed to fetch attraction details. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('An error occurred while fetching attraction details: $error');
    }


    
  }

  void _createMarkers() async {
    print("createMarkers");
    print("_coordinatesList");
    print(_coordinatesList);
    // for (int i = 0; i < _coordinatesList.length; i++) {
    //   Marker marker = Marker(
    //     markerId: MarkerId('marker_$i'),
    //     position: positions[i],
    //     infoWindow: InfoWindow(
    //       title: 'Marker $i',
    //       snippet: 'Snippet $i',
    //     ),
    //     icon: BitmapDescriptor.defaultMarker,
    //   );

    //     markers.add(marker);
    //   }
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
