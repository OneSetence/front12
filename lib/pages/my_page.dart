import 'package:flutter/material.dart';
import 'package:han_final/pages/practice.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../const/colors.dart';

class MyPage extends StatelessWidget {
  MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: white_01,
        appBar: AppBar(
          backgroundColor: white_01,
          title: Text(
              '마이페이지',
              style: TextStyle(fontSize: 17),
          ), // AppBar의 제목 설정
          //actions: [
            //IconButton(
              //icon: Icon(Icons.settings),
              //onPressed: () {
                // 설정 버튼 클릭 시 동작
              //},
            //),
          //],
        ),
        body: MyPageMain(),
      ),
    );
  }
}

class MyPageMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void leedong() {
      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (_) => NextScreen(),
      ));
    }

    return Padding(

      padding: const EdgeInsets.all(16.0),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '강민정',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('Seoyejin@naver.com'),
                ],
              ),
            ],
          ),
          SizedBox(height: 32),
          Text('강민정 님의 일정은 얼마나 지켜졌을까요?'),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '80%나 완료되었어요!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 32),
          MenuOption(title: '카테고리 설정하러 가기', onTap: _sendPostRequest),
          MenuOption(
            title: '개인정보처리방침',
            onTap: leedong,
          ),
          MenuOption(title: '서비스 이용약관'),
          MenuOption(title: '로그아웃'),
          MenuOption(title: '회원탈퇴'),
          MenuOption(title: '버전 정보'),
        ],
      ),
    );
  }

  void _sendPostRequest() async {
    final url = Uri.parse('https://8b21-122-36-149-213.ngrok-free.app/api/v1/texts');
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({"text": "서 예 진 공 차 알 바 생"});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Success: ${response.body}');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}

class MenuOption extends StatelessWidget {
  final String title;
  final Function()? onTap;

  MenuOption({required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
