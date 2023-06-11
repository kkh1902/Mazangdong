import 'package:flutter/material.dart';
// import 'package:dong/screens/barrier/barrierpicture.dart';
// import 'package:flutter_naver_map/flutter_naver_map.dart';

class SearchResultPage extends StatefulWidget {
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {
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
          height: 200.0,
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          // child: Text('asdadsasdadadaadadsadas'),
          child: const Row(
            children: [
              Column(
                children: <Widget>[
                  Flexible(
                      child: TextField(
                    decoration: InputDecoration(
                        hintText: 'ㅁㅁㅁㅁㅁㅁ',
                        filled: true,
                        fillColor: Colors.grey,
                        contentPadding: const EdgeInsets.all(16.0)),
                  )),
                  Text('12312313')
                ],
              )
              // Column(
              //   children: [
              //     TextField(
              //       decoration: InputDecoration(
              //           hintText: 'ㅁㅁㅁㅁㅁㅁ',
              //           filled: true,
              //           fillColor: Colors.grey[100],
              //           contentPadding: const EdgeInsets.all(16.0)),
              //     )
              //   ],
              // ),
              // IconButton(
              //   icon: const Icon(Icons.swap_vert, color: Colors.black),
              //   onPressed: () {},
              // )
            ],
          ),
        ),
        SizedBox(
          height: 200,
        )
      ]),
    );
  }
}

// constraints: BoxConstraints(
                  //     maxHeight: 100.0, maxWidth: double.infinity),
                  // width: double.infinity,
                  // height: 40.0,
                  // color: Colors.white,
                  // padding: const EdgeInsets.all(16.0),
                  // child: Row(children: [
                  //   Column(children: [
                  //     TextField(
                  //       decoration: InputDecoration(
                  //         hintText: '어디로 갈까요?',
                  //         filled: true,
                  //         fillColor: Colors.grey[100],
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10.0),
                  //           borderSide: BorderSide.none,
                  //         ),
                  //         contentPadding:
                  //             const EdgeInsets.symmetric(vertical: 12.0),
                  //       ),
                  //     ),
                  //     TextField(
                  //       decoration: InputDecoration(
                  //         hintText: '어디로 갈까요?',
                  //         filled: true,
                  //         fillColor: Colors.grey[100],
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10.0),
                  //           borderSide: BorderSide.none,
                  //         ),
                  //         contentPadding:
                  //             const EdgeInsets.symmetric(vertical: 12.0),
                  //       ),
                  //     )
                  //   ]),
                  //   IconButton(
                  //     icon: const Icon(Icons.close,
                  //         color: Colors.black, size: 18.0),
                  //     onPressed: () {},
                  //   ),
                  // ])