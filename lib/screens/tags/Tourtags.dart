import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class tourTagsPage extends StatefulWidget {
  @override
  _tourTagsPageState createState() => _tourTagsPageState();
}

class _tourTagsPageState extends State<tourTagsPage> {
  final List<String> dataList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ]; // Example data list, replace it with your fetched data

  double listViewHeight = 200.0;
  bool isExpanded = false;

  void toggleListViewSize() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        listViewHeight = MediaQuery.of(context).size.height;
      } else {
        listViewHeight = 200.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '주변 광광지 정보',
          style: TextStyle(
            color: Colors.black, // Set text color to black
          ),
        ),
        backgroundColor: Colors.white, // Set background color to white
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black, // Set icon color to black
          ),
          onPressed: () {
            Navigator.pop(context); // Handle back button press
          },
        ),
      ),
      body: Stack(
        children: [
          NaverMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                35.1565,
                129.0594,
              ), // Example coordinates
              zoom: 14.0,
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: IconButton(
              icon: Icon(
                Icons.location_on,
                color: Colors.black, // Set icon color to black
              ),
              onPressed: () {
                // Handle location icon pressed
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy < -5) {
                  // Swiped up
                  toggleListViewSize();
                } else if (details.delta.dy > 5) {
                  // Swiped down
                  toggleListViewSize();
                }
              },
              child: Container(
                height: listViewHeight,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[300],
                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(dataList[index]),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
