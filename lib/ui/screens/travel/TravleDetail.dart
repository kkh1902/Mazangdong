import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class TravelDetailPage extends StatefulWidget {
  final int bunho;

  TravelDetailPage({required this.bunho});
  @override
  _TravelDetailPageState createState() => _TravelDetailPageState();
}

class _TravelDetailPageState extends State<TravelDetailPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      fetchData();
    });
  }

  List<String> imagePaths = [
  ];


  String name = ''; // 데이터를 저장할 변수들
  String category = '';
  String juso = '';
  String munbunho = '';
  String sulmyung = '';
  int jucha = 0;
  int wheel = 0;
  int elevator = 0;
  int restroom = 0;


  void fetchData() async {
    try {
      final response = await http.get(Uri.parse('https://majangdong.run.goorm.site/detail/${widget.bunho}'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        print(data.runtimeType);

        setState(() {
          name = data[0]['관광지이름'];
          category = data[0]['분류'];
          juso = data[0]['주소'];
          munbunho = data[0]['문의번호'];
          sulmyung = data[0]['설명'];
          jucha = int.parse(data[0]['주차여부']);
          wheel = int.parse(data[0]['휠체어대여']);
          elevator = int.parse(data[0]['엘리베이터']);
          restroom = int.parse(data[0]['화장실']);
        });


      } else {
        print('Failed to fetch data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }



  @override
  Widget build(BuildContext context) {
    print(widget.bunho);
    print(widget.bunho.runtimeType);
    print("sulmyung$sulmyung");
    print("jucha: $jucha");
    print(jucha.runtimeType);

    imagePaths.add('assets/images/trip/${widget.bunho}.jpg');

    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 70.0, 10.0, 10.0),
        child: ListView(
          padding: EdgeInsets.all(10.0),
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blue),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 16.0),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        imagePaths[index],
                        fit: BoxFit.cover,
                        width: 400, // Adjust the width as desired
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              category,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              juso,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle 길안내 button pressed
                    },
                    icon: Icon(Icons.directions),
                    label: Text('길안내'),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle 전화하기 button pressed
                    },
                    icon: Icon(Icons.phone),
                    label: Text('전화하기'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (jucha == 1)
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/convenince/parking.png'),
                    radius: 30,
                  ),
                if (wheel == 1)
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/convenince/wheel.png'),
                    radius: 30,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/convenince/wheeldog.png'),
                    radius: 30,
                  ),
                if (restroom == 1)
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/convenince/wc.png'),
                    radius: 30,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/convenince/경사로.png'),
                    radius: 30,
                  ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              '설명',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              sulmyung,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '참고',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            Text(
              '',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
