import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mazangdong/models/ResponseModel.dart';


class RecommendtourlistPage extends StatefulWidget {
  final List<String> touristAttractionNames;
  final List<int> gwangwangjibunho;// Define the parameter

  RecommendtourlistPage({
    required this.touristAttractionNames,
    required this.gwangwangjibunho}); // Add the constructor

  // tripmodel 값
  @override
  _RecommendtourlistPageState createState() => _RecommendtourlistPageState();
}

class _RecommendtourlistPageState extends State<RecommendtourlistPage> {
  late ResponseModel responseModel;


  int selectedIndex = -1;
  List<String> tourList = [];
  List<int> gwangbunho = [];

  @override
  void initState() {
    super.initState();
    // Add the touristAttractionNames to tourList
    tourList.addAll(widget.touristAttractionNames);
    gwangbunho.addAll(widget.gwangwangjibunho);

  }





  @override
  Widget build(BuildContext context) {
    print(gwangbunho);
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
            padding: const EdgeInsets.fromLTRB(15.0, 70.0, 15.0, 10.0),
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
                    SizedBox(width: 50), // Adjust the width as needed
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
                              tourList[
                                  index], // Display the tour text dynamically
                              style: TextStyle(
                                fontSize: 20,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          subtitle: Container(
                            margin: EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/3.jpg'),
                                  radius: 15,
                                ),
                                SizedBox(width: 4),
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/3.jpg'),
                                  radius: 15,
                                ),
                                SizedBox(width: 4),
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/3.jpg'),
                                  radius: 15,
                                ),
                                SizedBox(width: 4),
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/3.jpg'),
                                  radius: 15,
                                ),
                                SizedBox(width: 4),
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/3.jpg'),
                                  radius: 15,
                                ),
                              ],
                            ),
                          ),
                          trailing: Container(
                            width: 50,
                            height: 50,
                            child: IconButton(
                              onPressed: () {
                                // Add button onPressed logic here
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
