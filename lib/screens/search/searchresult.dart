import 'dart:math';
import 'package:flutter/material.dart';
import 'package:dong/screens/search/searchresult.dart';
import 'package:logger/logger.dart';

class SearchResultPage extends StatefulWidget {
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  String startLocation = "부산광역시 사상구 주례로 47";
  String goalLocation = "서면시장";
  String startTime = '';

  @override
  void initState() {
    super.initState();
    setStartTime();
  }

  void setStartTime() {
    setState(() {
      startTime = '오늘 ${DateTime.now().hour}시 ${DateTime.now().minute}분 출발';
    });
  }


  @override
  Widget build(BuildContext context) {

    final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      final double latitude = arguments['latitude'];
      final double longitude = arguments['longitude'];
      final String goalarea = arguments['goalarea'];

      if (goalarea != null) {
        setState(() {
          goalLocation = goalarea;
        });
      }

      // Use the received values as needed
      // For example, you can update the goalLocation variable with the received goalarea value

      // Use the latitude and longitude for further processing
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false, // Center-align the title
        title: const Text(
          '경로 검색 결과',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.0),
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close, color: Colors.black, size: 18.0),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[100], // Border color
            height: 4.0, // Border height
          ),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 8.0),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: startLocation,
                                labelStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                                hintText: '출발지',
                                filled: true,
                                fillColor: Colors.grey[100],
                                contentPadding:
                                EdgeInsets.only(left: 16.0, right: 16.0)),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: goalLocation,
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                              hintText: '목적지',
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding:
                              EdgeInsets.only(left: 16.0, right: 16.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.swap_vert, color: Colors.black),
                    onPressed: () {
                      String temp = startLocation;
                      setState(() {
                        startLocation = goalLocation;
                        goalLocation = temp;
                      });
                      Logger().d(startLocation);
                      Logger().d(goalLocation);
                    },
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '전체',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStatePropertyAll(Colors.yellow),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0))))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '도보',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(color: Colors.grey))))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '지하철',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(color: Colors.grey))))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '버스 + 지하철',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        ),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(color: Colors.grey))))),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              startTime,
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
            )),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/direction');
          },
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(20.0),
            child: Column(children: [
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      padding: EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
                      decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        "최단 경로",
                        style: TextStyle(color: Colors.blue, fontSize: 12.0),
                      )),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 12.0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8.0),
                      child: Text(
                        "17분",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "700m",
                      style: TextStyle(fontSize: 16.0, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8.0),
                      child: Row(children: [
                        Icon(
                          Icons.wheelchair_pickup,
                          size: 16.0,
                        ),
                        Text('휠체어'),
                        Text(
                          "17분",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ]),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.pause_outlined,
                          size: 16.0,
                        ),
                        Text('목발'),
                        Text(
                          "30분",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.directions_walk,
                        size: 24.0,
                        color: Colors.grey[600],
                      ),
                      Text(
                        startLocation,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: 18.0),
                      )
                    ],
                  ),
                  Container(
                    height: 36.0,
                    padding: EdgeInsets.all(2.0),
                    alignment: Alignment.centerLeft,
                    child: VerticalDivider(
                      color: Colors.grey,
                      thickness: 1.2,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle_outlined,
                        size: 20.0,
                        color: Colors.red,
                      ),
                      Text(
                        goalLocation,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            fontSize: 18.0),
                      )
                    ],
                  ),
                ],
              )
            ]),
          ),
        )
      ]),
    );
  }
}
