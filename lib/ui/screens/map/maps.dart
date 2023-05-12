import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194), // 초기 지도 중심 좌표
                zoom: 11.0,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 120,
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Tag 1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 120,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'Tag 2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 120,
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      'Tag 3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 120,
                  color: Colors.orange,
                  child: Center(
                    child: Text(
                      'Tag 4',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: 3, // 실제 아이템 수로 변경
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/trip.png'), // 실제 이미지 경로로 변경
                  ),
                  title: Text('Item $index'),
                  subtitle: Text('Description $index'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // 버튼 동작
                    },
                    child: Text('Button'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
