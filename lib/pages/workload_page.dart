import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../const/colors.dart';
import 'package:han_final/pages/calendar_page.dart';

class WorkloadPage extends StatefulWidget {
  @override
  _WorkloadPageState createState() => _WorkloadPageState();
}

class _WorkloadPageState extends State<WorkloadPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  void calender_main() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CalendarPage(),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white_01,
      appBar: AppBar(
        backgroundColor: white_01,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '문장 일정 등록',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(16.0), // TextField에 패딩 적용
              child: Column(
                children: [
                  Center(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.number, // 숫자 키패드 설정
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly, // 숫자만 입력 가능
                      ],
                      textAlign: TextAlign.center, // 텍스트를 가운데 정렬
                      decoration: InputDecoration(
                        hintText: '작업량을 입력해주세요!',
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
                  SizedBox(height: 60),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '숫자만 입력 가능합니다',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity, // 가로로 최대 너비 설정
              child: ElevatedButton(
                onPressed: () {
                  // 서버 요청 API 연동

                  // 완료 후 캘린더 main 페이지로 이동
                  calender_main();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue_01, // 버튼 배경색 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  minimumSize: Size(double.infinity, 50), // 버튼 크기 설정
                ),
                child: Text(
                  '완료',
                  style: TextStyle(
                    fontSize: 16,
                    color: white_01,
                  ), // 흰색 텍스트
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
