import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mazangdong/ui/screens/map/maproad.dart';
import 'package:provider/provider.dart';
import 'package:mazangdong/models/SelectedModel.dart';

class Maps2Page extends StatefulWidget {
  @override
  _Maps2PageState createState() => _Maps2PageState();
}

class _Maps2PageState extends State<Maps2Page> {
  List<String> itemList = [];
  bool isEditing = false;
  List<bool> isItemDeletedList = List.generate(10, (index) => false);

  Set<Marker> _markers = {};
  List<LatLng> _markerCoordinates = [];
  Set<Polyline> _polylines = {};

  Completer<GoogleMapController> _controllerCompleter = Completer<GoogleMapController>();

  LatLngBounds? _bounds;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      List<Map<String, dynamic>> attractionsList = await Provider.of<SelectedModel>(context, listen: false).fetchDataFromDatabase();
      _addMarkers(attractionsList);
      _createPolylines();
      _calculateBounds();
      setState(() {});
    } catch (error) {
      print("An error occurred while fetching data: $error");
    }
  }

  LatLng _getCoordinates(LatLng coordinates) {
    return coordinates;
  }

  void _addMarkers(List<Map<String, dynamic>> attractionsList) async {
    for (int i = 0; i < attractionsList.length; i++) {
      LatLng position = _getCoordinates(attractionsList[i]['coordinates']);
      _markerCoordinates.add(position); // Add the position to the list
      String markerImagePath = 'assets/images/marker/${i + 1}.png';

      BitmapDescriptor customMarker = await _getCustomMarker(markerImagePath, i + 1);

      Marker marker = Marker(
        markerId: MarkerId('Marker $i'),
        position: position,
        icon: customMarker,
        infoWindow: InfoWindow(title: attractionsList[i]['name']),
      );

      setState(() {
        _markers.add(marker);
        itemList.add(attractionsList[i]['name']); // Add the marker's name to itemList
        isItemDeletedList.add(false);
      });
    }
  }


  Future<BitmapDescriptor> _getCustomMarker(String imagePath, int index) async {
    final ByteData markerImageData = await rootBundle.load(imagePath);
    final Uint8List markerImageBytes = markerImageData.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(markerImageBytes);
  }

  void _deleteItem(int index) {
    setState(() {

      isItemDeletedList.removeAt(index); // isItemDeletedList에서도 해당 항목 제거
      itemList.removeAt(index); // itemList에서도 삭제된 항목 제거
    });
  }


  void _createPolylines() {
    // Create a polyline using the _markerCoordinates list
    Polyline polyline = Polyline(
      polylineId: PolylineId('dottedLine'),
      color: Colors.blue,
      width: 4,
      points: _markerCoordinates,
      patterns: [PatternItem.dot, PatternItem.gap(10)],
    );

    setState(() {
      _polylines.add(polyline);
    });
  }

  void _calculateBounds() {
    if (_markerCoordinates.isNotEmpty) {
      double minLat = double.infinity;
      double maxLat = -double.infinity;
      double minLng = double.infinity;
      double maxLng = -double.infinity;

      for (LatLng position in _markerCoordinates) {
        if (position.latitude < minLat) {
          minLat = position.latitude;
        }
        if (position.latitude > maxLat) {
          maxLat = position.latitude;
        }
        if (position.longitude < minLng) {
          minLng = position.longitude;
        }
        if (position.longitude > maxLng) {
          maxLng = position.longitude;
        }
      }

      LatLng southwest = LatLng(minLat, minLng);
      LatLng northeast = LatLng(maxLat, maxLng);

      _bounds = LatLngBounds(southwest: southwest, northeast: northeast);
    }
  }

  CameraPosition _getCameraPosition() {
    LatLngBounds? bounds = _getBounds(); // Call the _getBounds function
    CameraPosition initialCameraPosition;

    if (bounds != null) {
      LatLng center = LatLng(
        (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
        (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
      );
      double zoom = _calculateZoomLevel();
      initialCameraPosition = CameraPosition(target: center, zoom: zoom);
    } else {
      // Set default position or desired position
      LatLng defaultPosition = LatLng(37.5665, 126.9780);
      double defaultZoom = 11.0;
      initialCameraPosition = CameraPosition(target: defaultPosition, zoom: defaultZoom);
    }

    return initialCameraPosition;
  }

  double _calculateZoomLevel() {
    const double padding = 50.0;
    final double maxZoom = 21.0;

    double minZoom = 0.0;
    double zoom;

    double mapWidth = MediaQuery.of(context).size.width - (2 * padding);
    double mapHeight = MediaQuery.of(context).size.height - (2 * padding);

    double angle = _bounds!.northeast.latitude - _bounds!.southwest.latitude;
    double angle2 = _bounds!.northeast.longitude - _bounds!.southwest.longitude;

    double deltaLat = angle;
    double deltaLng = angle2;

    double zoomLat = _calculateZoom(mapHeight, deltaLat);
    double zoomLng = _calculateZoom(mapWidth, deltaLng);

    minZoom = min(zoomLat, zoomLng);

    zoom = minZoom > maxZoom ? maxZoom : minZoom;
    double minZoomAdjustment = 2.0; // Set the minimum zoom level adjustment

    if (zoom > minZoomAdjustment) {
      zoom -= minZoomAdjustment;
    } else {
      zoom = 1.0;
    }

    return zoom;
  }

  double _calculateZoom(double mapSize, double delta) {
    const double tileSize = 256.0;
    double zoom;
    double maxZoom = 21.0;
    double worldSize = tileSize * pow(2, maxZoom - 1);

    zoom = log(worldSize * mapSize / (tileSize * delta)) / ln2;

    return zoom;
  }

  LatLngBounds? _getBounds() {
    if (_bounds != null) {
      LatLng southwest = _bounds!.southwest;
      LatLng northeast = _bounds!.northeast;

      return LatLngBounds(southwest: southwest, northeast: northeast);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    LatLngBounds? bounds = _getBounds();
    CameraPosition initialCameraPosition = _getCameraPosition();

    if (bounds != null) {
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
                mapType: MapType.normal,
                initialCameraPosition: initialCameraPosition,
                markers: _markers,
                polylines: _polylines,
                onMapCreated: (GoogleMapController controller) {
                  _controllerCompleter.complete(controller);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Travel Order',
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
                      'Next',
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
                      : ReorderableDragStartListener(
                    index: index,
                    key: Key('item_$index'), // 고유한 키를 할당합니다.
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
                      title: Text(itemList[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteItem(index);
                        },
                      ),
                    ),
                  );
                },
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  setState(() {
                    final item = itemList.removeAt(oldIndex);
                    final marker = _markers.elementAt(oldIndex);
                    final coordinate = _markerCoordinates.removeAt(oldIndex);

                    itemList.insert(newIndex, item);
                    _markers.remove(marker);
                    _markerCoordinates.insert(newIndex, coordinate);
                    _markers.add(marker);
                  });
                },

              ),
            ),
          ],
        ),
      );
    } else {
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
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
