import 'package:flutter/material.dart';
import 'package:mazangdong/ui/screens/select/SelectComplete.dart';

class SelectRegionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: 0.75, // 4/3 progress bar
              minHeight: 10,
            ),
            SizedBox(height: 10),
            Column(
              children: [
                buildInputRow(Icons.place, '부산시', Icons.place, '부산시'),
                SizedBox(height: 10),
                buildInputRow(Icons.place, '부산시', Icons.place, '부산시'),
                SizedBox(height: 10),
                buildInputRow(Icons.place, '부산시', Icons.place, '부산시'),
                SizedBox(height: 10),
                buildInputRow(Icons.place, '부산시', Icons.place, '부산시'),
                SizedBox(height: 10),
                buildInputRow(Icons.place, '부산시', Icons.place, '부산시'),
              ],
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
                child: Text('이전'),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => SelectCompletePage()),
                  // ); // Handle next button pressed
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('다음'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputRow(IconData icon1, String text1, IconData icon2, String text2) {
    return Row(
      children: [
        Icon(icon1),
        SizedBox(width: 10),
        Text(text1),
        Spacer(),
        Icon(icon2),
        SizedBox(width: 10),
        Text(text2),
      ],
    );
  }
}
