import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void navigateToSearchPage(BuildContext context, String searchItem) {
    String searchKey;
    double latitude;
    double longitude;
    String goalarea;

    if (searchItem == '냉정역') {
      latitude = 35.151169; // Set the actual latitude for '냉정역'
      longitude = 129.012124; // Set the actual longitude for '냉정역'
      goalarea = searchItem;
    } else if (searchItem == '서면시장') {
      latitude = 35.155819; // Set the actual latitude for '서면시장'
      longitude = 129.057768; // Set the actual longitude for '서면시장'
      goalarea = searchItem;
    } else {
      // Handle other search items or provide default coordinates
      latitude = 0.0;
      longitude = 0.0;
      goalarea = '';
    }

    final coordinates = {
      "latitude": latitude,
      "longitude": longitude,
      "goalarea": searchItem,
    };

    Navigator.pushNamed(context, '/searchresult', arguments: coordinates);
  }

<<<<<<< HEAD
  void keywordSearchResultPage(BuildContext context, String searchItem) {
    // 검색 결과 페이지로 전달할 데이터 처리
    final coordinates = {
      "searchItem" : searchItem,
    };

    Navigator.pushNamed(context, '/keywordsearch', arguments: coordinates);
  }


=======
  List<String> recommendList = [];
  List<String> mapoList = [
    "마포역 5호선",
    "마포역1번출구",
    "마포역3번출구",
    "마포역2번출구",
    "마포역4번출구",
    "마포역 알덴테",
    "마포역전떡볶이",
    "신라스테이 마포"
  ];
  String searchKey = "";
  List<String> searchHistory = ['냉정역', '서면시장'];
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
>>>>>>> 40efd664f65f6894d1a15be43d8d81df2e5ca5f2

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

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
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false, // Center-align the title
        title: TextField(
          textInputAction: TextInputAction.go,
          onChanged: (value) {
            setState(() {
              searchKey = value;
              if (searchKey == "마포역") {
                recommendList = mapoList;
              } else {
                recommendList = [];
              }
            });
          },
          onSubmitted: (value) {
            keywordSearchResultPage(context, value);
          },
          decoration: InputDecoration(
            hintText: '어디로 갈까요?',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 12.0),
          ),
        ),
        leading: IconButton(
          visualDensity:
              VisualDensity(horizontal: -4.0, vertical: -4.0), //이부분이 줄여주는 부분이다.
          padding: EdgeInsets.zero, // 여백 없
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.black, size: 16.0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300], // Border color
            height: 1.0, // Border height
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(0.0),
        child: Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 1.0,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < recommendList.length; i++)
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              navigateToSearchPage(context, recommendList[i]);
                              setState(() {
                                searchHistory.insert(0, recommendList[i]);
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  recommendList[i],
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward_ios_rounded,
                                      color: Colors.black, size: 18.0),
                                  onPressed: () {
                                    // Handle close button press action
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      Divider(
                        color: Colors.transparent, // Underline color
                        thickness: 1.0, // Underline thickness
                      ),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '최근 검색',
                      style: TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.bold),
                    )),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < searchHistory.length; i++)
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              navigateToSearchPage(context, searchHistory[i]);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  searchHistory[i],
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.close,
                                      color: Colors.black, size: 18.0),
                                  onPressed: () {
                                    setState(() {
                                      searchHistory.removeAt(i);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      Divider(
                        color: Colors.transparent, // Underline color
                        thickness: 1.0, // Underline thickness
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
