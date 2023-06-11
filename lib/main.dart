import 'dart:collection';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dong/screens/barrier/barrierinfo.dart';
import 'package:dong/screens/barrier/barriercategory.dart';
import 'package:dong/screens/barrier/barrierpicture.dart';
import 'package:dong/screens/barrier/barrierwatch.dart';
import 'package:dong/screens/tags/BarriertagsPage.dart';
import 'package:dong/screens/tags/Tourtags.dart';
import 'package:dong/screens/tags/wctags.dart';
import 'package:dong/screens/tags/wheelenergytag.dart';
import 'package:dong/screens/search/search.dart';
import 'package:dong/screens/search/searchresult.dart';
import 'package:dong/screens/search/searchfinal.dart';
import 'package:dong/screens/record/myrecord.dart';
import 'package:dong/screens/record/recorddetail.dart';
import 'package:dong/screens/direction.dart';
import 'package:dong/screens/directionresult.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart' show LatLng, CameraUpdate, Marker;
import 'package:geolocator/geolocator.dart';
import 'package:dong/models/barrierdata.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var Barrier = BarrierData();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Naver Map',
      initialRoute: '/',
      routes: {
        '/': (context) => NaverMapScreen(),
        '/barrier': (context) => BarrierInfoPage(),
        '/barrierpicture': (context) => BarrierpicturePage(barrier: Barrier),
        '/barriercategory': (context) => BarriercategoryPage(barrier: Barrier),
        '/barrierperson': (context) => BarrierwatchPage(),
        '/barriertags': (context) => BarrierTagsPage(),
        '/wctags': (context) => wcTagsPage(),
        '/tourtags': (context) => tourTagsPage(),
        '/wheelenergytags': (context) => wheelenergyTagsPage(),
        '/search': (context) => SearchPage(),
        '/searchresult': (context) => SearchResultPage(),
        '/searchfinal': (context) => SearchFinalPage(),
        '/myrecord': (context) => MyRecordPage(),
        '/recorddetail': (context) => MyRecordDetailPage(),
        '/direction': (context) => DirectionPage(),
        '/directionresult': (context) => DirectionResultPage(),
      },
    );
  }
}

class NaverMapScreen extends StatefulWidget {
  @override
  _NaverMapScreenState createState() => _NaverMapScreenState();
}

class _NaverMapScreenState extends State<NaverMapScreen> {
  NaverMapController? _controller;
  TextEditingController _searchController = TextEditingController();
  CameraPosition? _initialCameraPosition;

  List<Marker> markers = [];
  List<Marker> barrierMarkers = [];

  List<String> tags = ['배리어', '휠체어충전', '화장실', '관광지'];
  List<IconData> icons = [
    Icons.warning,
    Icons.battery_charging_full,
    Icons.wc,
    Icons.card_travel,
  ];

  // Map<String, String> barrierType = {"횡단보도" : "test"};
  //
  // Map<int, List> barrierPos = {1 : [35.3123, 125.123]};

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(NaverMapController controller) {
    setState(() {
      _controller = controller;
      getCurrentLocation();
      fetchBarrierLocations();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
    fetchBarrierLocations();
  }

  void _handleTagPressed(String tag) {
    if (tag == '배리어') {
      Navigator.pushNamed(context, '/barriertags');
    } else if (tag == '휠체어충전') {
      Navigator.pushNamed(context, '/wheelenergytags');
    } else if (tag == '화장실') {
      Navigator.pushNamed(context, '/wctags');
    } else if (tag == '관광지') {
      Navigator.pushNamed(context, '/tourtags');
    } else {
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


  // List<Marker> createMarkers(List<Map<String, dynamic>> locations) {
  //   List<Marker> markers = [];
  //
  //   for (var location in locations) {
  //     markers.add(
  //       Marker(
  //         markerId: location['id'],
  //         position: LatLng(location['latitude'], location['longitude']),
  //         captionText: location['name'],
  //       ),
  //     );
  //   }
  //   return markers;
  // }


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
        markers = barrierMarkers;
      });

    } else {
      // Handle error response
      print('Failed to fetch barrier locations: ${response.statusCode}');
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: Stack(
          children: [
            NaverMap(
              onMapCreated: _onMapCreated, // Use the modified callback
              initialCameraPosition: _initialCameraPosition,
              markers: List<Marker>.from(barrierMarkers),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 120.0,
                      height: 30.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/barrier');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 2.0),
                              child: Icon(Icons.edit, size: 16.0),
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              '배리어 제보',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.white),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Colors
                              .blue, // Set the background color to yellow
                          foregroundColor: Colors
                              .white, // Set the text and icon color to black
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(
                      width: 120.0,
                      height: 30.0,
                      child: ElevatedButton(
                        onPressed: () {
                          // Code for the third button (Itinerary Log)
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Icon(Icons.videocam, size: 16.0),
                            ),
                            SizedBox(width: 6.0),
                            Text(
                              '여정 기록',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.white),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor:
                              Colors.black, // Set the background color to black
                          foregroundColor: Colors
                              .white, // Set the text and icon color to white
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32.0,
                    ), // Add the desired height for the blank space
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, bottom: 40.0),
                child: FloatingActionButton(
                  onPressed:getCurrentLocation, // 현재 위치로 이동하는 함수 호출
                  child: Icon(Icons.my_location),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: '어디로 갈까요?',
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/search');
                      }),
                  SizedBox(height: 10.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(tags.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            // 여기에 태그를 눌렀을 때 호출할 함수를 작성하세요.
                            // 예를 들어, _handleTagPressed(tags[index])와 같이 함수를 호출할 수 있습니다.
                            // 각 태그에 대한 동작을 원하는 대로 구현해야 합니다.
                            _handleTagPressed(tags[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 3.0,
                              horizontal: 10.0,
                            ),
                            margin: EdgeInsets.only(right: 8.0),
                            child: Row(
                              children: [
                                Icon(icons[index], size: 20.0),
                                SizedBox(width: 5.0),
                                Text(tags[index]),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            children: [
              DrawerHeader(
                child: Text(
                  '누구님',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('나의 제보'),
                onTap: () {
                  // Handle onTap for Item 1
                },
              ),
              Divider(),
              ListTile(
                title: Text('나의 여정 기록'),
                onTap: () {
                  Navigator.pushNamed(context, '/myrecord');
                  // Handle onTap for Item 2
                },
              ),
              Divider(),
              ListTile(
                title: Text('공지사항'),
                onTap: () {
                  Navigator.pushNamed(context, '/recorddetail');
                  // Handle onTap for Item 3
                },
              ),
              Divider(),
              ListTile(
                title: Text('설정'),
                onTap: () {
                  // Handle onTap for Item 3
                },
              ),
            ],
          ),
        ));
  }
}
