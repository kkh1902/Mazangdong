import 'package:flutter/material.dart';

class SelectParentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(20.0), // 여기서 높이 조정
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            toolbarHeight: 80.0, // 여기서 높이 조정
            // 다른 AppBar 속성들...
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: LinearProgressIndicator(
                value: 0.25,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '동행여부',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '보호자와 동행하시나요?',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Icon(
                      Icons.person,
                      size: 48.0,
                    ),
                    Text('혼자여행'),
                  ],
                ),
                SizedBox(width: 16.0),
                Column(
                  children: [
                    Icon(
                      Icons.person,
                      size: 48.0,
                    ),
                    Text('보호자와 함께 동행'),
                  ],
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.green,
          padding: EdgeInsets.all(16.0),
          child: TextButton(
            onPressed: () {
              // Handle button press
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            child: Text(
              '다음',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
