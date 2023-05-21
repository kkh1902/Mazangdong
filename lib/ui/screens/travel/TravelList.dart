import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  GoogleMapController? _controller;
  Set<Marker> markers = {};
  int selectedSlideIndex = 0;

  @override
  void initState() {
    super.initState();

    final response = widget.responseModel;
    for (var tripModel in response.trip) {
      slideImages.add(tripModel.gwangwangjibunho.toString());
      slideCoordinates.add(LatLng(tripModel.latitude, tripModel.longitude));
      touristAttractionNames.add(tripModel.gwangwangjiyeon);
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
                      MaterialPageRoute(builder: (context) => TravelDetailPage()),
                    );
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
                  child: GoogleMap(
                    onMapCreated: (controller) {
                      _controller = controller;
                      _updateMapPosition(selectedSlideIndex); // Call the method here
                    },
                    markers: markers,
                    initialCameraPosition: CameraPosition(
                      target: slideCoordinates[selectedSlideIndex],
                      zoom: 14.0,
                    ),
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
                  primary: Color(0xff50bcdf),
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
        CameraUpdate.newLatLng(slideCoordinates[index]),
      );
      setState(() {
        markers = Set.of([
          Marker(
            markerId: MarkerId('SelectedLocation'),
            position: slideCoordinates[index],
          ),
        ]);
      });
    }
  }
}
