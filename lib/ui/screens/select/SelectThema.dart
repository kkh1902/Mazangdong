import 'package:flutter/material.dart';
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/models/RegionModel.dart';
import 'package:mazangdong/models/ThemaModel.dart';
import 'package:mazangdong/ui/screens/select/SelectComplete.dart';

class SelectThemaPage extends StatefulWidget {
  final ConvModel convModel;
  final RegionModel regionModel;

  SelectThemaPage({
    required this.convModel,
    required this.regionModel,
  }) : themaModel = ThemaModel();

  final ThemaModel themaModel;

  @override
  _SelectThemaPageState createState() => _SelectThemaPageState();
}

class _SelectThemaPageState extends State<SelectThemaPage> {
  List<bool> isItemSelected = [false, false, false, false, false,false];
  int counter = 1;

  void handleSelection(int index) {
    setState(() {
      widget.themaModel.toggleCategory(index); // Toggle the category selection in the ThemaModel
      isItemSelected[index] = widget.themaModel.isCategorySelected(index);

      if (isItemSelected[index]) {
        // Add the category to the selectedCategories list
        if (!widget.themaModel.selectedCategories.contains(index)) {
          widget.themaModel.selectedCategories.add(index);
        }
      } else {
        // Remove the category from the selectedCategories list
        widget.themaModel.selectedCategories.remove(index);
      }
    });
  }


  void goToNextPage() {
    print("convenienceModel: ${widget.convModel}");
    print("themaModel: ${widget.themaModel}");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectCompletePage(
          convModel: widget.convModel,
          regionModel: widget.regionModel,
          themaModel: widget.themaModel,
        ),
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
                value: 0.8,
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
                        '테마 입력',
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
                        buildInputRow('assets/images/trip.png', '자연경관', 0),
                        SizedBox(width: 20),
                        buildInputRow('assets/images/trip.png', '트레킹', 1),
                        SizedBox(width: 10), // 오른쪽 여백
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        buildInputRow('assets/images/trip.png', '바닷가', 2),
                        SizedBox(width: 20),
                        buildInputRow('assets/images/trip.png', '동네구경', 3),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        buildInputRow('assets/images/trip.png', '문화예술', 4),
                        SizedBox(width: 20),
                        buildInputRow('assets/images/trip.png', '쇼핑', 5),
                        SizedBox(width: 10),
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
        padding: EdgeInsets.all(10),
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
                child: Text(
                  '이전',
                  style: TextStyle(fontSize: 20, fontFamily: 'PretendardBold'),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  goToNextPage();
                },
                // onPressed: goToNextPage,
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('다음',
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'PretendardBold')),
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