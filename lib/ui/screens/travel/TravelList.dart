import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mazangdong/ui/screens/travel/RecommedTourlist.dart';
import 'package:mazangdong/ui/screens/travel/TravleDetail.dart';
import 'package:mazangdong/ui/screens/travel/Recommendaccomodationlist.dart';
import 'package:mazangdong/ui/screens/map/maps.dart';
import 'package:mazangdong/ui/screens/map/map2.dart';

class TravelListPage extends StatefulWidget {
  @override
  _TravelListPageState createState() => _TravelListPageState();
}

class _TravelListPageState extends State<TravelListPage> {
  List<String> randomTags = [
    '#전체',
    '#관광지',
    '#문화',
    '#유적',
    '#유적',
    '#유적',
    '#유적',
    '#유적',
    '#유적',
  ];
  List<String> slideImages = ['3.jpg', '3.jpg', '3.jpg', '3.jpg', '3.jpg'];
  int selectedSlideIndex = 0;
  List<LatLng> slideCoordinates = [
    LatLng(37.7749, -122.4194), // Slide 0에 대한 좌표
    LatLng(20.7833, -122.4167), // Slide 1에 대한 좌표
    LatLng(40.7914, -122.4086), // Slide 2에 대한 좌표
    LatLng(50.7914, -122.4086),
    LatLng(60.7914, -122.4086),
    // 나머지 슬라이드에 대한 좌표를 추가하세요
  ];

  GoogleMapController? _controller;

  void updateMapCameraPosition() {
    if (_controller != null && selectedSlideIndex >= 0 && selectedSlideIndex < slideCoordinates.length) {
      LatLng selectedCoordinate = slideCoordinates[selectedSlideIndex];
      CameraPosition cameraPosition = CameraPosition(
        target: selectedCoordinate,
        zoom: 12,
      );
      _controller!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 70.0, 10.0, 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '안녕하세요, 기훈님',
              style: TextStyle(fontSize: 30, fontFamily: 'pretendardBold'),
            ),
            SizedBox(height: 10),
            Text(
              '다양한 경험과 장소가 \n당신을 기다리고 있어요.',
              style: TextStyle(fontSize: 16, fontFamily: 'pretendardBold'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TravelDetailPage()),
                    );
                    // Handle Tourist Attractions button tap
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),
                  child: Text(
                    '관광지 ',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'pretendardBold',
                      fontSize: 20,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RecommendaccomodationlistPage()),
                    );
                    // Handle Accommodation button tap
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),
                  child: Text(
                    '숙소',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'pretendardBold',
                      fontSize: 20,
                    ),
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RecommendtourlistPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerRight,
                  ),
                  child: Text(
                    '전체보기',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'pretendardBold',
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffDDDDDD),
                    blurRadius: 6.0,
                    spreadRadius: 2.0,
                    offset: Offset(0.0, 0.0),
                  )
                ],
              ),
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (String tag in randomTags)
                          Padding(
                            padding: EdgeInsets.only(
                              right: 8.0,
                            ),
                            child: Chip(
                              label: Text(
                                tag,
                                style: TextStyle(fontFamily: 'pretendardBold'),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: slideImages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSlideIndex = index;
                            });
                            updateMapCameraPosition(); // 선택된 슬라이드에 따라 지도 위치를 업데이트합니다.
                          },

                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            width: 150,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: selectedSlideIndex == index
                                    ? BorderSide(color: Colors.blue, width: 2.0)
                                    : BorderSide.none,
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      height: 130,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(30),
                                          child: Image.asset(
                                            'assets/images/${slideImages[index]}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Slide $index',
                                    style:
                                    TextStyle(fontFamily: 'pretendardBold'),
                                  ),
                                  Text(
                                    'Subtitle for Slide $index',
                                    style:
                                    TextStyle(fontFamily: 'pretendardBold'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        37.7749,
                        -122.4194,
                      ),
                      zoom: 12,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      setState(() {
                        _controller = controller;
                      });
                    },
                    markers: Set<Marker>.from([
                      Marker(
                        markerId: MarkerId('selectedSlide'),
                        position: LatLng(37.7749, -122.4194),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Maps2Page(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff50bcdf), // 214, 260, 245
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  '추가',
                  style: TextStyle(fontSize: 20, fontFamily: 'PretendardBold'),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapsPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffa3cc9b),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  '완료',
                  style: TextStyle(fontSize: 20, fontFamily: 'PretendardBold'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
