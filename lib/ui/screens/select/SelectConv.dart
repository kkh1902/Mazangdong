import 'package:flutter/material.dart';
import 'package:mazangdong/models/TravelModel.dart';
import 'package:mazangdong/ui/screens/select/SelectRegion.dart';

class SelectConvPage extends StatefulWidget {
  final TravelPlanModel travelPlan;

  SelectConvPage({required this.travelPlan});

  @override
  _SelectConvPageState createState() => _SelectConvPageState();
}


class _SelectConvPageState extends State<SelectConvPage>{
  late TravelPlanModel travelPlan;

  bool parkingSelected = false;
  bool wheelchairRentalSelected = false;
  bool accessibleRestroomSelected = false;
  bool unauthorizedParkingSelected = false;
  bool elevatorSelected = false;
  IconData? selectedIcon;

  @override
  void initState() {
    super.initState();
    travelPlan = widget.travelPlan;
  }

  void goToNextPage() {
    travelPlan.parkingSelected = parkingSelected;
    travelPlan.wheelchairRentalSelected = wheelchairRentalSelected;
    travelPlan.accessibleRestroomSelected = accessibleRestroomSelected;
    travelPlan.unauthorizedParkingSelected = unauthorizedParkingSelected;
    travelPlan.elevatorSelected = elevatorSelected;

    print("travelPlan: $travelPlan");
    // Navigate to the next page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectRegionPage(travelPlan: widget.travelPlan),
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          parkingSelected = !parkingSelected;
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: parkingSelected ? Colors.red : Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: Icon(
                          Icons.local_parking,
                          color: parkingSelected ? Colors.red : Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text('장애인 주차장'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.safety_check),
                      color: wheelchairRentalSelected ? Colors.red : Colors.black,
                      onPressed: () {
                        setState(() {
                          wheelchairRentalSelected = !wheelchairRentalSelected;
                        });
                      },
                    ),
                    SizedBox(height: 5),
                    Text('휠체어 대여'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.wc),
                      color: accessibleRestroomSelected ? Colors.red : Colors.black,
                      onPressed: () {
                        setState(() {
                          accessibleRestroomSelected = !accessibleRestroomSelected;
                        });
                      },
                    ),
                    SizedBox(height: 5),
                    Text('장애인 전용 화장실'),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.safety_check),
                      color: unauthorizedParkingSelected ? Colors.red : Colors.black,
                      onPressed: () {
                        setState(() {
                          unauthorizedParkingSelected = !unauthorizedParkingSelected;
                        });
                      },
                    ),
                    SizedBox(height: 5),
                    Text('무단차/경사로'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.elevator),
                      color: elevatorSelected ? Colors.red : Colors.black,
                      onPressed: () {
                        setState(() {
                          elevatorSelected = !elevatorSelected;
                        });
                      },
                    ),
                    SizedBox(height: 5),
                    Text('엘리베이터'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
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
                    style: TextStyle(fontSize:20, fontFamily: 'PretendardBold')),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectRegionPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('다음',
                style: TextStyle(fontSize:20, fontFamily: 'PretendardBold')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
