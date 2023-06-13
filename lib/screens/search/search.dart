import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class SearchPage extends StatelessWidget {
  List<String> searchHistory = ['냉정역' , '서면시장' ];

  void navigateToSearchResultPage(BuildContext context, String searchItem) {
    double latitude;
    double longitude;
    String goalarea;

    if (searchItem == '냉정역') {
      latitude = 35.151169;  // Set the actual latitude for '냉정역'
      longitude = 129.012124;  // Set the actual longitude for '냉정역'
      goalarea = searchItem;
    } else if (searchItem == '서면시장') {
      latitude = 35.155819;  // Set the actual latitude for '서면시장'
      longitude = 129.057768;  // Set the actual longitude for '서면시장'
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

  void keywordSearchResultPage(BuildContext context, String searchItem) {
    // 검색 결과 페이지로 전달할 데이터 처리
    final coordinates = {
      "searchItem" : searchItem,
    };

    Navigator.pushNamed(context, '/keywordsearch', arguments: coordinates);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false, // Center-align the title
        title: TextField(
          textInputAction: TextInputAction.go,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '최근 검색',
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
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
                          navigateToSearchResultPage(context, searchHistory[i]);
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
                              icon: Icon(Icons.close, color: Colors.black, size: 18.0),
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
          ],
        ),
      ),
    );
  }
}
