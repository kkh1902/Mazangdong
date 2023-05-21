import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart' hide LatLng;
import 'package:naver_map_plugin/naver_map_plugin.dart' hide CameraPosition, CameraUpdate;
import 'package:mazangdong/ui/screens/travel/RecommedTourlist.dart';
import 'package:mazangdong/ui/screens/travel/TravleDetail.dart';
import 'package:mazangdong/models/ResponseModel.dart';
import 'package:mazangdong/ui/screens/travel/Recommendaccomodationlist.dart';

class TravelListPage extends StatefulWidget {
  final ResponseModel responseModel;

  TravelListPage({required this.responseModel});

  @override
  _TravelListPageState createState() => _TravelListPageState();
}

class _TravelListPageState extends State<TravelListPage> {
  List<String> randomTags = [
    '#전체',
    '#관광지',
    '#문화',
    '#유적',
  ];

  List<String> slideImages = [];
  List<LatLng> slideCoordinates = [];
  List<String> touristAttractionNames = [];

  NaverMapController? _controller;
  List<Marker> markers = [];
  int selectedSlideIndex = 0;

  @override
  void initState() {
    super.initState();

    final response = widget.responseModel;
    for (var tripModel in response.trip) {
      slideImages.add(tripModel.gwangwangjibunho.toString()); // Add the tourist attraction name to slideImages
      slideCoordinates.add(LatLng(tripModel.latitude, tripModel.longitude)); // Assuming you have latitude and longitude properties in TripModel
      touristAttractionNames.add(tripModel.gwangwangjiyeon); // Add the tourist attraction name to the list
    }

    print("touristAttractionNames$touristAttractionNames");
    print("slideCoordinates$slideCoordinates");

    _addMarkers();
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
                      MaterialPageRoute(builder: (context) => TravelDetailPage()),
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
                      MaterialPageRoute(builder: (context) => RecommendaccomodationlistPage()),
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
                      MaterialPageRoute(builder: (context) => RecommendtourlistPage()),
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
                            _updateMapPosition(index);
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
                                          borderRadius: BorderRadius.circular(30),
                                          child: Image.asset(
                                            'assets/images/trip/${slideImages[index]}.jpg',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    touristAttractionNames[index],
                                    style: TextStyle(fontFamily: 'pretendardBold'),
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
                  child: NaverMap(
                    onMapCreated: (controller) {
                      _controller = controller;
                    },
                    markers: markers.toList(),
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => Maps2Page(),
                  //   ),
                  // );
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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => MapsPage(),
                  //   ),
                  // );
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

  void _updateMapPosition(int index) {
    if (_controller != null) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: slideCoordinates[index],
            zoom: 15.0, // Adjust the zoom level as needed
          ),
        ),
      );
    }
  }





  void _addMarkers() {
    for (int i = 0; i < slideCoordinates.length; i++) {
      final marker = Marker(
        markerId: MarkerId('$i'),
        position: slideCoordinates[i],
      );
      markers.add(marker);
    }
  }
}
