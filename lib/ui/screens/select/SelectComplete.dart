import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mazangdong/models/ConvModel.dart';
import 'package:mazangdong/models/RegionModel.dart';
import 'package:mazangdong/models/ThemaModel.dart';
import 'package:mazangdong/models/ResponseModel.dart';
import 'package:mazangdong/ui/screens/travel/TravelList.dart';
import 'dart:convert';

class SelectCompletePage extends StatefulWidget {
  final ConvModel convModel;
  final RegionModel regionModel;
  final ThemaModel themaModel;

  SelectCompletePage({
    required this.convModel,
    required this.regionModel,
    required this.themaModel,
  });

  @override
  _SelectCompletePageState createState() => _SelectCompletePageState();
}

class _SelectCompletePageState extends State<SelectCompletePage> {
  late ResponseModel responseModel;

  @override
  void initState() {
    super.initState();
    responseModel = ResponseModel(trip: [], lodging: []);
  }

  Future<void> _sendRequest() async {
    var url = 'https://majangdong.run.goorm.site/info';
    var data = {
      'together': '1',
      'parking': '1',
      'wheelchair': '1',
      'restroom': '1',
      'region': '8',
    };

    var uri = Uri.parse(url);
    var queryParameters = data.entries.map((e) => '${e.key}=${e.value}').join('&');
    var requestUrl = Uri.parse('$uri?$queryParameters');

    try {
      var response = await http.get(requestUrl);
      print("response$response");

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final responseModel = ResponseModel.fromJson(decodedData);

        for (var i = 0; i < responseModel.trip.length; i++) {
          final tripModel = responseModel.trip[i];
          final juso = tripModel.juso;
          print("vvvvvvvvv");
          print("placeNAME: $juso");
          final naverApiKey = 'sublv1reyj';
          final naverApiKeys = 'NTPYfyaR24WYaFDibcGFOvo2DDv9neN6lJZ8mZRz';
          final naverApiUrl = 'https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode';

          var naverResponse = await http.get(
            Uri.parse('$naverApiUrl?query=$juso'),
            headers: {
              'X-NCP-APIGW-API-KEY-ID': naverApiKey,
              'X-NCP-APIGW-API-KEY': naverApiKeys,
            },
          );
          print("sssssssssssssssssssssssssssssssssssssssssssssssssss");

          print(naverResponse.body);

          if (naverResponse.statusCode == 200) {
            final naverDecodedData = json.decode(naverResponse.body);
            final addresses = naverDecodedData['addresses'];
            if (addresses.isNotEmpty) {
              final firstAddress = addresses[0];
              final latitude = double.parse(firstAddress['y']);
              final longitude = double.parse(firstAddress['x']);

              final updatedTripModel = TripModel(
                gwangwangjibunho: tripModel.gwangwangjibunho,
                gwangwangjiyeon: tripModel.gwangwangjiyeon,
                bunryu: tripModel.bunryu,
                jiyangbunho: tripModel.jiyangbunho,
                juso: tripModel.juso,
                muneobunho: tripModel.muneobunho,
                juchayeobu: tripModel.juchayeobu,
                hwichesil: tripModel.hwichesil,
                hwajangsir: tripModel.hwajangsir,
                imagegyeongryo: tripModel.imagegyeongryo,
                latitude: latitude,
                longitude: longitude,
              );

              responseModel.trip[i] = updatedTripModel;

            }
          } else {
            print('Naver API request failed with status: ${naverResponse.statusCode}');
          }
        }

        setState(() {
          print('시발 ㅍㄹㄹㄹㄹㅍㄹㄹㄹㄹㅍㄹㄹㄹㄹㅍㄹㄹㄹㄹㅍㄹㄹㄹㄹㅍㄹㄹㄹㄹ$responseModel');
          responseModel.printData();
          this.responseModel = responseModel;
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }







  void goToNextPage(BuildContext context) {
    _sendRequest();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TravelListPage(responseModel: responseModel),
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
                value: 1.0,
                minHeight: 8.0,
              ),
            ),
            SizedBox(height: 20),
            Image.asset('assets/images/trip.png'),
            SizedBox(height: 20),
            Text(
              '완료되었습니다.',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff50bcdf),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  '이전',
                  style: TextStyle(fontSize: 20, fontFamily: 'PretendardBold'),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  goToNextPage(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffa3cc9b),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  '다음',
                  style: TextStyle(fontSize: 20, fontFamily: 'PretendardBold'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
