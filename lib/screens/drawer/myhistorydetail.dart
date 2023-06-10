import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'myhistory.dart';

class MyHistoryDetailPage extends StatefulWidget {
  @override
  _MyHistoryDetailPageState createState() => _MyHistoryDetailPageState();
}

class _MyHistoryDetailPageState extends State<MyHistoryPage> {
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
    );
  }
}
