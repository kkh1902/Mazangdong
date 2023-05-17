import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Text(
              'Google Maps',
              style: TextStyle(color: Colors.black),
            ),
            Spacer(),
            Icon(Icons.map_outlined, color: Colors.grey),
            SizedBox(width: 10),
            Icon(Icons.menu, color: Colors.grey),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194),
                zoom: 11.0,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key('item $index'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    // Handle item dismissal
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Item $index dismissed')),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/trip.png'),
                    ),
                    title: Text('Item $index'),
                    subtitle: Text('Description $index'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Handle button tap
                      },
                      child: Text('Button'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
