import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../const/colors.dart';

class TaskRecommend extends StatelessWidget {
  TaskRecommend({Key? key}) : super(key: key);

  final List<String> tasks = [
    'Task 1',
    'Task 2',
    'Task 3',
    'Task 4',
    'Task 5',
    'Task 6',
    'Task 7',
    'Task 8',
    'Task 9',
    'Task 10',
    'Task 10',
    'Task 10',
    'Task 10',
    'Task 10',
    'Task 10',
    'Task 10',
    'Task 10',
    'Task 10',
    'Task 10',
    'Task 10',

    // 추가 항목을 여기에 추가할 수 있습니다.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white, // AppBar의 배경색을 고정
        title: Text(
          '일정 순서 추천',
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.black, // 텍스트 색상 설정
          ),
        ),
        elevation: 0, // AppBar의 그림자 제거
        iconTheme: IconThemeData(color: Colors.black), // 아이콘 색상 설정
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              '스킵이 예진 님의',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              '일정 순서를 추천해드렸어요.',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            ...tasks.map((task) => ListTile(
              title: Text(task),
              leading: Icon(Icons.check_circle),
            )).toList(),
          ],
        ),
      ),
    );
  }
}

