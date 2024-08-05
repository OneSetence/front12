import 'package:flutter/material.dart';
import 'pages/task_page.dart';
import 'pages/my_page.dart';
import 'pages/calendar_page.dart';
import '../const/colors.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// 유저 닉네임 전역 상태 관리 파일
import 'provider/UserName.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting();
  KakaoSdk.init(
    nativeAppKey: '0b944cf873b74f509047c1a00350657a',
    javaScriptAppKey: 'cb81471317ab5fb1f9afe23d266c112e',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserName()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Login();
}

class _Login extends State<Login> {
  // 유저 닉네임 얻기
  final TextEditingController UserNameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  Future<void> _sendNickName() async {
    final apiUrl = 'https://9ede-122-36-149-213.ngrok-free.app/api/v1/users/sign-up';
    final userName = UserNameController.text;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        //headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nickName': userName, 'fcmToken': 'fcmtoken123'}),
      );

      if (response.statusCode == 200) {
        print('닉네임 전송 성공: ${response.body}');
      } else {
        print('API 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('예외 발생: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white_01,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 120),
                  Center(
                    child: TextField(
                      controller: UserNameController,
                      focusNode: _focusNode,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: '사용할 이름을 입력해주세요!',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        counterText: '', // 기본 카운터 텍스트 제거
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: white_01),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: white_01),
                        ),
                      ),
                      maxLength: 30,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()), // 남은 공간 채우기
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '30자 이내로 입력해주세요!',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  Provider.of<UserName>(context, listen: false).setUserName(UserNameController.text);
                  await _sendNickName(); // 서버 요청 함수 호출
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyWidget()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue_01,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  '다음',
                  style: TextStyle(
                    fontSize: 16,
                    color: white_01,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyWidget();
}

class _MyWidget extends State<MyWidget> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [TaskPage(), CalendarPage(), MyPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFFFFFF),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset("images/bottomBar/task_nonactive.png"),
            activeIcon: Image.asset("images/bottomBar/task_active.png"),
            label: '할 일',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("images/bottomBar/calendar_nonactive.png"),
            activeIcon: Image.asset("images/bottomBar/calendar_active.png"),
            label: '일정',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("images/bottomBar/my_nonactive.png"),
            activeIcon: Image.asset("images/bottomBar/my_active.png"),
            label: '마이',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF0094FF), // 선택된 항목의 라벨 색상
        unselectedItemColor: Color(0xFFACACAC),
        onTap: _onItemTapped,
      ),
    );
  }
}
