import 'package:flutter/material.dart';
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/models/RegionModel.dart';
import 'package:mazangdong/ui/screens/select/SelectComplete.dart';
import 'package:mazangdong/ui/screens/select/SelectThema.dart';

class SelectRegionPage extends StatefulWidget {
  final ConvModel convModel;

  SelectRegionPage({
    required this.convModel,
  }) : regionModel = RegionModel();

  final RegionModel regionModel;

  @override
  _SelectRegionPageState createState() => _SelectRegionPageState();
}


class _SelectRegionPageState extends State<SelectRegionPage> {
  final RegionModel regionModel = RegionModel();
  List<bool> isItemSelected = [false, false, false, false, false, false,false, false];
  int? selectedRegionIndex; // Track the selected region index

  void handleSelection(int index) {
    setState(() {
      if (selectedRegionIndex == index) {
        selectedRegionIndex = null; // Deselect the region if it's already selected
      } else {
        selectedRegionIndex = index; // Select the region
      }
      widget.regionModel.selectedRegions.clear(); // Clear the previous selected region
      if (selectedRegionIndex != null) {
        widget.regionModel.selectedRegions.add(index); // Add the selected region
      }
    });
  }

  void goToNextPage() {
    print("regionModel: ${widget.regionModel}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectThemaPage(
          convModel: widget.convModel,
          regionModel: widget.regionModel,
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
                        '지역 입력',
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
                        buildInputRow('assets/images/trip.png', '서울특별시', 0),
                        SizedBox(width: 20),
                        buildInputRow('assets/images/trip.png', '부산광역시', 1),
                        SizedBox(width: 10), // 오른쪽 여백
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        buildInputRow('assets/images/trip.png', '인천광역시', 2),
                        SizedBox(width: 20),
                        buildInputRow('assets/images/trip.png', '대구광역시', 3),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        buildInputRow('assets/images/trip.png', '대전광역시', 4),
                        SizedBox(width: 20),
                        buildInputRow('assets/images/trip.png', '광주광역시', 5),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        buildInputRow('assets/images/trip.png', '울산광역시', 6),
                        SizedBox(width: 20),
                        buildInputRow('assets/images/trip.png', '세종시', 7),
                        SizedBox(width: 10),
                      ],
                    ),
                    SizedBox(height: 20),
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
                  Navigator.pop(context); // Handle previous button press
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
                  goToNextPage(); // Handle next button pressed
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

  Widget buildInputRow(String image, String text, int index) {
    final isSelected = selectedRegionIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => handleSelection(index),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? Colors.green : Colors.grey[200]!,
              width: 2.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Image.asset(
                image,
                width: 50,
                height: 50,
              ),
              SizedBox(height: 5),
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


