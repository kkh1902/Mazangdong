import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class SearchPage extends StatelessWidget {
  List<String> searchHistory = ['서면시장', '아-트빌'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false, // Center-align the title
        title: TextField(
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
          visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0), //이부분이 줄여주는 부분이다.
          padding: EdgeInsets.zero, // 여백 없
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 16.0),
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
              child: 
                Text(
                  '최근 검색',
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                )
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < searchHistory.length; i++ )
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              searchHistory[i],
                              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.black, size: 18.0),
                              onPressed: () {
                              },
                            ),
                          ]
                        )
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
