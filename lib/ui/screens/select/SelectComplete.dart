import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/models/RegionModel.dart';
import 'package:mazangdong/models/ThemaModel.dart';
import 'package:mazangdong/models/ResponseModel.dart';
import 'package:mazangdong/ui/screens/travel/TravelList.dart';
import 'dart:convert';

class SelectCompletePage extends StatefulWidget {
  final ConvModel convModel;
  final RegionModel regionModel;
  final ThemaModel themaModel;

  SelectCompletePage({
    required this.convModel,
    required this.regionModel,
    required this.themaModel,
  });

  @override
  _SelectCompletePageState createState() => _SelectCompletePageState();
}

class _SelectCompletePageState extends State<SelectCompletePage> {
  late ResponseModel responseModel;

  @override
  void initState() {
    super.initState();
    responseModel = ResponseModel(trip: [], lodging: []);
  }

  Future<void> _sendRequest() async {
    var url = 'https://majangdong.run.goorm.site/info';
    var data = {
      'together': '1',
      'parking': '1',
      'wheelchair': '1',
      'restroom': '1',
      'region': '8',
    };

    var uri = Uri.parse(url);
    var queryParameters = data.entries.map((e) => '${e.key}=${e.value}').join('&');
    var requestUrl = Uri.parse('$uri?$queryParameters');

    try {
      var response = await http.get(requestUrl);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print('SSSSS$jsonResponse');

        responseModel = ResponseModel.fromJson(jsonResponse);

        // Iterate over trip models and add latitude and longitude
        for (var tripModel in responseModel.trip) {
          var geocodeUrl =
              'https://maps.googleapis.com/maps/api/geocode/json?address=${tripModel.juso}&key=AIzaSyAD2Tf6yBI9jb2abxGVZGlMKmoqDglhYzs';
          print("시발시발시발시발시발시발시발시발시발시발시발시발시발시발시발");
          print("tripModel: ${tripModel.juso}");
          print('geocodeUrl: $geocodeUrl');
          var geocodeResponse = await http.get(Uri.parse(geocodeUrl));
          if (geocodeResponse.statusCode == 200) {
            var geocodeJson = json.decode(geocodeResponse.body);
            if (geocodeJson['results'] != null && geocodeJson['results'].isNotEmpty) {
              var location = geocodeJson['results'][0]['geometry']['location'];
              tripModel.latitude = location['lat'];
              tripModel.longitude = location['lng'];
            }
          }
        }

        // Iterate over lodging models and add latitude and longitude
        for (var lodgingModel in responseModel.lodging) {
          var geocodeUrl =
              'https://maps.googleapis.com/maps/api/geocode/json?address=${lodgingModel.sungbaksiseoljuso}&key=AIzaSyAD2Tf6yBI9jb2abxGVZGlMKmoqDglhYzs';
          var geocodeResponse = await http.get(Uri.parse(geocodeUrl));
          if (geocodeResponse.statusCode == 200) {
            var geocodeJson = json.decode(geocodeResponse.body);
            if (geocodeJson['results'] != null && geocodeJson['results'].isNotEmpty) {
              var location = geocodeJson['results'][0]['geometry']['location'];
              lodgingModel.latitude = location['lat'];
              lodgingModel.longitude = location['lng'];
            }
          }
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred during request: $error');
    }
  }



  void goToNextPage(BuildContext context) async {
    await _sendRequest();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TravelListPage(responseModel: responseModel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                backgroundColor: Colors.grey[200],
                value: 1.0,
                minHeight: 8.0,
              ),
            ),
            SizedBox(height: 20),
            Image.asset('assets/images/trip.png'),
            SizedBox(height: 20),
            Text(
              '완료되었습니다.',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff50bcdf),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  '이전',
                  style: TextStyle(fontSize: 20, fontFamily: 'PretendardBold'),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  goToNextPage(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffa3cc9b),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  '다음',
                  style: TextStyle(fontSize: 20, fontFamily: 'PretendardBold'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
