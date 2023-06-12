import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BarrierTagsPage extends StatefulWidget {
  @override
  _BarrierTagsPageState createState() => _BarrierTagsPageState();
}

class _BarrierTagsPageState extends State<BarrierTagsPage> {
  NaverMapController? _controller;
  BottomDrawerController controller = BottomDrawerController();
  List<Marker> barrierMarkers = [];
  Set<Marker> markers = {};
  bool isDrawerOpen = false;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    fetchBarrierLocations();
    Future.delayed(Duration(milliseconds: 500), () {
      controller.open();
    });
  }

  void fetchBarrierLocations() async {
    final response = await http.get(Uri.parse('https://majangdong.run.goorm.site/barrier'));
    if (response.statusCode == 200) {
      final barrierData = json.decode(response.body);
      print('ssss');
      print(barrierData[0]);
      print("barielength");
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
            iconTintColor: Colors.blue,
            // Add other properties of the marker if necessary
          );
          barrierMarkers.add(marker);
          print(barrierMarkers);
        } else {
          print("Invalid coordinates for location ${location['번호']}: ${location['위도']}, ${location['경도']}");
        }
      }


      // Update the markers list in the state and refresh the UI
      setState(() {
        markers = Set.of(barrierMarkers);
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Text(
                '주변 베리어 정보',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
        leading: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.grey,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black, size: 18.0),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[100],
            height: 4.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    zoom: 17.0,
                  ),
                  markers: List<Marker>.from(barrierMarkers),
                ),
              ),
            ],
          ),
          buildBottomDrawer(context),
        ],
      ),
    );
  }

  Widget buildBottomDrawer(BuildContext context) {
    return BottomDrawer(
      header: Container(
        margin: const EdgeInsets.all(11.0),
        width: 80.0,
        height: 6.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey[300],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 8.0),
                              child: Text(
                                "주변 베리어",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 150.0),
                            Container(
                              width: 75,
                              margin: EdgeInsets.only(right: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: PopupMenuButton<String>(
                                icon: Row(
                                  children: [
                                    Text(
                                      '전체',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                  PopupMenuItem<String>(
                                    value: "filter1",
                                    child: ListTile(
                                      title: Text("전체"),
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: "filter2",
                                    child: ListTile(
                                      title: Text("턱"),
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: "filter3",
                                    child: ListTile(
                                      title: Text("시설물"),
                                    ),
                                  ),
                                ],
                                onSelected: (String value) {
                                  // 선택된 필터 처리 로직 작성
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 4.0,
              color: Colors.grey[100],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40.0, 0, 20.0, 0),
              child: Row(
                children: [
                  Container(
                    width: 48.0,
                    margin: EdgeInsets.only(right: 16.0),
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1.0,
              color: Colors.grey[100],
            ),
            Expanded(
              child: ListView.builder(
                // ListView.builder로 변경
                itemCount: barrierMarkers.length,
                itemBuilder: (BuildContext context, int index) {
                  Marker marker = barrierMarkers[index];
                  return ListTile(
                    subtitle: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 8.0),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  "승인 완료",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                "단차",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                "부산광역시 사상구 주례동 88-7",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      "#단차",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      "#휠체어 이용자",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      "#시각 장애인",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          // Add your image widget here
                        ),

                      ],

                    ),

                  );
                },
              ),
            ),
          ],
        ),
      ),
      headerHeight: 28.0,
      drawerHeight: 350.0,
      color: Colors.white,
      controller: controller,
    );
  }
}


