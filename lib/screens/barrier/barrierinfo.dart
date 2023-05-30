import 'package:flutter/material.dart';
import 'package:dong/screens/barrier/barrierpicture.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class BarrierInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true, // Center-align the title
        title: Text(
          '배리어 제보',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300], // Border color
            height: 1.0, // Border height
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '어디에 위치한 배리어 인가요?',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 40.0, // Set a fixed height for the text field
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter detailed address:',
                    style: TextStyle(
                      color: Colors.black, // Text color
                    ),
                  ),
                  Divider(
                    color: Colors.grey, // Underline color
                    thickness: 1.0, // Underline thickness
                  ),
                ],
              ),
            ),
            Container(
              height: 30.0, // Set a fixed height for the text field
              child: TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey), // Underline color
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey), // Underline color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey), // Underline color
                  ),
                  hintText: 'Enter address',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Container(
                color: Colors.grey[200], // Placeholder color for the map
                child: NaverMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        37.5665, 126.9780), // Set the initial map position
                    zoom: 15.0, // Set the initial zoom level
                  ),
                  // Add other NaverMap configurations as needed
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BarrierpicturePage()),
                );
              },
              child: Text(
                '다음',
                style: TextStyle(
                  fontSize: 20.0, // Set the font size to 20
                  color: Colors.black, // Set the text color to black
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow, // Set the background color to yellow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      30.0), // Set the border radius to make it rounded
                ),
                minimumSize: Size(double.infinity,
                    50.0), // Set the minimum size with desired height
              ),
            ),
          ],
        ),
      ),
    );
  }
}
