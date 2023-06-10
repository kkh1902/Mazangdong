import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dong/screens/barrier/barrierpicture.dart';
import 'package:http/http.dart' as http;
import 'package:dong/utils/geocoding_utils.dart';
import 'package:dong/models/barrierdata.dart';




class BarrierInfoPage extends StatefulWidget {
  @override
  _BarrierInfoPageState createState() => _BarrierInfoPageState();
}

class _BarrierInfoPageState extends State<BarrierInfoPage> {
  TextEditingController _addressController = TextEditingController();
  CameraPosition? _initialCameraPosition;
  NaverMapController? _controller;
  LatLng? _currentLocation;
  LatLng? _markerPosition;
  String? _markerAddress;
  List<Marker> _markers = [];
  String _detailedAddress = '';

  @override
  void initState() {
    super.initState();
    _markerPosition = LatLng(35.1577, 129.0591); // Set initial marker position to Busan Sasang-gu
    _markers.add(Marker(
      markerId: 'centerMarker',
      position: _markerPosition!,
      width: 48,
      height: 48,
    ));
  }

  void _onMapCreated(NaverMapController controller) {
    setState(() {
      _controller = controller;
      getCurrentLocation();
    });
  }

  void _onCameraIdle() async {
    final cameraPosition = await _controller?.getCameraPosition();

    setState(() {
      _markerPosition = cameraPosition?.target;
      // Update _markers with the new _markerPosition.
      _markers = [
        Marker(
          markerId: 'centerMarker',
          position: _markerPosition!,
          width: 48,
          height: 48,
        ),
      ];
    });

    // Get the address from LatLng and update _markerAddress.
    try {
      String newAddress = await getAddressFromLatLng(_markerPosition!);
      setState(() {
        _markerAddress = newAddress;
      });
    } catch (error) {
      print("Error getting address: $error");
    }
  }


  void getCurrentLocation() async {
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true,
      );
    } catch (e) {
      print('Error: $e');
    }

    if (position != null) {
      final latitude = position.latitude;
      final longitude = position.longitude;
      print('Current Location: $latitude, $longitude');

      final target = LatLng(latitude, longitude);
      final cameraUpdate = CameraUpdate.scrollTo(target);
      _controller?.moveCamera(cameraUpdate);
    }
  }


  void navigateToBarrierPicturePage() {
    final barrier = BarrierData(
      type: '',
      address: _markerAddress ?? '',
      latitude: _markerPosition?.latitude ?? 0.0,
      longitude: _markerPosition?.longitude ?? 0.0,
      bypass: false, // By default, set bypass to false
      nickname: '', // Set nickname to an empty string
      photo: '', // Change 'picture' to 'photo'
      detailedAddress: _detailedAddress,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BarrierpicturePage(barrier: barrier),
      ),
    );
  }



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
              height: 30,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey),
                ),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Text(
                  _markerAddress ?? '주소를 입력하세요',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),


            Container(
              height: 40.0,
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
                  hintText: '상세 주소를 입력하세요',
                ),
                onChanged: (value) {
                  setState(() {
                    _detailedAddress = value;
                  });
                },
              ),
            ),

            SizedBox(height: 16.0),
            Expanded(
              child: Container(
                color: Colors.grey[200],
                child: NaverMap(
                  onMapCreated: _onMapCreated,
                  onCameraIdle: _onCameraIdle, // Add onCameraIdle callback
                  initialCameraPosition: CameraPosition(
                    target: _markerPosition!,
                    zoom: 18,
                  ),
                  markers: _markers,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                navigateToBarrierPicturePage();
              },
              child: Text(
                '다음',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
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
