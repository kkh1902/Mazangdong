import 'dart:convert';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;

String GEOCODING_API_KEY1 = "sublv1reyj";
String GEOCODING_API_KEY2 = "NTPYfyaR24WYaFDibcGFOvo2DDv9neN6lJZ8mZRz";

Future<String> getAddressFromLatLng(LatLng latLng) async {
  print("주소 가져오기 시작");
  final String apiUrl =
      "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?request=coordsToaddr&coords=${latLng.longitude},${latLng.latitude}&orders=legalcode,addr,admcode&output=json";

  final response = await http.get(
    Uri.parse(apiUrl), // apiUrl 값을 Uri.parse()로 감싸지 말고 직접 전달하세요.
    headers: {
      'X-NCP-APIGW-API-KEY-ID': GEOCODING_API_KEY1,
      'X-NCP-APIGW-API-KEY': GEOCODING_API_KEY2, // 동일한 키를 사용하는 경우 추가하세요.
    },
  );


  if (response.statusCode == 200) {
    print(" 요청이 잘 갔음");
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    List<dynamic> results = jsonResponse["results"];
    print(results[0]["region"]["area1"]["name"]);
    String address = results[0]["region"]["area1"]["name"] +
        ' ' +
        results[0]["region"]["area2"]["name"] +
        ' ' +
        results[0]["region"]["area3"]["name"] ;



    return address;
  } else {
    throw Exception("Failed to get address from LatLng");
  }
}
