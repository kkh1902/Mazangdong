import 'package:flutter/material.dart';
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/models/RegionModel.dart';
import 'package:mazangdong/ui/screens/select/SelectComplete.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import 'indicator.dart' as PageCount;

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
  List<bool> isItemSelected = [
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
  int? selectedRegionIndex; // Track the selected region index

  void handleSelection(int index) {
    setState(() {
      isItemSelected[index] = !isItemSelected[index];
      widget.convModel.selectedRegions.clear();
      for (int i = 0; i < isItemSelected.length; i++) {
        if (isItemSelected[i]) {
          widget.convModel.selectedRegions.add(1);
        } else {
          widget.convModel.selectedRegions.add(0);
        }
      }
    });
  }

  // void handleSelection(int index) {
  //   setState(() {
  //     if (selectedRegionIndex == index) {
  //       selectedRegionIndex =
  //           null; // Deselect the region if it's already selected
  //     } else {
  //       selectedRegionIndex = index; // Select the region
  //     }
  //     widget.regionModel.selectedRegions
  //         .clear(); // Clear the previous selected region
  //     if (selectedRegionIndex != null) {
  //       widget.regionModel.selectedRegions
  //           .add(index); // Add the selected region
  //     }
  //   });
  // }

  void goToNextPage() {
    print("regionModel: ${widget.convModel}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectCompletePage(
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
                    '여행지 선택',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'PretendardSemiBold',
                        color: Colors.black),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  '여행지를 선택해주세요',
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'PretendardSemiBold',
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 1.5,
                ),
                child: Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              buildInputRow('서울특별시', 0, 'assets/images/region/seoul.png'),
                              SizedBox(width: 10),
                              buildInputRow('부산광역시', 1, 'assets/images/region/busan.png'),
                            ]),
                            SizedBox(height: 10),
                            Row(children: [
                              buildInputRow('인천광역시', 2, 'assets/images/region/incheon.png'),
                              SizedBox(width: 10),
                              buildInputRow('대구광역시', 3, 'assets/images/region/daegu.png'),
                            ]),
                            SizedBox(height: 10),
                            Row(children: [
                              buildInputRow('대전광역시', 4, 'assets/images/region/daejeon.png'),
                              SizedBox(width: 10),
                              buildInputRow('광주광역시', 5, 'assets/images/region/gwangju.png'),
                            ]),
                            SizedBox(height: 10),
                            Row(children: [
                              buildInputRow('울산광역시', 6, 'assets/images/region/ulsan.png'),
                              SizedBox(width: 10),
                              buildInputRow('세종특별자치시', 7, 'assets/images/region/sejong.png'),
                            ]),
                            SizedBox(height: 10),
                            Row(children: [
                              buildInputRow('제주특별자치도', 8, 'assets/images/region/jeju.png'),
                              SizedBox(width: 10),
                              Text("")
                            ]),
                          ],
                        ))),
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
                  currentItem: 4,
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

