import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  final List<Map<String, dynamic>> searchResults = [
    {
      'title': '최단경로',
      'duration': '1시간 18분',
      'distance': '5.5km',
    },
    {
      'title': '휠체어',
      'duration': '1시간 59분',
      'icon': Icons.accessibility,
      'subtitle': '휠체어',
      'duration2': '1시간 59분',
    },
    {
      'title': '비슷한 검색 결과 1',
      'duration': '2시간 30분',
      'icon': Icons.directions_bus,
      'subtitle': '버스',
      'duration2': '2시간 30분',
    },
    {
      'title': '비슷한 검색 결과 2',
      'duration': '1시간 45분',
      'icon': Icons.train,
      'subtitle': '지하철',
      'duration2': '1시간 45분',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('경로 검색 결과'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: '출발지',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    hintText: '도착지',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTagButton('전체'),
                _buildTagButton('도보'),
                _buildTagButton('버스'),
                _buildTagButton('지하철'),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          ...searchResults.map((result) {
            return GestureDetector(
              onTap: () {
                if (result['title'] == '최단경로') {
                  Navigator.pushNamed(context, '/searchfinal');
                } else {
                  // Handle other item clicks
                  print('Clicked: ${result['title']}');
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(result['title']),
                        Text(
                          '${result['duration']} | ${result['distance'] ?? ''}',
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0),
                    if (result.containsKey('icon') && result.containsKey('subtitle'))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(result['icon']),
                              SizedBox(width: 8.0),
                              Text(result['subtitle']),
                            ],
                          ),
                          Text(result['duration2']),
                        ],
                      ),
                    SizedBox(height: 8.0),
                    LinearProgressIndicator(
                      value: 0.7,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTagButton(String tag) {
    return ElevatedButton(
      onPressed: () {
        // Handle tag button pressed
      },
      child: Text(tag),
    );
  }
}
