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
            Padding(
              padding: const EdgeInsets.all(16.0), // TextField에 패딩 적용
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: '한 문장으로 일정을 등록할 수 있어요!',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  counterText: '20/30',
                  counterStyle: TextStyle(color: Colors.grey),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: white_01),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                ),
                maxLength: 30,
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity, // 가로로 최대 너비 설정
              child: ElevatedButton(
                onPressed: () {
                  //서버 요청 함수 호출
                  //_sendPostRequest();
                  // 다음 페이지 이동
                  workload_enter();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue_01, // 보라색 버튼
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  //padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  minimumSize: Size(double.infinity, 50),
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

