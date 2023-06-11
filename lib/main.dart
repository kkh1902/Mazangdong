import 'package:flutter/material.dart';
import 'package:dong/screens/barrier/barrierinfo.dart';
import 'package:dong/screens/barrier/barriercategory.dart';
import 'package:dong/screens/barrier/barrierpicture.dart';
import 'package:dong/screens/barrier/barrierwatch.dart';
import 'package:dong/screens/search.dart';
import 'package:dong/screens/searchresult.dart';
import 'package:dong/screens/direction.dart';
import 'package:dong/screens/directionresult.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naver Map',
      initialRoute: '/',
      routes: {
        '/': (context) => NaverMapScreen(),
        '/barrier': (context) => BarrierInfoPage(),
        '/barrierpicture': (context) => BarrierpicturePage(),
        '/barriercategory': (context) => BarriercategoryPage(),
        '/barrierperson': (context) => BarrierwatchPage(),
        '/search': (context) => SearchPage(),
        '/searchresult': (context) => SearchResultPage(),
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

  List<String> tags = ['배리어', '휠체어충전', '화장실', '관광지', '육교'];
  List<IconData> icons = [
    Icons.warning,
    Icons.battery_charging_full,
    Icons.wc,
    Icons.camera,
    Icons.directions_walk,
  ];

  bool _isDrawerOpen = false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        body: Stack(
          children: [
            NaverMap(
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
            ),
            Align(
              alignment: Alignment.bottomLeft,
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
                              padding: EdgeInsets.only(left: 4.0),
                              child: Icon(Icons.edit, size: 16.0),
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              '배리어 제보',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor: Colors
                              .yellow, // Set the background color to yellow
                          foregroundColor: Colors
                              .black, // Set the text and icon color to black
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(
                      width: 120.0,
                      height: 30.0,
                      child: ElevatedButton(
                        onPressed: () {
                          // Code for the second button (GPT Guide)
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Icon(Icons.record_voice_over, size: 16.0),
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              'GPT 안내',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.white),
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          backgroundColor:
                              Colors.green, // Set the background color to green
                          foregroundColor: Colors
                              .white, // Set the text and icon color to white
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
                            SizedBox(width: 4.0),
                            Text(
                              '여정 기록',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.white),
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
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: FloatingActionButton(
                  onPressed: () {
                    if (_controller != null) {
                      _controller!
                          .setLocationTrackingMode(LocationTrackingMode.Follow);
                    }
                  },
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
                        return Container(
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
                  // Handle onTap for Item 2
                },
              ),
              Divider(),
              ListTile(
                title: Text('공지사항'),
                onTap: () {
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
