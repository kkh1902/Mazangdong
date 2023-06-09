import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class SearchFinalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('부산 광역시 사상... -> 서면 시장'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: NaverMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.5665, 126.9780), // Set the initial map position
                zoom: 13.0, // Set the initial zoom level
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '최단경로',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text('1시간 18분 | 5.5km'),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(Icons.accessibility),
                    SizedBox(width: 8.0),
                    Text('휠체어'),
                    SizedBox(width: 8.0),
                    Text('1시간 59분'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          LinearProgressIndicator(
            value: 0.7,
          ),
          SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.directions_walk),
            title: Text('출발 부산광역시 사상구 주례로 47'),
            subtitle: Text('부산광역시 사상구 주례로 47에서 서면시장까지 5.5km 걷기'),
          ),
        ],
      ),
    );
  }
}
