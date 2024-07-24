import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../const/colors.dart';

class TaskRecommend extends StatelessWidget {
  TaskRecommend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white_01,
      appBar: AppBar(
        backgroundColor: white_01,
        title: Text(
          '일정 순서 추천',
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.black, // 텍스트 색상 설정
          ),
        ), //title 지정
        elevation: 0, // AppBar의 그림자 제거
        iconTheme: IconThemeData(color: Colors.black), // 아이콘 색상 설정
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // 원하는 패딩 값 설정
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            Text(
              '스킵이 예진 님의',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                // 텍스트 색상 설정
              ),
            ),
            SizedBox(height:5.0),
            Text(
              '일정 순서를 추천해드렸어요.',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,// 텍스트 색상 설정
              ),
            ),
            // 추가적으로 다른 위젯들도 여기에 넣을 수 있습니다.
          ],
        ),
      ),
    );
  }
}
