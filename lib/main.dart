import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:mazangdong/models/SelectedModel.dart';
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/models/RegionModel.dart';
import 'package:mazangdong/models/ThemaModel.dart';
import 'package:mazangdong/models/ResponseModel.dart';
import 'package:mazangdong/ui/screens/select/SelectConv.dart';
import 'package:mazangdong/ui/screens/select/SelectBus.dart';
import 'package:mazangdong/ui/screens/select/SelectGuardian.dart';
import 'package:mazangdong/ui/screens/select/SelectRegion.dart';
import 'package:mazangdong/ui/screens/select/SelectComplete.dart';
import 'package:mazangdong/ui/screens/select/SelectNickname.dart';
import 'package:mazangdong/ui/screens/select/SelectTransportation.dart';
import 'package:mazangdong/ui/screens/travel/TravelList.dart';
import 'package:mazangdong/ui/screens/travel/TravleDetail.dart';
import 'package:mazangdong/ui/screens/travel/RecommedTourlist.dart';
import 'package:mazangdong/ui/screens/travel/Recommendaccomodationlist.dart';
import 'package:mazangdong/ui/screens/map/maps.dart';
import 'package:mazangdong/ui/screens/map/map2.dart';
import 'package:mazangdong/ui/screens/map/maproad.dart';
import 'dart:convert';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedModel()),
      ],
      child: MyApp(),
    ),
  );
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
        '/selectNickname': (context) =>
            SelectNicknamePage(),
        '/selectGuardian': (context) => SelectGuardianPage(convModel: convModel),
        '/selectTransportation': (context) => SelectTransportationPage(
          convModel: convModel,
        ),
        '/selectBus': (context) => SelectBusPage(
          convModel: convModel,
        ),
        '/selectConv': (context) => SelectConvPage(convModel: convModel),
        '/selectRegion': (context) => SelectRegionPage(convModel: convModel),
        '/selectComplete': (context) => SelectCompletePage(
            convModel: convModel,
            regionModel: regionModel),
        '/travelList': (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SelectedModel()),
          ],
          child: TravelListPage(responseModel: responseModel),
        ),

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: null,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // color: Color(0xfff8f8f8),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  minWidth: MediaQuery.of(context).size.width,
                  maxHeight: MediaQuery.of(context).size.height / 1.5,
                ),
                decoration: BoxDecoration(
                  // color: Color(0xFFEBEBEB),
                    color: Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(125),
                        bottomRight: Radius.circular(125)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3))
                    ]),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 80),
                      Text(
                        "환영합니다.",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000)),
                      ),
                      SizedBox(
                        height: 300,
                        width: 350,
                        child: Image.asset('assets/images/logo/main_mapo_logo.png'),
                      )
                    ]),
              ),
              Container(
                margin: EdgeInsets.only(top: 80),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 1.5,
                  minHeight: MediaQuery.of(context).size.height / 10,
                ),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        side: BorderSide(color: Color(0xFF00adef))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectNicknamePage()));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(""),
                        Text(
                          "시작하기",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    )),
              )
            ],
          )),
    );
  }
}
