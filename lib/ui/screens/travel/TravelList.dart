import 'package:flutter/material.dart';
import 'package:mazangdong/ui/screens/map/maps.dart';
import 'package:mazangdong/ui/screens/map/map2.dart';
import 'package:mazangdong/ui/screens/travel/TravleDetail.dart';


class TravelListPage extends StatefulWidget {
  @override
  _TravelListPageState createState() => _TravelListPageState();
}

class _TravelListPageState extends State<TravelListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 80),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '누구에게 어울리는 총 몇 개의 관광지를 찾았어요',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  iconSize: 50,
                  icon: Image.asset('assets/images/Kakao_logo.jpg'),
                  onPressed: () {
                    // 별 아이콘 버튼 클릭 시 동작
                  },
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5,
                  )
              ),
            ),
            SizedBox(height: 10.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TagWidget(title: '장애인 주차장'),
                  SizedBox(width: 16.0),
                  TagWidget(title: '장애인 전용 화장실'),
                  SizedBox(width: 16.0),
                  TagWidget(title: '휠체어 대어'),
                  SizedBox(width: 16.0),
                  TagWidget(title: '무단차/경사로'),
                  SizedBox(width: 16.0),
                  TagWidget(title: '엘리베이터'),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5,
                  )
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(8, (index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // 박스 색깔 흰색
                          borderRadius: BorderRadius.circular(8.0),
                          // width: 90,height: 100,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          leading: Image.asset('assets/images/3.jpg',
                            width: 100,height: 100,),
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
                                      // 지도테스트 버튼 클릭 시 동작
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 20.0, // Fixed height of 20
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "sssssssssssssssss",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              TextButton(
                child: Text(
                  "확인",
                  style: TextStyle(fontSize: 18.0),
                ),
                onPressed: () {
                  // Handle confirm button press
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class TagWidget extends StatelessWidget {
  final String title;
  const TagWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
