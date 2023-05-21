import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mazangdong/ui/screens/map/maproad.dart';

class Maps2Page extends StatefulWidget {
  @override
  _Maps2PageState createState() => _Maps2PageState();
}

class _Maps2PageState extends State<Maps2Page> {
  List<String> itemList = List.generate(10, (index) => 'Item ${index + 1}');
  bool isEditing = false; // 편집 모드 여부를 나타내는 변수
  List<bool> isItemDeletedList =
  List.generate(10, (index) => false); // 각 아이템의 삭제 여부를 나타내는 변수

  Set<Marker> _markers = {}; // 마커 집합 변수
  List<LatLng> _markerCoordinates = [
    LatLng(37.7749, -122.4194), // 좌표 1
    LatLng(37.7805, -122.4128), // 좌표 2
    LatLng(37.7880, -122.4056), // 좌표 3
  ];

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() async {
    List<LatLng> markerCoordinates = [
      LatLng(37.7749, -122.4194), // 좌표 1
      LatLng(37.7805, -122.4128), // 좌표 2
      LatLng(37.7880, -122.4056), // 좌표 3
    ];

    for (int i = 0; i < markerCoordinates.length; i++) {
      LatLng position = markerCoordinates[i];
      String markerImagePath = 'assets/images/marker/${i + 1}.png';

      BitmapDescriptor customMarker =
      await _getCustomMarker(markerImagePath, i + 1);

      Marker marker = Marker(
        markerId: MarkerId('Marker $i'),
        position: position,
        icon: customMarker,
        infoWindow: InfoWindow(title: '${i + 1}'),
      );

      setState(() {
        _markers.add(marker);
      });
    }
  }

  Future<BitmapDescriptor> _getCustomMarker(
      String imagePath, int index) async {
    final ByteData markerImageData = await rootBundle.load(imagePath);
    final Uint8List markerImageBytes = markerImageData.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(markerImageBytes);
  }

  void _deleteItem(int index) {
    setState(() {
      isItemDeletedList[index] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text(
              'Google Maps',
              style: TextStyle(color: Colors.black),
            ),
            Spacer(),
            Icon(Icons.map_outlined, color: Colors.grey),
            SizedBox(width: 10),
            Icon(Icons.menu, color: Colors.grey),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _markerCoordinates[0],
                zoom: 11.0,
              ),
              markers: _markers,
              polylines: Set<Polyline>.from([
                Polyline(
                  polylineId: PolylineId('route'),
                  color: Colors.blue,
                  width: 4,
                  points: _markerCoordinates,
                ),
              ]),
              onMapCreated: (GoogleMapController controller) {
                // Optional: You can do something with the controller here
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '여행 순서',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapRoadPage()),
                    );
                  },
                  child: Text(
                    '다음',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReorderableListView.builder(
              padding: EdgeInsets.only(top: 16.0),
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return isItemDeletedList[index]
                    ? SizedBox.shrink()
                    : ListTile(
                  key: Key('$index'),
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
                  title: Text(itemList[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteItem(index);
                    },
                  ),
                );
              },
              onReorder: (oldIndex, newIndex) {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                setState(() {
                  final item = itemList.removeAt(oldIndex);
                  itemList.insert(newIndex, item);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
