import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart' as naver;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'dart:collection';


class DirectionPage extends StatefulWidget {
  @override
  _DirectionPageState createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {
  NaverMapController? _controller;
  String startLocation = "부산광역시 사상구 주례로 47";
  String goalLocation = "냉정역";
  String startTime = "오늘 11시 45분 출발";
  BottomDrawerController controller = BottomDrawerController();
  late CameraPosition _initialCameraPosition;
  List<Marker> barrierMarkers = [];
  List<Marker> markers = [];
  List<LatLng> polylineCoordinates = [];
  List<PathOverlay> pathOverlays = [];
  List<Map<String, dynamic>> barrierList = [];




  @override
  void initState() {
    super.initState();
    fetchCoordinates();
    getCurrentLocation();
    fetchBarrierLocations();
    Future.delayed(Duration(milliseconds: 500), () {
      controller.open();
    });
  }

  void fetchCoordinates() async {
    Position? position;

    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true,
      );
    } catch (e) {
      print('Error: $e');
    }

    print('시작');
    final url = Uri.parse('https://majangdong.run.goorm.site/findR');

    if (position != null) {
      final originLatitude = position.latitude;
      final originLongitude = position.longitude;

      final payload = {
        "origin": [originLatitude, originLongitude],
        "destination": [35.1512, 129.0124],
        "type": 1
      };

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        print('성공');
        final data = json.decode(response.body);
        final tripCoordinates = data;
        print('skkks');
        print(data[0]);

        final startLatitude = data[0][1][0];
        final startLongitude = data[0][1][1];
        print('ssss');
        print(data[0]);



        List<double> destinationLatitudes = [];
        List<double> destinationLongitudes = [];

        for (var i = 0; i < tripCoordinates.length; i++) {
          final coordinate = tripCoordinates[i][1];
          final destinationLatitude = double.parse(coordinate[1].toString());
          final destinationLongitude = double.parse(coordinate[0].toString());

          destinationLatitudes.add(destinationLatitude);
          destinationLongitudes.add(destinationLongitude);

          polylineCoordinates.add(LatLng(destinationLatitude, destinationLongitude));
        }

        setState(() {
          startLocation = "부산광역시 사상구 주례로 47";
          goalLocation = "서면시장";
          startTime = "오늘 11시 45분 출발";
          _initialCameraPosition = CameraPosition(
            target: LatLng(startLatitude.toDouble(), startLongitude.toDouble()),
            zoom: 13.0,
          );

          print('start');
          print(startLatitude);
          markers = [
            for (var i = 0; i < tripCoordinates.length; i++)
              Marker(
                markerId: 'destination_$i',
                position: LatLng(
                  destinationLatitudes[i],
                  destinationLongitudes[i],
                ),
              ),
            Marker(
              markerId: 'start',
              position: LatLng(originLatitude, originLongitude),
            ),
            Marker(
              markerId: 'goal',
              position: LatLng(destinationLatitudes.last, destinationLongitudes.last),
            ),
          ];

          pathOverlays = [
            PathOverlay(
              PathOverlayId('1'),  // ID (여기서는 예시로 1을 사용했으나, 고유한 값을 사용하십시오.)
              polylineCoordinates,
              color: Colors.blue,
              width: 1,
              outlineColor: Colors.blue,
              outlineWidth: 3,
            ),
          ];
        });
      }
    }
  }

  void fetchBarrierLocations() async {
    final response = await http.get(Uri.parse('https://majangdong.run.goorm.site/barrier'));
    if (response.statusCode == 200) {
      final barrierData = json.decode(response.body);
      print(barrierData[0]);
      print(barrierData[0].length);

      // Create the markers based on the data
      for (int i = 0; i < barrierData[0].length; i++) {
        Map<String, dynamic> location = barrierData[0][i];
        double? latitude = double.tryParse(location['위도']);
        double? longitude = double.tryParse(location['경도']);

        if (latitude != null && longitude != null) {
          Marker marker = Marker(
            markerId: location['번호'].toString(),
            position: LatLng(latitude, longitude),
            iconTintColor: Colors.blue, // Set the desired color for barrier markers
          );
          barrierMarkers.add(marker);
          print(barrierMarkers);
        } else {
          print("Invalid coordinates for location ${location['번호']}: ${location['위도']}, ${location['경도']}");
        }
      }

      setState(() {
        markers.addAll(barrierMarkers); // Add barrier markers to the markers list
      });
    } else {
      // Handle error response
      print('Failed to fetch barrier locations: ${response.statusCode}');
    }
  }




  void getCurrentLocation() async {
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true,
      );
    } catch (e) {
      print('Error: $e');
    }

    if (position != null) {
      final latitude = position.latitude;
      final longitude = position.longitude;
      print('Current Location: $latitude, $longitude');


      final target = LatLng(latitude, longitude);
      final cameraUpdate = CameraUpdate.scrollTo(target);
      _controller?.moveCamera(cameraUpdate);


    }
  }




  // void setPathOverlays(List<dynamic> coordinates) {
  //   List<LatLng> pathCoordinates = coordinates.map((coord) {
  //     return LatLng(coord[1].toDouble(), coord[0].toDouble());
  //   }).toList();
  //
  //   PathOverlay newPathOverlay = PathOverlay(
  //     path: pathCoordinates,
  //     color: Colors.red,
  //     width: 5,
  //     outlineColor: Colors.red,
  //     outlineWidth: 5,
  //   );
  //
  //   setState(() {
  //     pathOverlays.add(newPathOverlay);
  //   });
  // }






  Widget buildBottomDrawer(BuildContext context) {
    return BottomDrawer(

      /// your customized drawer header.
      header: Container(
        margin: const EdgeInsets.all(11.0),
        width: 80.0,
        height: 6.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey[300],
        ),
      ),

      /// your customized drawer body.
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Container(
                            margin: EdgeInsets.only(right: 8.0),
                            child: Text(
                              "17분",
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "700m",
                            style:
                            TextStyle(fontSize: 16.0, color: Colors.grey),
                          ),
                        ]),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/directionresult');
                            },
                            child: Text(
                              '길 안내 평가',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                            ),
                            style: ButtonStyle(
                                minimumSize:
                                MaterialStateProperty.all<Size>(
                                    Size.zero),
                                padding: MaterialStateProperty.all<
                                    EdgeInsets>(
                                    EdgeInsets.all(6.0)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20.0),
                                        side: BorderSide(
                                            color: Colors.black,
                                            width: 1.2))))),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 8.0),
                          child: Row(children: [
                            Icon(
                              Icons.wheelchair_pickup,
                              size: 16.0,
                            ),
                            Text('휠체어'),
                            Text(
                              "17분",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.pause_outlined,
                              size: 16.0,
                            ),
                            Text('목발'),
                            Text(
                              "30분",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 4.0,
              color: Colors.grey[100],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
              child: Row(children: [
                Container(
                    width: 48.0,
                    margin: EdgeInsets.only(right: 16.0),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.circle,
                            color: Colors.blue,
                            size: 14.0,
                          ),
                        ),
                        Text(
                          '출발',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                Text(
                  startLocation,
                  style: TextStyle(
                      color: Colors.grey[900], fontSize: 16.0),
                )
              ]),
            ),
            Divider(
              thickness: 1.0,
              color: Colors.grey[100],
            ),
            Container(
              margin: EdgeInsets.only(right: 16.0),
              padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
              child: Row(children: [
                Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                          width: 48.0,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.directions_walk,
                            color: Colors.grey,
                            size: 24.0,
                          ),
                        ),
                      ],
                    )),
                Text(
                  startLocation,
                  style: TextStyle(
                      color: Colors.grey[900], fontSize: 16.0),
                )
              ]),
            )
          ],
        ),
      ),

      headerHeight: 28.0,
      drawerHeight: 300.0,

      /// drawer background color.
      color: Colors.white,

      /// drawer controller.
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    LinkedHashSet<PathOverlay> pathOverlaysSet = LinkedHashSet<PathOverlay>.from(pathOverlays);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          // Center-align the title
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 80.0,
                child: Text(startLocation,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0)),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
                  child:
                  Icon(
                      Icons.arrow_right_alt_rounded, color: Colors.grey)),
              SizedBox(
                width: 80.0,
                child: Text(goalLocation,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0)),
              ),
            ],
          ),
          leading: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.grey,
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(
                    Icons.close, color: Colors.black, size: 18.0),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey[100], // Border color
              height: 4.0, // Border height
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
              Flexible(
                child: NaverMap(
                  onMapCreated: (controller) {
                    setState(() {
                      _controller = controller;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      37.5665,
                      126.9780,
                    ),
                    zoom: 15.0,
                  ),
                  markers: markers.toList(),
                  pathOverlays: pathOverlaysSet,
                ),
              )
            ]),
            buildBottomDrawer(context),
          ],
        ));
  }
}
