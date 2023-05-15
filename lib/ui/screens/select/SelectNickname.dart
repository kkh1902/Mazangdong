import 'package:flutter/material.dart';
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/models/RegionModel.dart';

import 'package:mazangdong/ui/screens/select/SelectConv.dart';


class SelectNicknamePage extends StatefulWidget {
  final ConvModel convModel;

  SelectNicknamePage({required this.convModel});

  @override
  _SelectNicknamePageState createState() => _SelectNicknamePageState();
}

class _SelectNicknamePageState extends State<SelectNicknamePage> {
  String nickname = '';



  void goToNextPage() {
    widget.convModel.nickname = nickname; // Update the nickname property

    print("convenienceModel nickname: ${widget.convModel.nickname}");
    print("convenienceModel isTravelingAlone: ${widget.convModel.isTravelingAlone}");
    print("convenienceModel: ${widget.convModel}");

    // Navigate to the next page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectConvPage(
          convModel : widget.convModel,
        ),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                backgroundColor: Colors.grey[200],
                value: 0.4,
                minHeight: 8.0,
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: SingleChildScrollView( // Add SingleChildScrollView for scrolling
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '닉네임 입력',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          backgroundColor: Colors.grey,
                          fontFamily: 'PretendardBold',
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '닉네임을 입력하세요',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: 'PretendardLight',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
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
                        ),
                      ),
                    ),
                    SizedBox(height: 200),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton(
            onPressed: goToNextPage,
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: Text(
              '다음',
              style: TextStyle(fontSize: 20, fontFamily: 'PretendardBold'),
            ),
          ),
        ),
      ),
    );
  }
}

