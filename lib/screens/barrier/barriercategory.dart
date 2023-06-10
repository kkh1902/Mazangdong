import 'package:flutter/material.dart';
import 'package:dong/screens/barrier/barrierwatch.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:dong/main.dart';
import 'package:dong/models/barrierdata.dart';
import 'package:http/http.dart' as http;


class BarriercategoryPage extends StatefulWidget {
  final BarrierData barrier;

  BarriercategoryPage({required this.barrier});

  @override
  _BarriercategoryPageState createState() => _BarriercategoryPageState();
}

class _BarriercategoryPageState extends State<BarriercategoryPage> {
  String? _selectedType;

  void _updateAndInsertBarrierData(BuildContext context) async {
    if (_selectedType != null) {
      // Update the 'barrier' object with the selected type.
      widget.barrier.type = _selectedType!;

      // // Convert the 'barrier' object to JSON.
      // final barrierJson = widget.barrier.toJson();

      final requestData = {
        'type': widget.barrier.type,
        'address': widget.barrier.address,
        'lat': widget.barrier.latitude.toString(),
        'log': widget.barrier.longitude.toString(),
        'pass': widget.barrier.bypass.toString(),
        'name': widget.barrier.nickname,
        'image': widget.barrier.photo,
        'address_detail': widget.barrier.detailedAddress,
      };

      try {
        // Send a POST request to the server with the 'barrier' JSON data.
        final response = await http.post(
          Uri.parse('https://majangdong.run.goorm.site'),
          body: requestData,
        );

        // Check the response status code.
        if (response.statusCode == 200) {
          // TODO: Handle the successful response from the server.
          // You can navigate to the next screen or perform any other actions.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NaverMapScreen()),
          );
        } else {
          // TODO: Handle the error response from the server.
          // Display an error message or perform any other error handling logic.
          print('Error: ${response.statusCode}');
        }
      } catch (error) {
        // TODO: Handle any exceptions that occur during the request.
        print('Error: $error');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    widget.barrier.printData();
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
            RadioListTile<String>(
              title: Text('횡단보도'),
              value: '횡단보도',
              groupValue: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('시설물'),
              value: '시설물',
              groupValue: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('차량진입구역'),
              value: '차량진입구역',
              groupValue: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('보행공간'),
              value: '보행공간',
              groupValue: _selectedType,
              onChanged: (value) {
                setState(() {
                  _selectedType = value;
                });
              },
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                _updateAndInsertBarrierData(context);
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
