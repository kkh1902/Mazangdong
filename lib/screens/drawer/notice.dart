import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  List<Map> noticeList = [
    {"title": "AOS v2.3.1 테스트", "date": "2022.12.27", "important": true},
    {"title": "테스트", "date": "2022.12.14", "important": true},
    {"title": "테스트 2", "date": "2022.12.12", "important": false}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, // appbar 투명하게
        centerTitle: true,
        title: const Text(
          "공지사항",
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
          children: [
            for (var i = 0; i < noticeList.length; i++)
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                noticeList[i]["title"],
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: noticeList[i]["important"]
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                noticeList[i]["date"],
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                    fontWeight: noticeList[i]["important"]
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            ],
                          ),
                          if (noticeList[i]["important"])
                            Wrap(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 5, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Text(
                                    "중요",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 216, 216, 216),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
