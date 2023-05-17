import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/models/RegionModel.dart';
import 'package:mazangdong/models/ThemaModel.dart';
import 'package:mazangdong/ui/screens/select/SelectConv.dart';
import 'package:mazangdong/ui/screens/select/SelectGuardian.dart';
import 'package:mazangdong/ui/screens/select/SelectRegion.dart';
import 'package:mazangdong/ui/screens/select/SelectComplete.dart';
import 'package:mazangdong/ui/screens/select/SelectNickname.dart';
import 'package:mazangdong/ui/screens/select/SelectThema.dart';
import 'package:mazangdong/ui/screens/travel/TravelList.dart';
import 'package:mazangdong/ui/screens/travel/TravleDetail.dart';
import 'package:mazangdong/ui/screens/travel/RecommedTourlist.dart';
import 'package:mazangdong/ui/screens/travel/Recommendaccomodationlist.dart';
import 'package:mazangdong/ui/screens/map/maps.dart';
import 'package:mazangdong/ui/screens/map/map2.dart';

import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var convModel = ConvModel(); // Example initialization
  var regionModel = RegionModel();
  var themaModel = ThemaModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/selectGuardian': (context) => SelectGuardianPage(),
        '/selectNickname': (context) =>
            SelectNicknamePage(convModel: convModel),
        '/selectConv': (context) => SelectConvPage(convModel: convModel),
        '/selectRegion': (context) => SelectRegionPage(convModel: convModel),
        '/selectThema': (context) => SelectThemaPage(
              convModel: convModel,
              regionModel: regionModel,
            ),
        '/selectComplete': (context) => SelectCompletePage(
            convModel: convModel,
            regionModel: regionModel,
            themaModel: themaModel),
        '/travelList': (context) => TravelListPage(),
        '/travelDetail': (context) => TravelDetailPage(),
        '/recommendtourlist': (context) => RecommendtourlistPage(),
        '/recommendaccomlist': (context) => RecommendaccomodationlistPage(),
        '/maps': (context) => MapsPage(),
        '/map2': (context) => Maps2Page(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  void _sendRequest() async {
    var url = 'https://se-fjnsi.run.goorm.site/info';
    // JSON 데이터 준비
    var data = {
      'together': '0',
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
    var responseBody = json.decode(response.body);

    print(uri);
    print(queryParameters);
    print(requestUrl);

    if (response.statusCode == 200) {
      print('Response: ${response.body}');
      print('responseBody: ${responseBody}');
      print('uri: ${uri}');
      print('queryParameters: ${queryParameters}');
      print('requestUrl: ${requestUrl}');
      // TODO: Handle the response data here
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  void _sendRequest2() async {
    var url = 'https://se-fjnsi.run.goorm.site/a';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Response: ${response.body}');
      // TODO: Handle the response data here
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: null,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/trip.png',
                width: 1000,
                height: 1000,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: _sendRequest,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: Colors.blue, // 초록색 배경
                      ),
                      child: Text('테스트')),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectGuardianPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: Color(0xffa3cc9b), // 초록색 배경
                      ),
                      child: Text(
                        '시작하기',
                        style: TextStyle(
                            fontSize: 20.0, fontFamily: 'PretendardBold'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
