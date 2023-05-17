import 'package:flutter/material.dart';

class RecommendaccomodationlistPage extends StatefulWidget {
  @override
  _RecommendaccomodationlistPageState createState() =>
      _RecommendaccomodationlistPageState();
}

class _RecommendaccomodationlistPageState
    extends State<RecommendaccomodationlistPage> {
  List<String> tourList = [
    '숙소 1',
    '숙소 2',
    '숙소 3',
    '숙소 4',
    '숙소 5',
  ];

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
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
                      '추천 숙소 목록',
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
