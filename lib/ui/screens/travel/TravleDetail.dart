import 'package:flutter/material.dart';

class TravelDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('제주 공원'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // 2-1: Multiple Images
          Container(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Image.asset('assets/images/doll.jpg',
                  fit: BoxFit.cover,),
                Image.asset('assets/images/trip.png'),
                Image.asset('assets/images/trip.png'),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          // 2-2: Text "나와의 거리 약 2.3km"
          Text(
            '나와의 거리 약 2.3km',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 8.0),
          // 2-3: Text "제주시 조찬음 남요읍 2023"
          Text(
            '제주시 조찬음 남요읍 2023',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 16.0),
          // 2-4: Buttons "길안내" and "전화하기"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Handle 길안내 button pressed
                },
                icon: Icon(Icons.directions),
                label: Text('길안내'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle 전화하기 button pressed
                },
                icon: Icon(Icons.phone),
                label: Text('전화하기'),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          // 2-5: Five Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.safety_check),
              Icon(Icons.safety_check),
              Icon(Icons.safety_check),
              Icon(Icons.safety_check),
              Icon(Icons.safety_check),
            ],
          ),
          SizedBox(height: 16.0),
          // 2-6: Text "설명"
          Text(
            '설명',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 8.0),
          // 2-7: Text "부랴부랴"
          Text(
            '부랴부랴',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          // 2-8: Text "참고"
          Text(
            '참고',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          // 2-9: Text "부랴부랴"
          Text(
            '부랴부랴',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
