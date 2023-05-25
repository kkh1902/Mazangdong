import 'package:flutter/material.dart';
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/models/RegionModel.dart';

import 'package:mazangdong/ui/screens/select/SelectConv.dart';
import 'package:mazangdong/ui/screens/select/SelectGuardian.dart';
import 'package:mazangdong/ui/screens/select/SelectTransportation.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import 'indicator.dart' as PageCount;

class SelectNicknamePage extends StatefulWidget {
  @override
  _SelectNicknamePageState createState() => _SelectNicknamePageState();
}

class _SelectNicknamePageState extends State<SelectNicknamePage> {
  String nickname = '';
  ConvModel convModel = ConvModel();

  void goToNextPage() {
    convModel.nickname = nickname; // Update the nickname property

    // Navigate to the next page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectGuardianPage(
          convModel: convModel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(height: 120),
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 10),
                    Text(
                      '닉네임 설정',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'PretendardSemiBold',
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '닉네임을 입력해주세요.',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'PretendardSemiBold',
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.2,
                  width: constraints.maxHeight * 0.2,
                  child: Image.asset('assets/images/icons/wheelpy.png'),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          nickname = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: '닉네임',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth / 1.5,
                    minHeight: constraints.maxHeight / 10,
                    maxHeight: constraints.maxHeight / 10,
                  ),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide(color: Color(0xFF00adef)),
                    ),
                    onPressed: () {
                      goToNextPage();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(""),
                        Text(
                          "다음",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: PageViewDotIndicator(
                    currentItem: 1,
                    count: PageCount.PageCount().count,
                    unselectedColor: Colors.black26,
                    selectedColor: Colors.blue,
                    size: const Size(18.0, 9.0),
                    unselectedSize: const Size(8, 8),
                    duration: Duration(milliseconds: 200),
                    boxShape: BoxShape.circle,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
