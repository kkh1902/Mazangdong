import 'package:flutter/material.dart';
import 'package:mazangdong/ui/screens/map/maps.dart';
import 'package:mazangdong/ui/screens/map/map2.dart';
import 'package:mazangdong/ui/screens/travel/TravleDetail.dart';

class TravelListPage extends StatefulWidget {
  @override
  _TravelListPageState createState() => _TravelListPageState();
}

class _TravelListPageState extends State<TravelListPage> {
  void _showBottomModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          // Add horizontal padding
          child: Container(
            child: Wrap(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 50.0),
                  child: Text(
                    '동행여부',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle option button 1 tap
                      },
                      child: Text('옵션 1'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        // Set button background color to grey
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        // Set button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set button shape to circular
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle option button 2 tap
                      },
                      child: Text('옵션 2'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        // Set button background color to grey
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        // Set button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set button shape to circular
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle option button 1 tap
                      },
                      child: Text('옵션 1'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        // Set button background color to grey
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        // Set button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set button shape to circular
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle option button 2 tap
                      },
                      child: Text('옵션 2'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        // Set button background color to grey
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        // Set button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set button shape to circular
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle option button 3 tap
                      },
                      child: Text('옵션 3'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        // Set button background color to grey
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        // Set button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
// Handle option button 1 tap
                      },
                      child: Text('옵션 1'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        // Set button background color to grey
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        // Set button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set button shape to circular
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
// Handle option button 2 tap
                      },
                      child: Text('옵션 2'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        // Set button background color to grey
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        // Set button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set button shape to circular
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
// Handle option button 3 tap
                      },
                      child: Text('옵션 3'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        // Set button background color to grey
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        // Set button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set button shape to circular
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
// Handle option button 1 tap
                      },
                      child: Text('옵션 1'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        // Set button background color to grey
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        // Set button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set button shape to circular
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
// Handle option button 2 tap
                      },
                      child: Text('옵션 2'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        // Set button background color to grey
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        // Set button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set button shape to circular
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
// Handle option button 3 tap
                      },
                      child: Text('옵션 3'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        // Set button background color to grey
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        // Set button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Set button shape to circular
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 80),
        child: Column(
          textDirection: TextDirection.ltr,
          // Set the text direction explicitly
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
                ), IconButton(
                  iconSize: 50,
                  icon: Image.asset('assets/images/googlemap.png'),
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
                ),
              ),
            ),
            SizedBox(height: 10.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: _showBottomModal,
                    child: TagWidget(title: '장애인 주차장'),
                  ),
                  SizedBox(width: 16.0),
                  GestureDetector(
                    onTap: _showBottomModal,
                    child: TagWidget(title: '장애인 전용 화장실'),
                  ),
                  SizedBox(width: 16.0),
                  GestureDetector(
                    onTap: _showBottomModal,
                    child: TagWidget(title: '휠체어 대여'),
                  ),
                  SizedBox(width: 16.0),
                  GestureDetector(
                    onTap: _showBottomModal,
                    child: TagWidget(title: '무단차/경사로'),
                  ),
                  SizedBox(width: 16.0),
                  GestureDetector(
                    onTap: _showBottomModal,
                    child: TagWidget(title: '엘리베이터'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Expanded( // Use Expanded widget to take remaining space
              child: ListView
                  .builder( // Use ListView.builder instead of SingleChildScrollView to handle dynamic content
                itemCount: 8,
                // Change the itemCount to the desired number of items
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        leading: Image.asset(
                          'assets/images/3.jpg',
                          width: 100,
                          height: 100,
                        ),
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
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TravelDetailPage(),
                                      ),
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
                                      MaterialPageRoute(
                                        builder: (context) => MapsPage(),
                                      ),
                                    );
// 전화하기 버튼 클릭 시 동작
                                  },
                                ),
                                TextButton(
                                  child: Text('지도테스트'),
                                      onPressed: () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(
                                builder: (context) => Map2Page(),
                                ),
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
                },
              ),
            ),
            SizedBox(height: 20.0), // Add some vertical spacing
            ElevatedButton( // Add the circular button
              onPressed: () {
// Handle button tap
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 50,
                ),
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