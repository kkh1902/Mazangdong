import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DirectionResultPage extends StatefulWidget {
  @override
  _DirectionResultPageState createState() => _DirectionResultPageState();
}

class _DirectionResultPageState extends State<DirectionResultPage> {
  double _ratingValue = 0.0;
  List<bool> _isChecked = [false, false, false, false];
  String _opinion = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: false, // Center-align the title
          title: const Text(
            '길안내 평가',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 16.0,
            ),
          ),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.close, color: Colors.black, size: 18.0),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                }),
          ],
        ),
        body: Container(
          color: Colors.grey[100],
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '만족스러운 이동 하셨나요?',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      RatingBar(
                          initialRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ratingWidget: RatingWidget(
                              full: const Icon(Icons.star_rounded,
                                  color: Colors.yellow),
                              half: const Icon(
                                Icons.star_half_rounded,
                                color: Colors.yellow,
                              ),
                              empty: const Icon(
                                Icons.star_border_rounded,
                                color: Colors.grey,
                              )),
                          onRatingUpdate: (value) {
                            setState(() {
                              _ratingValue = value;
                            });
                          }),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '이런 점이 개선이 필요해요',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _isChecked[0],
                              onChanged: (value) {
                                setState(() {
                                  _isChecked[0] = value!;
                                });
                              }),
                          const Text('길 안내 예상시간이 정확하지 않아요')
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _isChecked[1],
                              onChanged: (value) {
                                setState(() {
                                  _isChecked[1] = value!;
                                });
                              }),
                          const Text('목적지까지 거리정보가 정확하지 않아요')
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '이런 점이 좋았어요',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _isChecked[2],
                              onChanged: (value) {
                                setState(() {
                                  _isChecked[2] = value!;
                                });
                              }),
                          const Text('길 안내 예상시간이 정확해요')
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: _isChecked[3],
                              onChanged: (value) {
                                setState(() {
                                  _isChecked[3] = value!;
                                });
                              }),
                          const Text('목적지까지 거리정보가 정확해요')
                        ],
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            _opinion = value;
                          });
                        },
                        minLines: 4,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: '작성하신 내용은 서비스 개선에 도움이 됩니다.',
                          hintStyle: TextStyle(fontSize: 12.0),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.all(12.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    '재출하기',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 16.0),
                  ))
            ],
          ),
        ));
  }
}
