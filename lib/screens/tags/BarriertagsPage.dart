import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class BarrierTagsPage extends StatefulWidget {
  @override
  _BarrierTagsPageState createState() => _BarrierTagsPageState();
}

class _BarrierTagsPageState extends State<BarrierTagsPage> {
  final List<String> dataList = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ]; // Example data list, replace it with your fetched data

  double listViewHeight = 200.0;
  bool isExpanded = false;
  List<Marker> markers = [];
  List<Marker> barrierMarkers = [];

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
  void initState() {
    super.initState();
    fetchBarrierLocations();
  }

  void fetchBarrierLocations() async {
    final response = await http.get(Uri.parse('https://majangdong.run.goorm.site/barrier'));
    if (response.statusCode == 200) {
      final barrierData = json.decode(response.body);
      print('ssss');
      print(barrierData[0]);
      print("barielength");
      print(barrierData[0].length);

      // Create the markers based on the data
      for (int i = 0; i < barrierData[0].length; i++) {
        Map<String, dynamic> location = barrierData[0][i];
        double? latitude = double.tryParse(location['위도']);
        double? longitude = double.tryParse(location['경도']);

        if (latitude != null && longitude != null) {
          Marker marker = Marker(
            markerId: location['번호'].toString(),
            position: LatLng(latitude, longitude),
            iconTintColor: Colors.blue,
            // Add other properties of the marker if necessary
          );
          barrierMarkers.add(marker);
        } else {
          print("Invalid coordinates for location ${location['번호']}: ${location['위도']}, ${location['경도']}");
        }
      }


      // Update the markers list in the state and refresh the UI
      setState(() {
        markers = barrierMarkers;
      });

    } else {
      // Handle error response
      print('Failed to fetch barrier locations: ${response.statusCode}');
    }
  }



  // final markers = barrierData.map((location) => Marker(
  //   markerId: location['id'],
  //   position: LatLng(location['latitude'], location['longitude']),
  //   // Set other properties of the marker as needed
  // )).toList();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '주변 배리어',
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
            markers: List<Marker>.from(barrierMarkers),
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
