import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> searchHistory = ['서면시장', '아트빌'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
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
          visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
          padding: EdgeInsets.zero,
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 16.0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children:  <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '최근 검색',
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchHistory.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        title: Text(
                          searchHistory[index],
                          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.close, color: Colors.black, size: 18.0),
                          onPressed: () {
                            setState(() {
                              searchHistory.removeAt(index);
                            });
                          },
                        ),
                      ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1.0,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
