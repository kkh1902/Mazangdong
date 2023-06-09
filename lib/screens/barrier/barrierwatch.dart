import 'package:flutter/material.dart';
import 'package:dong/main.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class BarrierwatchPage extends StatefulWidget {
  @override
  _BarrierwatchPageState createState() => _BarrierwatchPageState();
}

class _BarrierwatchPageState extends State<BarrierwatchPage> {
  bool _isItem1Checked = false;
  bool _isItem2Checked = false;
  bool _isItem3Checked = false;
  bool _isItem4Checked = false;
  String _additionalExplanation = '';

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
              '조심해야 할 대상은 누구인가요?',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            CheckboxListTile(
              title: Text('Item 1'),
              value: _isItem1Checked,
              onChanged: (newValue) {
                setState(() {
                  _isItem1Checked = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Item 2'),
              value: _isItem2Checked,
              onChanged: (newValue) {
                setState(() {
                  _isItem2Checked = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Item 3'),
              value: _isItem3Checked,
              onChanged: (newValue) {
                setState(() {
                  _isItem3Checked = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text('Item 4'),
              value: _isItem4Checked,
              onChanged: (newValue) {
                setState(() {
                  _isItem4Checked = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            SizedBox(height: 20.0),
            Text('Additional Explanation:'),
            TextField(
              onChanged: (newValue) {
                setState(() {
                  _additionalExplanation = newValue;
                });
              },
              maxLines: null,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NaverMapScreen()),
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
