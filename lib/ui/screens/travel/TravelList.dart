import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mazangdong/ui/screens/travel/RecommedTourlist.dart';
import 'package:mazangdong/ui/screens/travel/TravleDetail.dart';
import 'package:mazangdong/ui/screens/travel/Recommendaccomodationlist.dart';
import 'package:mazangdong/ui/screens/map/map2.dart';
import 'package:mazangdong/ui/screens/map/maps.dart';
import 'package:mazangdong/models/ResponseModel.dart';
import 'package:mazangdong/models/SelectedModel.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class TravelListPage extends StatefulWidget {
  final ResponseModel responseModel;

  TravelListPage({required this.responseModel});

  @override
  _TravelListPageState createState() => _TravelListPageState();
}

class _TravelListPageState extends State<TravelListPage> {
  bool isAttractionSelected = true;
  List<String> randomTags = [
    '#전체',
    '#관광지',
    '#문화',
    '#유적',
  ];
  List<String> suksoTags = [
    '#전체',
    '#전용객실',
  ];

  List<String> slideImages = [];
  List<LatLng> slideCoordinates = [];
  List<String> touristAttractionNames = [];
  List<int> gwangwangjibunho = [];

  GoogleMapController? _controller;
  Set<Marker> markers = {};
  int selectedSlideIndex = 0;

  @override
  void initState() {
    super.initState();

    final response = widget.responseModel;

    for (var tripModel in response.trip) {
      slideImages.add(tripModel.gwangwangjibunho.toString());
      slideCoordinates.add(
          LatLng(tripModel.latitude ?? 0.0, tripModel.longitude ?? 0.0));
      touristAttractionNames.add(tripModel.gwangwangjiyeon);
      gwangwangjibunho.add(tripModel.gwangwangjibunho);
    }
    print("slideCoordinates: $slideCoordinates");
    print("gwangwangjibunho: $gwangwangjibunho");
  }

  void detail(int index) {
    int bunho = gwangwangjibunho[index];
    print("bunho: $bunho");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TravelDetailPage(bunho: bunho)),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool _isDoubleTap = false;
    var selectedModel = Provider.of<SelectedModel>(context);
    // selectedModel.selectedList = []; 초기화 할때
    print(selectedModel.selectedList);
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
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isAttractionSelected = true;
                      });
                    },
                    style: TextButton.styleFrom(
                      padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      backgroundColor: isAttractionSelected
                          ? Colors.blue
                          : Colors.grey.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      '관광지',
                      style: TextStyle(
                        color: isAttractionSelected ? Colors.white : Colors.black,
                        fontFamily: 'pretendardBold',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isAttractionSelected = false;
                      });
                    },
                    style: TextButton.styleFrom(
                      padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      backgroundColor: isAttractionSelected
                          ? Colors.grey.withOpacity(0.3)
                          : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      '숙소',
                      style: TextStyle(
                        color: isAttractionSelected ? Colors.black : Colors.white,
                        fontFamily: 'pretendardBold',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecommendtourlistPage(
                          touristAttractionNames: touristAttractionNames,
                          gwangwangjibunho: gwangwangjibunho,
                        ),
                      ),
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
            SizedBox(height: 5),
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
                        for (String tag in isAttractionSelected ? randomTags : suksoTags)
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Handle tag selection here
                                });
                              },
                              child: Chip(
                                label: Text(
                                  tag,
                                  style: TextStyle(
                                    fontFamily: 'pretendardBold',
                                    color: isAttractionSelected && tag == '#전체'
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                backgroundColor:
                                isAttractionSelected && tag == '#전체'
                                    ? Colors.blue
                                    : Colors.grey.withOpacity(0.3),
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
                            Timer(const Duration(milliseconds: 200), () {
                              if (_isDoubleTap) return;
                              setState(() {
                                selectedSlideIndex = index;
                              });
                              _updateMapPosition(index);
                              _isDoubleTap = false;
                            });
                          },
                          onDoubleTap: () {
                            setState(() {
                              _isDoubleTap = true;
                            });
                            detail(index);
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
                  Provider.of<SelectedModel>(context, listen: false)
                      .addItem(gwangwangjibunho[selectedSlideIndex]);
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Maps2Page(),
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

  void _updateMapPosition(int index) {
    if (_controller != null) {
      if (slideCoordinates[index].latitude != null &&
          slideCoordinates[index].longitude != null) {
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
}
