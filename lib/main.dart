import 'package:flutter/material.dart';
import 'package:mazangdong/ui/screens/select/SelectConv.dart';
import 'package:mazangdong/ui/screens/select/SelectGuardian.dart';
import 'package:mazangdong/ui/screens/select/SelectRegion.dart';
import 'package:mazangdong/ui/screens/select/SelectComplete.dart';
import 'package:mazangdong/ui/screens/travel/TravelList.dart';
import 'package:mazangdong/ui/screens/travel/TravleDetail.dart';
import 'package:mazangdong/ui/screens/map/maps.dart';
import 'package:mazangdong/ui/screens/map/map2.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/selectGuardian': (context) => SelectGuardianPage(),
        '/selectConv': (context) => SelectConvPage(),
        '/selectRegion': (context) => SelectRegionPage(),
        '/selectComplete': (context) => SelectCompletePage(),
        '/TravelList': (context) => TravelListPage(),
        '/TravelDetail': (context) => TravelDetailPage(),
        '/maps': (context) => MapsPage(),
        '/map2': (context) => Map2Page(),

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
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        primary: Colors.green, // 초록색 배경
                      ),
                      child: Text(
                        '시작하기',
                        style: TextStyle(fontSize: 20.0),
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
