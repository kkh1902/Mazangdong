import 'package:flutter/material.dart';

import 'package:flutter_naver_map/flutter_naver_map.dart';

class MyHistoryPage extends StatefulWidget {
  @override
  _MyHistoryPageState createState() => _MyHistoryPageState();
}

class _MyHistoryPageState extends State<MyHistoryPage> {
  List<String> dropdownList = ['필터', '필터2', '필터3'];
  String selectedDropdwon = '필터';
  int numberOfReports = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent, // appbar 투명하게
          centerTitle: true,
          title: const Text(
            "나의 여정 기록",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey[300],
              height: 1.0,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "총 $numberOfReports건",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "2023년 05월 29일 ~ 2023년 05월 30일",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    DecoratedBox(
                      decoration: ShapeDecoration(
                        color: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: DropdownButton(
                          value: selectedDropdwon,
                          items: dropdownList.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                              ),
                            );
                          }).toList(),
                          onChanged: (dynamic value) {
                            setState(() {
                              selectedDropdwon = value;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            // 세로 스크롤 뷰
            Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                for (int i = 0; i < numberOfReports; i++)
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          width: double.infinity,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 28, bottom: 28, left: 20, right: 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                      "2023년 05월 30일 18:18 ~ 2023년 05월 30일 18:18",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal)),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      // Circle dot
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: Colors.yellow,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text("부산광역시 사상구 주례로 47 동서대학교",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      // Circle dot
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text("부산광역시 사상구 주례로 47 동서대학교",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ))),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHistoryDetailPage()),
                      );
                    },
                  )
              ]),
            ))
          ]),
        ));
  }
}

class MyHistoryDetailPage extends StatefulWidget {
  @override
  _MyHistoryDetailPageState createState() => _MyHistoryDetailPageState();
}

class _MyHistoryDetailPageState extends State<MyHistoryDetailPage> {
  NaverMapController? _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent, // appbar 투명하게
          centerTitle: true,
          title: const Text(
            "나의 여정 세부 정보",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey[300],
              height: 1.0,
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Text("여정 일정",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 24),
                    Text("2023년 05월 30일"),
                  ],
                ),
                Divider(color: Colors.grey[500], height: 48),
                const Row(
                  children: [
                    Text("여정 거리",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 24),
                    Text("0.00012" "km"),
                  ],
                ),
                Divider(color: Colors.grey[500], height: 48),
                const Row(
                  children: [
                    Text("여정 시간",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 24),
                    Text("1분"),
                  ],
                ),
                Divider(color: Colors.grey[500], height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("여정 경로",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 24),
                    SizedBox(
                      width: 250,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.yellow,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text("18:18",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 12),
                              const SizedBox(
                                width: 150,
                                child: Text(
                                  "부산광역시 사상구 주례로 47 동서대학교",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 310,
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text("18:18",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(width: 12),
                                const SizedBox(
                                  width: 150,
                                  child: Text(
                                    "부산광역시 사상구 주례로 47 동서대학교",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    )
                  ],
                ),
                Divider(color: Colors.grey[500], height: 24),
                Expanded(
                  child: Container(
                    child: NaverMap(
                      onMapCreated: (controller) {
                        setState(() {
                          _controller = controller;
                        });
                      },
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(
                          37.5665,
                          126.9780,
                        ),
                        zoom: 15.0,
                      ),
                      markers: [
                        Marker(
                            markerId: "marker1",
                            position: LatLng(37.5665, 126.9780)),
                        Marker(
                            markerId: "marker2",
                            position: LatLng(37.5565, 126.9780))
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
