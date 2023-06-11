import 'package:flutter/material.dart';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class DirectionPage extends StatefulWidget {
  @override
  _DirectionPageState createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage> {
  NaverMapController? _controller;
  String startLocation = "부산광역시 사상구 주례로 47";
  String goalLocation = "서면시장";
  String startTime = "오늘 11시 45분 출발";
  BottomDrawerController controller = BottomDrawerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true, // Center-align the title
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 80.0,
                child: Text(startLocation,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0)),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 0.0),
                  child:
                      Icon(Icons.arrow_right_alt_rounded, color: Colors.grey)),
              SizedBox(
                width: 80.0,
                child: Text(goalLocation,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.0)),
              ),
            ],
          ),
          leading: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.grey,
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
        body: Stack(
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Flexible(
                child: NaverMap(
                  onMapCreated: (controller) {
                    setState(() {
                      _controller = controller;
                    });
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      37.5665,
                      126.9780,
                    ),
                    zoom: 15.0,
                  ),
                ),
              )
            ]),
            buildBottomDrawer(context),
          ],
        ));
  }

  Widget buildBottomDrawer(BuildContext context) {
    return BottomDrawer(
      /// your customized drawer header.
      header: Container(
        margin: const EdgeInsets.all(11.0),
        width: 80.0,
        height: 6.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey[300],
        ),
      ),

      /// your customized drawer body.
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Container(
                            margin: EdgeInsets.only(right: 8.0),
                            child: Text(
                              "1시간 15분",
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "5.5km",
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.grey),
                          ),
                        ]),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/directionresult');
                            },
                            child: Text(
                              '길 안내 평가',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                            ),
                            style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all<Size>(Size.zero),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(6.0)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: BorderSide(
                                            color: Colors.black,
                                            width: 1.2))))),
                      ],
                    ),
                  ),
                  Container(
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
                              "1시간 59분",
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
                              "3시간 56분",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 4.0,
              color: Colors.grey[100],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
              child: Row(children: [
                Container(
                    width: 48.0,
                    margin: EdgeInsets.only(right: 16.0),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.circle,
                            color: Colors.blue,
                            size: 14.0,
                          ),
                        ),
                        Text(
                          '출발',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                Text(
                  startLocation,
                  style: TextStyle(color: Colors.grey[900], fontSize: 16.0),
                )
              ]),
            ),
            Divider(
              thickness: 1.0,
              color: Colors.grey[100],
            ),
            Container(
              margin: EdgeInsets.only(right: 16.0),
              padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
              child: Row(children: [
                Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                          width: 48.0,
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 4.0),
                          child: Icon(
                            Icons.directions_walk,
                            color: Colors.grey,
                            size: 24.0,
                          ),
                        ),
                      ],
                    )),
                Text(
                  startLocation,
                  style: TextStyle(color: Colors.grey[900], fontSize: 16.0),
                )
              ]),
            )
          ],
        ),
      ),

      headerHeight: 28.0,
      drawerHeight: 300.0,

      /// drawer background color.
      color: Colors.white,

      /// drawer controller.
      controller: controller,
    );
  }
}
