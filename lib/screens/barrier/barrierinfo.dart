import 'package:flutter/material.dart';
import 'package:dong/screens/barrier/barrierpicture.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class BarrierInfoPage extends StatefulWidget {
  @override
  _BarrierInfoPageState createState() => _BarrierInfoPageState();
}

class _BarrierInfoPageState extends State<BarrierInfoPage> {
  LatLng _markerPosition = LatLng(35.1567, 129.0704); // Initial marker position

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
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
            color: Colors.grey[300],
            height: 1.0,
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
              height: 40.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '상세 주소를 입력하세요:',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                  ),
                ],
              ),
            ),
            Container(
              height: 30.0,
              child: TextFormField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: '주소를 입력하세요',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Container(
                color: Colors.grey[200],
                child: NaverMap(
                  initialCameraPosition: CameraPosition(
                    target: _markerPosition,
                    zoom: 15.0,
                  ),
                  markers: [
                    Marker(
                      markerId: 'marker_id',
                      position: _markerPosition,
                      anchor: AnchorPoint(0.5, 0.5),
                    ),
                  ],
                  onMapCreated: (controller) {},
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
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                minimumSize: Size(double.infinity, 50.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
