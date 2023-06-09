import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final List<String> recentSearches = [
    'Keyword 1',
    'Keyword 2',
    'Keyword 3',
    'Keyword 4',
    'Keyword 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '어디로 갈까요?',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '검색어를 입력하세요',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '최근 검색',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recentSearches.length,
              itemBuilder: (context, index) {
                final keyword = recentSearches[index];
                return ListTile(
                  title: Text(keyword),
                  onTap: () {
                    // Perform search operation using the keyword
                    Navigator.pushNamed(context, '/searchresult');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
