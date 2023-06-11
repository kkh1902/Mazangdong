import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;

class DirectionPage extends StatefulWidget {
  @override
  _DirectionPageState createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {
  NaverMapController? _controller;
  String startLocation = "";
  String goalLocation = "";
  String startTime = "";
  CameraPosition? _initialCameraPosition;

  @override
  void initState() {
    super.initState();
    fetchCoordinates();
  }

  void fetchCoordinates() async {
    final url = Uri.parse('https://majangdong.run.goorm.site/find');
    final payload = {
      "home": {"x": 127.0289, "y": 37.4971},
      "trip": {"x": 128.0289, "y": 38.4971},
      "busChk": 0
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final homeCoordinates = data[0];
      final tripCoordinates = data.sublist(1);

      final startLatitude = homeCoordinates['sy'];
      final startLongitude = homeCoordinates['sx'];

      List<double> destinationLatitudes = [];
      List<double> destinationLongitudes = [];

      for (var i = 0; i < tripCoordinates.length; i++) {
        final destinationLatitude = tripCoordinates[i]['ey'];
        final destinationLongitude = tripCoordinates[i]['ex'];

        destinationLatitudes.add(destinationLatitude.toDouble());
        destinationLongitudes.add(destinationLongitude.toDouble());
      }

      setState(() {
        startLocation = "부산광역시 사상구 주례로 47";
        goalLocation = "서면시장";
        startTime = "오늘 11시 45분 출발";
        _initialCameraPosition = CameraPosition(
          target: LatLng(startLatitude.toDouble(), startLongitude.toDouble()),
          zoom: 13.0,
        );

        // TODO: Fetch and display route using Naver Map Directions API
      });
    } else {
      print('Failed to fetch coordinates: ${response.statusCode}');
    }
  }

  void _onMapCreated(NaverMapController controller) {
    setState(() {
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 80.0,
              child: Text(
                startLocation,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
              child: Icon(
                Icons.arrow_right_alt_rounded,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 80.0,
              child: Text(
                goalLocation,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black, size: 18.0),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[100],
            height: 4.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          if (_initialCameraPosition != null)
            NaverMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialCameraPosition!,
            ),
          if (_initialCameraPosition == null)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naver Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DirectionPage(),
    );
  }
}
