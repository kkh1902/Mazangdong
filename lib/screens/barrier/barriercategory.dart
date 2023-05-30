import 'package:flutter/material.dart';
import 'package:dong/screens/barrier/barrierwatch.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class BarriercategoryPage extends StatefulWidget {
  @override
  _BarriercategoryPageState createState() => _BarriercategoryPageState();
}

class _BarriercategoryPageState extends State<BarriercategoryPage> {
  bool _isCrosswalkChecked = false;
  bool _isFacilitiesChecked = false;
  bool _isVehicleEntrancesChecked = false;
  bool _isPedestrianSpacesChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          '배리어 제보',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '어떤 유형의 배리어 인가요?',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            CheckboxListTile(
              title: Text('횡단보도'),
              value: _isCrosswalkChecked,
              onChanged: (newValue) {
                setState(() {
                  _isCrosswalkChecked = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            Divider(),
            CheckboxListTile(
              title: Text('시설물'),
              value: _isFacilitiesChecked,
              onChanged: (newValue) {
                setState(() {
                  _isFacilitiesChecked = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            Divider(),
            CheckboxListTile(
              title: Text('차량진입구역'),
              value: _isVehicleEntrancesChecked,
              onChanged: (newValue) {
                setState(() {
                  _isVehicleEntrancesChecked = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            Divider(),
            CheckboxListTile(
              title: Text('보행공간'),
              value: _isPedestrianSpacesChecked,
              onChanged: (newValue) {
                setState(() {
                  _isPedestrianSpacesChecked = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BarrierwatchPage()),
                );
                // Code for the next button
              },
              child: Text(
                '다음',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                minimumSize: Size(double.infinity, 50.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
