import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyPageMain(),
      ),
    );
  }
}


class MyPageMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    '서예진',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('Seoyejin@naver.com'),
                ],
              ),
            ],
          ),
          SizedBox(height: 32),
          Text('예진 님의 일정은 얼마나 지켜졌을까요?'),
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
          MenuOption(title: '카테고리 설정하러 가기'),
          MenuOption(title: '개인정보처리방침'),
          MenuOption(title: '서비스 이용약관'),
          MenuOption(title: '로그아웃'),
          MenuOption(title: '회원탈퇴'),
          MenuOption(title: '버전 정보'),
        ],
      ),
    );
  }
}

class MenuOption extends StatelessWidget {
  final String title;

  MenuOption({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Handle tap event
      },
    );
  }
}
