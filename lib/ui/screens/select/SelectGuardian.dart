import 'package:flutter/material.dart';
import 'package:mazangdong/models/TravelModel.dart';
import 'package:mazangdong/ui/screens/select/SelectNickname.dart';




class SelectGuardianPage extends StatefulWidget {
  @override
  _SelectGuardianPageState createState() => _SelectGuardianPageState();
}

class _SelectGuardianPageState extends State<SelectGuardianPage> {
  bool isAlone = true; // 혼자 여행 여부 변수
  bool isWithGuardian = false; // 보호자 동행 여부 변수
  late TravelPlanModel travelPlan; // Declare travelPlan variable

  void goToNextPage() {
    travelPlan = TravelPlanModel(
      isTravelingAlone: isAlone,
      // Add necessary variables here
    );

    print("travelPlan: $travelPlan");


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectNicknamePage(travelPlan: travelPlan),
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
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '동행여부',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  backgroundColor: Colors.grey,
                    fontFamily: 'PretendardBold'
                ),
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '보호자와 동행하시나요?',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                      fontFamily: 'PretendardLight'
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAlone = true;
                      isWithGuardian = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isAlone ? Colors.grey[200] : Colors.transparent,
                      border: isAlone ? Border.all(color: Colors.red, width: 1) : null,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '혼자 여행',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                              fontFamily: 'PretendardBold'
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAlone = false;
                      isWithGuardian = true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isWithGuardian ? Colors.grey[200] : Colors.transparent,
                      border: isWithGuardian ? Border.all(color: Colors.red, width: 1) : null,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 40,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '보호자 동행',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                              fontFamily: 'PretendardBold'
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),


            SizedBox(height: 200),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '보호자 동행 없이 여행하는 경우 시설 방문에 어려움이 있는 곳은 빼드릴게요',
                style: TextStyle(fontSize: 16),
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
}