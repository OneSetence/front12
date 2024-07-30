import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../const/colors.dart';
import 'package:han_final/pages/calendar_page.dart';

class WorkloadPage extends StatefulWidget {
  final String apiUrl;

  WorkloadPage({required this.apiUrl});

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
    Navigator.pop(context);
    Navigator.pop(context);
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: '작업량을 입력해주세요!',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        counterText: '',
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
            Expanded(child: Container()), // 남은 공간을 차지하도록 설정
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '숫자만 입력 가능합니다',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _sendWorkload(); // 서버 요청 API 연동
                  calender_main(); // 완료 후 캘린더 main 페이지로 이동
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue_01,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  '완료',
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

  // 서버에 작업량 데이터 보내기
  void _sendWorkload() async {
    final baseUrl = 'https://9ede-122-36-149-213.ngrok-free.app';
    final completeUrl = '$baseUrl${widget.apiUrl}'; // 기본 URL과 전달된 URL 결합
    final requestBody = {'inputTime': _controller.text};

    try {
      final response = await http.patch(
        Uri.parse(completeUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('작업량 전송 성공: ${response.body}');
      } else {
        print('API 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('예외 발생: $e');
    }
  }
}

