import 'package:flutter/material.dart';
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/models/RegionModel.dart';
import 'package:mazangdong/models/ThemaModel.dart';
import 'package:mazangdong/ui/screens/select/SelectRegion.dart';

class SelectConvPage extends StatefulWidget {
  final ConvModel convModel;

  SelectConvPage({
    required this.convModel,
  });

  @override
  _SelectConvPageState createState() => _SelectConvPageState();
}


class _SelectConvPageState extends State<SelectConvPage> {
  List<bool> isItemSelected = [false, false, false, false, false];
  List<String> selectedValues = ['', '', '', '', ''];


  void handleSelection(int index) {
    setState(() {
      isItemSelected[index] = !isItemSelected[index];
    });
  }

  void goToNextPage() {
    widget.convModel.parkingSelected = isItemSelected[0];
    widget.convModel.wheelchairRentalSelected = isItemSelected[1];
    widget.convModel.accessibleRestroomSelected = isItemSelected[2];
    widget.convModel.unauthorizedParkingSelected = isItemSelected[3];
    widget.convModel.elevatorSelected = isItemSelected[4];


    print("convenienceModel: ${widget.convModel}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectRegionPage(
          convModel: widget.convModel),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
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
                value: 0.6,
                minHeight: 8.0,
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        '편의시설 입력',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          backgroundColor: Colors.grey,
                          fontFamily: 'PretendardBold',
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        SizedBox(width: 10), // 왼쪽 여백
                        buildInputRow('assets/images/trip.png', '장애인 주차장', 0),
                        SizedBox(width: 20),
                        buildInputRow('assets/images/trip.png', '휠체어 대어', 1),
                        SizedBox(width: 10), // 오른쪽 여백
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        buildInputRow('assets/images/trip.png', '장애인 전용 화장실', 2),
                        SizedBox(width: 20),
                        buildInputRow('assets/images/trip.png', '무단차/경사로', 3),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        buildInputRow('assets/images/trip.png', '엘리베이터', 4),
                        SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('이전',
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'PretendardBold')),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  goToNextPage();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('다음',
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'PretendardBold')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputRow(String image, String text, int index) {
    return Expanded(
      child: InkWell(
        onTap: () => handleSelection(index),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isItemSelected[index] ? Colors.green : Colors.grey[200]!,
              width: 2.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Image.asset(
                image,
                width: 50, // 이미지의 너비 설정
                height: 50, // 이미지의 높이 설정
              ),
              SizedBox(height: 5),
              Text(text,
                  style: TextStyle(
                      fontFamily: 'PretendardSemiBOld', fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}


