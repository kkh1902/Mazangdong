import 'package:flutter/material.dart';

class MyRecordPage extends StatelessWidget {
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
          '나의 여정 기록',
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
            child: Text(
              '총 2건',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              ListTile(
                title: Text('2023년 05월 29일 ~ 2023년 05월 30일'),
              ),
              Divider(),
              ListTile(
                title: Text('2023년 05월 30일 18:18 ~ 2023년 05월 30일 18:20'),
                subtitle: Text('부산 광역시 사상구 주례로 47 동서대학교'),
              ),
              Divider(),
              ListTile(
                title: Text('2023년 05월 30일 18:18 ~ 2023년 05월 30일 18:20'),
                subtitle: Text('부산 광역시 사상구 주례로 47 동서대학교'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}