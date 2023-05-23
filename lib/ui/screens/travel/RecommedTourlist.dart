import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mazangdong/models/ResponseModel.dart';
import 'package:mazangdong/models/SelectedModel.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


class RecommendtourlistPage extends StatefulWidget {
  final List<String> touristAttractionNames;
  final List<int> gwangwangjibunho;

  RecommendtourlistPage({
    required this.touristAttractionNames,
    required this.gwangwangjibunho,
  });

  @override
  _RecommendtourlistPageState createState() => _RecommendtourlistPageState();
}

class _RecommendtourlistPageState extends State<RecommendtourlistPage> {
  late ResponseModel responseModel;
  late SelectedModel selectedModel;

  int selectedIndex = -1;
  List<String> tourList = [];
  List<int> gwangbunho = [];

  @override
  void initState() {
    super.initState();
    tourList.addAll(widget.touristAttractionNames);
    gwangbunho.addAll(widget.gwangwangjibunho);
    fetchData(gwangbunho[0]);
  }

  String name = ''; // 데이터를 저장할 변수들
  int jucha = 0;
  int wheel = 0;
  int elevator = 0;
  int restroom = 0;

  void fetchData(int bunho) async {
    try {
      final response = await http.get(Uri.parse('https://majangdong.run.goorm.site/detail/$bunho'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        print(data.runtimeType);

        // 데이터를 가져온 후 필요한 값들을 설정해줍니다.
        setState(() {
          // 예시로 데이터를 가져와서 필드에 설정해주는 코드를 작성해주세요.
          name = data[0]['관광지이름'];
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
    selectedModel = Provider.of<SelectedModel>(context, listen: false);

    return Scaffold(
      appBar: null,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.fromLTRB(30.0, 70.0, 30.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      '추천 관광지 목록',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 50),
                  ],
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: tourList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: selectedIndex == index
                              ? Colors.green
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Align(
                            alignment: Alignment.center,
                            child: Text(
                              tourList[index],
                              style: TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          subtitle: Container(
                            margin: EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (jucha == 1)
                                  CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/convenince/parking.png'),
                                    radius: 20,
                                  ),
                                if (wheel == 1)
                                  CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/convenince/wheel.png'),
                                    radius: 20,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/convenince/wheeldog.png'),
                                    radius: 20,
                                  ),
                                if (restroom == 1)
                                  CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/convenince/wc.png'),
                                    radius: 20,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: AssetImage('assets/images/convenince/경사로.png'),
                                    radius: 20,
                                  ),
                              ],
                            ),
                          ),
                          trailing: Container(
                            width: 50,
                            height: 50,
                            child: IconButton(
                              onPressed: () {
                                selectedModel.addItem(gwangbunho[index]);
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.blue,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
