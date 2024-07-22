import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../const/colors.dart';
import 'package:han_final/pages/workload_page.dart';

class TextAdd extends StatefulWidget {
  @override
  _TextAddState createState() => _TextAddState();
}

class _TextAddState extends State<TextAdd> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void workload_enter() {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (_) => WorkloadPage(),
    ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
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
                      textAlign: TextAlign.center, // 텍스트를 가운데 정렬
                      decoration: InputDecoration(
                        hintText: '한 문장으로 일정을 등록할 수 있어요!',
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
                      '30자 이내로 입력해주세요!',
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
                  // 서버 요청 함수
                  //_sendPostRequest();
                  workload_enter();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue_01, // 버튼 배경색 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  minimumSize: Size(double.infinity, 50), // 버튼 크기 설정
                ),
                child: Text(
                  '다음',
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

// 서버에 문장 보내기
  void _sendPostRequest() async {
    final url = Uri.parse('http://192.168.100.22:8080/api/v1/texts');
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({"text": "서예지니니니니닌."});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        print('Success: ${response.body}');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch
    (e) {
      print('Exception: $e');
    }
  }


}

