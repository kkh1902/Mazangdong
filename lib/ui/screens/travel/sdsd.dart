import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, xx',
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'There are various experiences and places waiting for you',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Tourist Attractions button press
                  },
                  child: Text('관광지'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle Accommodation button press
                  },
                  child: Text('숙소'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle View All button press
                  },
                  child: Text('전체보기'),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            Row(
              children: [
                TagItem(text: 'Tag 1'),
                TagItem(text: 'Tag 2'),
                TagItem(text: 'Tag 3'),
                TagItem(text: 'Tag 4'),
              ],
            ),
            SizedBox(height: 24.0),
            SlideItem(
              photoUrl: 'assets/images/3.jpg',
              title: 'Slide Title',
              subtitle: 'Random text',
            ),
            SizedBox(height: 24.0),
            Text(
              'Location',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

class TagItem extends StatelessWidget {
  final String text;

  const TagItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8.0),
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(text),
    );
  }
}

class SlideItem extends StatelessWidget {
  final String photoUrl;
  final String title;
  final String subtitle;

  const SlideItem({
    required this.photoUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(photoUrl),
        SizedBox(height: 8.0),
        Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(subtitle),
      ],
    );
  }
}
