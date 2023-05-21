// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//
// class MapsPage extends StatefulWidget {
//   @override
//   _MapsPageState createState() => _MapsPageState();
// }
//
// class _MapsPageState extends State<MapsPage> {
//   GoogleMapController? _mapController;
//   Set<Marker> _markers = {};
//   Set<Polyline> _polylines = {};
//   List<LatLng> _polylineCoordinates = [];
//   List<String> _instructions = [];
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       requestLocationPermission();
//     });
//   }
//
//   Future<void> requestLocationPermission() async {
//     final status = await Permission.location.request();
//     if (status.isGranted) {
//       getDirections();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.grey,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Row(
//           children: [
//             Text(
//               'Google Maps',
//               style: TextStyle(color: Colors.black),
//             ),
//             Spacer(),
//             Icon(Icons.map_outlined, color: Colors.grey),
//             SizedBox(width: 10),
//             Icon(Icons.menu, color: Colors.grey),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(37.5665,
//                     126.9780), // Set the target location to Seoul, South Korea
//                 zoom: 11.0,
//               ),
//               onMapCreated: (controller) {
//                 setState(() {
//                   _mapController = controller;
//                 });
//               },
//               markers: _markers,
//               polylines: _polylines,
//             ),
//           ),
//           SizedBox(height: 10),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _instructions.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: CircleAvatar(
//                     backgroundImage: AssetImage('assets/images/trip.png'),
//                   ),
//                   title: Text(_instructions[index]),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> getDirections() async {
//     try {
//       String apiKey =
//           'AIzaSyAD2Tf6yBI9jb2abxGVZGlMKmoqDglhYzs'; // Replace with your own API key
//       String url =
//           'https://maps.googleapis.com/maps/api/directions/json?origin=37.5665,126.9780&destination=37.5642,127.0017&key=$apiKey&mode=transit';
//
//       final response = await http.get(Uri.parse(url));
//
//       if (response.statusCode == 200) {
//         final decodedData = json.decode(response.body);
//         print('decode :$decodedData'); // Print the response data
//         List<dynamic> routes = decodedData['routes'];
//         if (routes.isNotEmpty) {
//           List<dynamic> legs = routes[0]['legs'];
//           if (legs.isNotEmpty) {
//             List<dynamic> steps = legs[0]['steps'];
//             _polylineCoordinates = _decodePolyline(steps);
//             _instructions = _getInstructions(steps);
//             drawRoute();
//             setMarkers();
//           }
//         }
//       } else {
//         print('Error: Request failed with status code ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//   List<LatLng> _decodePolyline(List<dynamic> steps) {
//     List<LatLng> result = [];
//     for (int i = 0; i < steps.length; i++) {
//       String polylinePoints = steps[i]['polyline']['points'];
//       List<LatLng> decodedPolyline = _decodeEncodedPolyline(polylinePoints);
//       result.addAll(decodedPolyline);
//     }
//     return result;
//   }
//
//   List<LatLng> _decodeEncodedPolyline(String encoded) {
//     List<LatLng> poly = [];
//     int index = 0, len = encoded.length;
//     int lat = 0, lng = 0;
//
//     while (index < len) {
//       int b, shift = 0, result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1F) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lat += dlat;
//
//       shift = 0;
//       result = 0;
//       do {
//         b = encoded.codeUnitAt(index++) - 63;
//         result |= (b & 0x1F) << shift;
//         shift += 5;
//       } while (b >= 0x20);
//       int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
//       lng += dlng;
//
//       LatLng position = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
//       poly.add(position);
//     }
//     return poly;
//   }
//
//   List<String> _getInstructions(List<dynamic> steps) {
//     List<String> instructions = [];
//     for (int i = 0; i < steps.length; i++) {
//       if (steps[i]['travel_mode'] == 'TRANSIT') {
//         String instruction = steps[i]['html_instructions'];
//         instructions.add(instruction);
//       }
//     }
//     return instructions;
//   }
//
//   void drawRoute() {
//     if (_mapController != null && _polylineCoordinates.length > 1) {
//       final polyline = Polyline(
//         polylineId: PolylineId('route'),
//         points: _polylineCoordinates,
//         color: Colors.white, // Set road color to white
//         width: 3,
//       );
//
//       final roadPolyline = Polyline(
//         polylineId: PolylineId('road'),
//         points: _polylineCoordinates,
//         color: Colors.blue, // Set the road color to white
//         width: 4,
//       );
//
//       setState(() {
//         _polylines.add(polyline);
//         _polylines.add(roadPolyline);
//       });
//     }
//   }
//
//   void setMarkers() {
//     if (_polylineCoordinates.isNotEmpty) {
//       final startMarker = Marker(
//         markerId: MarkerId('startMarker'),
//         position: _polylineCoordinates.first,
//         infoWindow: InfoWindow(title: 'Start'),
//       );
//       final endMarker = Marker(
//         markerId: MarkerId('endMarker'),
//         position: _polylineCoordinates.last,
//         infoWindow: InfoWindow(title: 'End'),
//       );
//       setState(() {
//         _markers.add(startMarker);
//         _markers.add(endMarker);
//       });
//     }
//   }
// }
