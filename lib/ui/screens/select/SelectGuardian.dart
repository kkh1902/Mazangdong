import 'package:flutter/material.dart';
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/ui/screens/select/SelectNickname.dart';
import 'package:mazangdong/ui/screens/select/SelectTransportation.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import 'indicator.dart' as PageCount;

class SelectGuardianPage extends StatefulWidget {
  final ConvModel convModel;

  SelectGuardianPage({
    required this.convModel,
  });

  @override
  _SelectGuardianPageState createState() => _SelectGuardianPageState();
}

class _SelectGuardianPageState extends State<SelectGuardianPage> {
  List<bool> isItemSelected = [false, false];
  List<String> selectedValues = ['0', '0']; // 초기 값 설정

  void handleSelection(int index) {
    setState(() {
      for (int i = 0; i < isItemSelected.length; i++) {
        if (i == index) {
          isItemSelected[i] = true; // Select the current index
          selectedValues[i] = '1'; // Update the selected value
        } else {
          isItemSelected[i] = false; // Deselect all other indexes
          selectedValues[i] = '0'; // Update the selected value
        }
      }
    });
  }

  void goToNextPage() {
    ConvModel convenienceModel = ConvModel(
      nickname: '',
      isTravelingAlone: isItemSelected[0] ? 1 : 0,
    );
    print(convenienceModel);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectTransportationPage(convModel: convenienceModel),
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
                  '보호자 동행 여부',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'PretendardSemiBold',
                      color: Colors.black),
                ),
              ],
            ),
            // SizedBox(height: 15),
            // Container(
            //     margin: EdgeInsets.symmetric(horizontal: 20),
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(10),
            //       child: LinearProgressIndicator(
            //         valueColor:
            //             AlwaysStoppedAnimation<Color>(Color(0xFF00adef)),
            //         backgroundColor: Colors.grey[200],
            //         value: 0.2,
            //         minHeight: 8.0,
            //       ),
            //     )),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: const [
            //     Text(
            //       '20%',
            //       style: TextStyle(
            //           fontSize: 15,
            //           fontFamily: 'PretendardSemiBold',
            //           color: Colors.black),
            //     ),
            //     Text(
            //       '의 진행률',
            //       style: TextStyle(
            //           fontSize: 15,
            //           fontFamily: 'PretendardSemiBold',
            //           color: Colors.grey),
            //     ),
            //   ],
            // ),
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '보호자와 함께 여행하시나요?',
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'PretendardSemiBold',
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 50),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 128,
                      width: 128,
                      child: Image.asset(
                          'assets/images/icons/guardian_together_logo.png'),
                    ),
                    SizedBox(
                      height: 128,
                      width: 128,
                      child:
                      Image.asset('assets/images/icons/guardian_alone_logo.png'),
                    )
                  ],
                )),
            SizedBox(height: 50),
            Column(
              children: [
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
                          Icon(Icons.person),
                          Text(
                            '혼자가요',
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
                    maxWidth: MediaQuery.of(context).size.width / 1.5,
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
                          Icon(Icons.people),
                          Text(
                            '함께가요',
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
                currentItem: 0,
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

// Widget buildInputRow(String text, int index) {
//   return Expanded(
//       child: InkWell(
//           onTap: () => handleSelection(index),
//           child: Container(
//             height: 120,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(
//                 color:
//                     isItemSelected[index] ? Colors.green : Colors.grey[200]!,
//                 width: 2.0,
//               ),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 10),
//                 Text(text,
//                     style: TextStyle(
//                         fontFamily: 'PretendardSemiBOld', fontSize: 18)),
//               ],
//             ),
//           )));
// }

// Widget buildInputRow(String image, String text, int index) {
//   return Expanded(
//     child: InkWell(
//       onTap: () => handleSelection(index),
//       child: Container(
//         height: 120,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: isItemSelected[index] ? Colors.green : Colors.grey[200]!,
//             width: 2.0,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: 10),
//             Image.asset(
//               image,
//               width: 50, // 이미지의 너비 설정
//               height: 50, // 이미지의 높이 설정
//             ),
//             SizedBox(height: 5),
//             Text(text,
//                 style: TextStyle(
//                     fontFamily: 'PretendardSemiBOld', fontSize: 18)),
//           ],
//         ),
//       ),
//     ),
//   );
// }
}
