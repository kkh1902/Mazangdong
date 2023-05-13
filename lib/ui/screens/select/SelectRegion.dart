import 'package:flutter/material.dart';
import 'package:mazangdong/ui/screens/select/SelectComplete.dart';

class SelectRegionPage extends StatefulWidget {
  @override
  _SelectRegionPageState createState() => _SelectRegionPageState();
}


class _SelectRegionPageState extends State<SelectRegionPage> {
  late TravelPlanModel travelPlan;

  @override
  void initState() {
    super.initState();
    // Call a function to fetch Conv information when the page is initialized
    fetchConvInfo();
  }

  // Function to fetch Conv information
  void fetchConvInfo() {
    // Add your code here to fetch the Conv information
    // For example, you can make an API request or retrieve it from a database
    // Once you have the information, update the 'convInfo' variable and call setState() to update the UI
    convInfo = 'Conv Information'; // Replace this with your actual code
    setState(() {});
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
              margin: EdgeInsets.symmetric(horizontal: 20), // Added margin to the progress bar
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                backgroundColor: Colors.grey[200],
                value: 0.8,
                minHeight: 8.0,
              ),
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
                    MaterialPageRoute(builder: (context) => SelectCompletePage()),
                  ); // Handle next button pressed
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
