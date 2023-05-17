import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps2Page extends StatefulWidget {
  @override
  _Maps2PageState createState() => _Maps2PageState();
}

class _Maps2PageState extends State<Maps2Page> {
  List<String> itemList = List.generate(10, (index) => 'Item ${index + 1}');
  bool isEditing = false; // 편집 모드 여부를 나타내는 변수
  List<bool> isItemDeletedList =
      List.generate(10, (index) => false); // 각 아이템의 삭제 여부를 나타내는 변수

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
          Container(
            width: double.infinity,
            height: 300,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194),
                zoom: 11.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '임의의 텍스트',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                  child: Text(isEditing ? '완료' : '편집'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 16.0),
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return isItemDeletedList[index]
                    ? SizedBox.shrink()
                    : Dismissible(
                        key: Key('$index'),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            itemList.removeAt(index);
                            isItemDeletedList.removeAt(index);
                          });
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 16.0,
                            backgroundColor: Colors.blue,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                          title: isEditing
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Edit item',
                                        ),
                                        onChanged: (value) {
                                          setState(() {
                                            itemList[index] = value;
                                          });
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        setState(() {
                                          isItemDeletedList[index] = true;
                                        });
                                      },
                                    ),
                                  ],
                                )
                              : Text(itemList[index]),
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
