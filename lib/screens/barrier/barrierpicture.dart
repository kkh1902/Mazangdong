import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:dong/screens/barrier/barriercategory.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dong/models/barrierdata.dart';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class BarrierpicturePage extends StatefulWidget {
  final BarrierData barrier;

  BarrierpicturePage({required this.barrier});

  @override
  _BarrierpicturePageState createState() => _BarrierpicturePageState();
}

class _BarrierpicturePageState extends State<BarrierpicturePage> {
  File? _image;
  List<File> _imageList = [];

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _imageList.add(_image!);
      });
    }
  }

  // Future<String> _encodeImage(File image) async {
  //   final bytes = await image.readAsBytes();
  //   return base64Encode(bytes);
  // }

  Future<String> _encodeImage(File image) async {
    // final compressedImage = await FlutterImageCompress.compressWithFile(
    //   image.path,
    //   quality: 50,
    // );

    // final encodedImage = base64Encode(compressedImage!); // Add the null-aware operator here
    // return encodedImage;


    final bytes = await image.readAsBytes();
    return base64Encode(bytes);
  }




  Future<void> _updateModelAndNavigateNext() async {
    if (_imageList.isNotEmpty) {
      final encodedImages = await Future.wait(_imageList.map((image) => _encodeImage(image)));
      final encodedPhoto = encodedImages.join(',');

      final updatedBarrier = BarrierData(
        type: widget.barrier.type,
        address: widget.barrier.address,
        latitude: widget.barrier.latitude,
        longitude: widget.barrier.longitude,
        bypass: widget.barrier.bypass,
        nickname: widget.barrier.nickname,
        photo: encodedPhoto,
        detailedAddress: widget.barrier.detailedAddress,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BarriercategoryPage(barrier: updatedBarrier),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Barrier Address: ${widget.barrier}');
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
            if (_imageList.isNotEmpty)
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _imageList
                      .map(
                        (image) => SizedBox(
                      width: 200.0, // Set the desired width of the image
                      child: Image.file(image),
                    ),
                  )
                      .toList(),
                ),
              ),
            SizedBox(height: 16.0),
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
            Spacer(),
            ElevatedButton(
              onPressed: _updateModelAndNavigateNext,
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
