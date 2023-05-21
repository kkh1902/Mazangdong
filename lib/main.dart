import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/models/RegionModel.dart';
import 'package:mazangdong/models/ThemaModel.dart';
import 'package:mazangdong/models/ResponseModel.dart';
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
import 'package:mazangdong/ui/screens/map/maproad.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var convModel = ConvModel(); // Example initialization
  var regionModel = RegionModel();
  var themaModel = ThemaModel();
  var responseModel = ResponseModel(trip: [], lodging: []);
  List<String> touristAttractionNames = []; // 변수 선언부분을 수정합니다.
  List<int> gwangwangjibunho = [];


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
        '/travelList': (context) => TravelListPage(responseModel: responseModel),
        '/travelDetail': (context) => TravelDetailPage(bunho: ModalRoute.of(context)!.settings.arguments as int),
        '/recommendtourlist': (context) => RecommendtourlistPage(touristAttractionNames:touristAttractionNames,gwangwangjibunho:gwangwangjibunho ),
        '/recommendaccomlist': (context) => RecommendaccomodationlistPage(),
        '/maps': (context) => MapsPage(),
        '/map2': (context) => Maps2Page(),
        '/maproad': (context) => MapRoadPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
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
