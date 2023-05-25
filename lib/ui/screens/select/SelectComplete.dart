import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mazangdong/ui/screens/travel/TravelList.dart';
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/models/RegionModel.dart';
import 'package:mazangdong/models/ThemaModel.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import 'indicator.dart' as PageCount;

class SelectCompletePage extends StatelessWidget {
  final ConvModel convModel;
  final RegionModel regionModel;

  SelectCompletePage({
    required this.convModel,
    required this.regionModel,
  }) {
    print("convModel: $convModel");
    print("regionModel: $regionModel");
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
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => TravelListPage(),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
          padding: EdgeInsets.fromLTRB(5.0, 55.0, 5.0, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 10),
                  Text(
                    '',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PretendardSemiBold',
                        color: Colors.black),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '선택이 완료되었습니다',
                  style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'PretendardSemiBold',
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 128,
                width: 128,
                child: Image.asset('assets/images/icons/complete_logo.png'),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 1.5,
                  minHeight: MediaQuery.of(context).size.height / 10,
                ),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      side: BorderSide(color: Color(0xFF00adef))),
                  onPressed: () {
                    goToNextPage(context);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(""),
                        Text(
                          '확인',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'PretendardSemiBold',
                              color: Colors.black),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ]),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PageViewDotIndicator(
                  currentItem: 5,
                  count: PageCount.PageCount().count,
                  unselectedColor: Colors.black26,
                  selectedColor: Colors.blue,
                  size: const Size(18.0, 9.0),
                  unselectedSize: const Size(8, 8),
                  duration: Duration(milliseconds: 200),
                  boxShape: BoxShape.circle,
                ),
              ),
            ],
          )),
    );
  }
}