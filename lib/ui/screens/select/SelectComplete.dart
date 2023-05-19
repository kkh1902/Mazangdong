import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mazangdong/ui/screens/travel/TravelList.dart';
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/models/RegionModel.dart';
import 'package:mazangdong/models/ThemaModel.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';


class SelectCompletePage extends StatelessWidget {
  final ConvModel convModel;
  final RegionModel regionModel;
  final ThemaModel themaModel;

  SelectCompletePage({
    required this.convModel,
    required this.regionModel,
    required this.themaModel,
  }) {
    print("convModel: $convModel");
    print("regionModel: $regionModel");
    print("themaModel: $themaModel");
  }

  void _sendRequest() async {
    var url = 'https://se-fjnsi.run.goorm.site/info';

    // JSON 데이터 변경후 GET 요청하기

    // var data = {
    //   'together': convModel.isTravelingAlone,
    //   'parking': convModel.selectedOptions,
    //   'bathchair': convModel.selectedOptions,
    //   'restroom': convModel.selectedOptions,
    //   'region': regionModel.selectedRegions,
    // };
    // print("data $data");


    var data = {
      'together': '1',
      'parking': '1',
      'bathchair': '1',
      'restroom': '1',
      'region': '1',
    };

    // GET 요청의 쿼리 매개변수로 JSON 데이터 추가
    var uri = Uri.parse(url);
    var queryParameters =
        data.entries.map((e) => '${e.key}=${e.value}').join('&');
    var requestUrl = Uri.parse('$uri?$queryParameters');

    var response = await http.get(requestUrl);

    print("uri: $uri");
    print("queryParameters: $queryParameters");
    print("requestUrl: $requestUrl");

    if (response.statusCode == 200) {
      print('Response: ${response.body}');
      print('uri: ${uri}');
      print('queryParameters: ${queryParameters}');
      print('requestUrl: ${requestUrl}');
      final decodedData = json.decode(response.body);
      debugPrint('Response: $decodedData');
      // TODO: Handle the response data here
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  void goToNextPage(BuildContext context) {
    _sendRequest();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TravelListPage(),
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
            Image.asset(
                'assets/images/trip.png'), // Replace 'path_to_your_image' with the actual path or asset name of your image
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
                child: Text('이전',
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'PretendardBold')),
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
                child: Text('다음',
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'PretendardBold')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
