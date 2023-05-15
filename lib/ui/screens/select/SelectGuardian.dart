import 'package:flutter/material.dart';
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/ui/screens/select/SelectNickname.dart';


class SelectGuardianPage extends StatefulWidget {
  @override
  _SelectGuardianPageState createState() => _SelectGuardianPageState();
}

class _SelectGuardianPageState extends State<SelectGuardianPage> {
  List<bool> isItemSelected = [false, false, false, false, false, false];
  List<String> selectedValues = ['', '', '', '', '', ''];

  void handleSelection(int index) {
    setState(() {
      for (int i = 0; i < isItemSelected.length; i++) {
        if (i == index) {
          isItemSelected[i] = true; // Select the current index
          selectedValues[i] = 'Selected'; // Update the selected value
        } else {
          isItemSelected[i] = false; // Deselect other indices
          selectedValues[i] = ''; // Clear the selected value
        }
      }
    });
  }



  void goToNextPage() {
    ConvModel convenienceModel = ConvModel(
      nickname: '',
      isTravelingAlone: isItemSelected[0],
      parkingSelected: isItemSelected[1],
      wheelchairRentalSelected: isItemSelected[2],
      accessibleRestroomSelected: isItemSelected[3],
      unauthorizedParkingSelected: isItemSelected[4],
      elevatorSelected: isItemSelected[5],
    );
    print(convenienceModel);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectNicknamePage(convModel:convenienceModel),
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
                  value: 0.2,
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
                            '동행 여부',
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
                            buildInputRow('assets/images/trip.png', '혼자여행', 0),
                            SizedBox(width: 20),
                            buildInputRow(
                                'assets/images/trip.png', '보호자 동행 여행', 1),
                            SizedBox(width: 10), // 오른쪽 여백
                          ],
                        ),
                      ],
                    ),
                  )
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '보호자 동행 없이 여행하는 경우 시설 방문에 어려움이 있는 곳은 빼드릴게요',
                  style: TextStyle(fontSize: 18
                      , fontFamily: 'pretendardSemiBold'),
                  textAlign: TextAlign.center,
                ),
              ), // Empty container to fill the spaces
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                goToNextPage();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                '다음',
                style: TextStyle(fontSize: 20,
                    fontFamily: 'PretendardBold'),
              ),
            ),
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

