import 'package:flutter/material.dart';
import 'package:mazangdong/ui/screens/map/maps.dart';
import 'package:mazangdong/ui/screens/map/map2.dart';
import 'package:mazangdong/ui/screens/travel/TravleDetail.dart';

class TravelListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("누구님 근처 35개 추천 관광지", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.star),
                  onPressed: () {
                    // 별 아이콘 버튼 클릭 시 동작
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TagWidget(title: '장애인 주차장', distance: '나와의 거리'),
                  SizedBox(width: 16.0),
                  TagWidget(title: '장애인 전용 화장실', distance: '나와의 거리'),
                  SizedBox(width: 16.0),
                  TagWidget(title: '무단차/경사로', distance: '나와의 거리'),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset('assets/images/trip.png'),
                    title: Text('제주 문화공원'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('나와의 거리'),
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            TextButton(
                              child: Text('길안내'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => TravelDetailPage()),
                                );
                                // 길안내 버튼 클릭 시 동작
                              },
                            ),
                            SizedBox(width: 8.0),
                            TextButton(
                              child: Text('전화하기'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MapsPage()),
                                );
                                // 전화하기 버튼 클릭 시 동작
                              },
                            ),
                            TextButton(
                              child: Text('지도테스트'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Map2Page()),
                                );
                                // 길안내 버튼 클릭 시 동작
                              },
                            ),
                          ],
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
    );
  }
}

class TagWidget extends StatelessWidget {
  final String title;
  final String distance;

  const TagWidget({
    Key? key,
    required this.title,
    required this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            distance,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
