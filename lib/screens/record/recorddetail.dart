import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MyRecordDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            // Handle back button pressed
          },
        ),
        title: Text(
          '나의 여정 기록 세부 정보',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '여행 일정',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text('2023년 05월 30일 18:18 ~ 2023년 05월 30일 18:20'),
                SizedBox(height: 16.0),
                Text(
                  '여행 거리',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text('부산 광역시 사상구 주례로 47 동서대학교'),
                SizedBox(height: 16.0),
                Text(
                  '여행 시간',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text('2분'),
                SizedBox(height: 16.0),
                Text(
                  '여행 경로',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text('부산 광역시 사상구 주례로 47 동서대학교'),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: NaverMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.5665, 126.9780), // Set the initial map position
              ),
            ),
          ),
        ],
      ),
    );
  }
}
