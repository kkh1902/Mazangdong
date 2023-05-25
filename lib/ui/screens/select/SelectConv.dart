import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/ui/screens/select/SelectRegion.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import 'indicator.dart' as PageCount;

class SelectConvPage extends StatefulWidget {
  final ConvModel convModel;

  SelectConvPage({
    required this.convModel,
  });

  @override
  _SelectConvPageState createState() => _SelectConvPageState();
}

class _SelectConvPageState extends State<SelectConvPage> {
  List<bool> isItemSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  int counter = 1;

  void handleSelection(int index) {
    setState(() {
      isItemSelected[index] = !isItemSelected[index];
      widget.convModel.selectedOptions.clear();
      for (int i = 0; i < isItemSelected.length; i++) {
        if (isItemSelected[i]) {
          widget.convModel.selectedOptions.add(1);
        } else {
          widget.convModel.selectedOptions.add(0);
        }
      }
    });
  }

  void goToNextPage() {
    print("convenienceModel: ${widget.convModel}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectRegionPage(
          convModel: widget.convModel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
          padding: EdgeInsets.fromLTRB(5.0, 55.0, 5.0, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: 10),
                  Text(
                    '서비스 선택',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PretendardSemiBold',
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 30, // Set the desired height for the Container
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '필요한 서비스를 선택해주세요',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'PretendardSemiBold',
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 1.5,
                ),
                child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          buildInputRow('장애인 주차구역', 0, 'assets/images/convservice/parking.png'),
                          SizedBox(width: 10),
                          buildInputRow('안내견', 1,  'assets/images/convservice/dog.png'),
                        ]),
                        SizedBox(height: 10),
                        Row(children: [
                          buildInputRow('휠체어 대여', 2, 'assets/images/convservice/wheel.png'),
                          SizedBox(width: 10),
                          buildInputRow('관광 가이드', 3, 'assets/images/convservice/tourguide.png'),
                        ]),
                        SizedBox(height: 10),
                        Row(children: [
                          buildInputRow('엘리베이터', 4, 'assets/images/convservice/elevator.png'),
                          SizedBox(width: 10),
                          buildInputRow('수화 통역', 5,  'assets/images/convservice/hand.png'),
                        ]),
                        SizedBox(height: 10),
                        Row(children: [
                          buildInputRow('장애인 전용 화장실', 6,  'assets/images/convservice/wc.png'),
                          SizedBox(width: 10),
                          buildInputRow('청각 보조기', 7,  'assets/images/convservice/earplug.png'),
                        ]),
                        SizedBox(height: 10),
                        Row(children: [
                          buildInputRow('장애인 전용 객실', 8,  'assets/images/convservice/room.png'),
                          SizedBox(width: 10),
                          buildInputRow('점자 안내서', 9,  'assets/images/convservice/dots.png'),
                        ]),
                      ],
                    )),
              ),
              SizedBox(height: 10),
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 1.5,
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
                        Text(""),
                        Text(
                          '다음',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'PretendardSemiBold',
                              color: Colors.black),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ]),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PageViewDotIndicator(
                  currentItem: 3,
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
          )),
    );
  }

  Widget buildInputRow(String text, int index, String imagePath) {
    return Expanded(
      child: InkWell(
        onTap: () => handleSelection(index),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isItemSelected[index] ? Color(0xFF00adef) : Colors.grey[200]!,
              width: 2.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 40, // Set the desired width for the image
                height: 40, // Set the desired height for the image
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover, // Adjust the image's fit property as needed
                ),
              ),
              SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'PretendardSemiBold',
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}


