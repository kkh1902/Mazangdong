import 'package:flutter/material.dart';

class TravelDetailPage extends StatefulWidget {
  @override
  _TravelDetailPageState createState() => _TravelDetailPageState();
}

class _TravelDetailPageState extends State<TravelDetailPage> {
  List<String> imagePaths = [
    'assets/images/3.jpg',
    'assets/images/3.jpg',
    'assets/images/3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 70.0, 10.0, 10.0),
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blue),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 16.0),
                Text(
                  '제주 공원',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        imagePaths[index],
                        fit: BoxFit.cover,
                        width: 200, // Adjust the width as desired
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '나와의 거리 약 2.3km',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '제주시 조찬음 남요읍 2023',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle 길안내 button pressed
                    },
                    icon: Icon(Icons.directions),
                    label: Text('길안내'),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle 전화하기 button pressed
                    },
                    icon: Icon(Icons.phone),
                    label: Text('전화하기'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/convenince/parking.png'),
                  radius: 30,
                ),
                CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/wc.png'),
                  radius: 30,
                ),
                CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/wheel.png'),
                  radius: 30,
                ),
                CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/wheeldog.png'),
                  radius: 30,
                ),
                CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/경사로.png'),
                  radius: 30,
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              '설명',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '부랴부랴',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '참고',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '부랴부랴',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
