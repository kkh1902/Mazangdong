import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:dong/screens/barrier/barriercategory.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class BarrierpicturePage extends StatefulWidget {
  @override
  _BarrierpicturePageState createState() => _BarrierpicturePageState();
}

class _BarrierpicturePageState extends State<BarrierpicturePage> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

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
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '베리어의 사진을 등록해주세요',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.add),
              label: Text(
                '사진 등록',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                minimumSize: Size(double.infinity, 50.0),
              ),
            ),
            SizedBox(height: 16.0),
            if (_image != null) Image.file(_image!),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BarriercategoryPage()),
                );
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
