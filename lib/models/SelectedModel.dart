import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectedModel extends ChangeNotifier {
  List<int> selectedList = [];

  void addItem(int item) {
    if (!selectedList.contains(item)) {
      selectedList.add(item);
      notifyListeners();
    }
  }

  void removeItem(int item) {
    selectedList.remove(item);
    notifyListeners();
  }

  void clearList() {
    selectedList.clear();
    notifyListeners();
  }

  Future<List<Map<String, dynamic>>> fetchDataFromDatabase() async {
    final List<Map<String, dynamic>> attractionsList = [];

    try {
      for (final item in selectedList) {
        final url = 'https://majangdong.run.goorm.site/detail/$item';
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final address = data[0]['주소'] as String;
          final gwangjiName = data[0]['관광지이름'] as String;
          final juso = data[0]['주소'] as String;
          final coordinates = await _getCoordinates(address);
          if (coordinates != null) {
            final attractionData = {
              'name': gwangjiName,
              'coordinates': coordinates,
              'juso': juso,
            };
            attractionsList.add(attractionData);
          }
        } else {
          print('Failed to fetch data for item $item. Error: ${response.statusCode}');
        }
      }
    } catch (error) {
      print('An error occurred while fetching data from the database: $error');
    }

    return attractionsList;
  }

  Future<LatLng> _getCoordinates(String address) async {
    try {
      final apiKey = 'AIzaSyAD2Tf6yBI9jb2abxGVZGlMKmoqDglhYzs'; // Replace with your Google Maps API key
      final encodedAddress = Uri.encodeComponent(address);
      final url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List<dynamic>;
        if (results.isNotEmpty) {
          final location = results[0]['geometry']['location'];
          final lat = location['lat'] as double;
          final lng = location['lng'] as double;
          return LatLng(lat, lng);
        }
      }
    } catch (error) {
      print('An error occurred while fetching coordinates from the Google Maps API: $error');
    }
    return LatLng(0, 0);
  }
}
