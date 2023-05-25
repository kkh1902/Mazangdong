import 'package:flutter/material.dart';
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/ui/screens/select/SelectBus.dart';
import 'package:mazangdong/ui/screens/select/SelectNickname.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import 'SelectConv.dart';
import 'indicator.dart' as PageCount;

class SelectTransportationPage extends StatefulWidget {
  final ConvModel convModel;

  SelectTransportationPage({
    required this.convModel,
  });

  @override
  _SelectTransportationPageState createState() =>
      _SelectTransportationPageState();
}

class _SelectTransportationPageState extends State<SelectTransportationPage> {
  List<bool> isItemSelected = [false, false, false, false, false, false];

  void handleSelection(int index) {
    setState(() {
      if (index == 1) {
        widget.convModel.isTransportation = 1;
      } else {
        widget.convModel.isTransportation = 0;
      }
    });
  }

  void goToNextPage() {
    print(widget.convModel);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectBusPage(convModel: widget.convModel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 25),
        child: Column(
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
                  '개인차량 이용여부',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'PretendardSemiBold',
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '개인차량을 이용하시나요?',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'PretendardSemiBold',
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset('assets/images/icons/privatecar.png'),
            ),
            SizedBox(height: 30),
            Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 1.3,
                    minHeight: MediaQuery.of(context).size.height / 10,
                  ),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        side: BorderSide(color: Color(0xFF00adef))),
                    onPressed: () {
                      handleSelection(0);
                      goToNextPage();
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Icon(Icons.directions_car),
                          Text(
                            '네, 이용합니다',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'PretendardSemiBold',
                                color: Colors.black),
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ]),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 1.3,
                    minHeight: MediaQuery.of(context).size.height / 10,
                  ),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        side: BorderSide(color: Color(0xFF00adef))),
                    onPressed: () {
                      handleSelection(1);
                      goToNextPage();
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          // 대중교통 아이콘
                          Icon(Icons.directions_transit),
                          Text(
                            '아니요, 이용하지 않습니다',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'PretendardSemiBold',
                                color: Colors.black),
                          ),
                          Icon(Icons.arrow_forward_ios),
                        ]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PageViewDotIndicator(
                currentItem: 2,
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
        ),
      ),
    );
  }
}
