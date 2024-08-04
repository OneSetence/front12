import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../const/colors.dart';
import 'package:han_final/pages/workload_page.dart';
import '../provider/UserName.dart';
import 'package:provider/provider.dart';

class TextAdd extends StatefulWidget {
  @override
  _TextAddState createState() => _TextAddState();
}

class _TextAddState extends State<TextAdd> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void workload_enter(String apiUrl) {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (_) => WorkloadPage(apiUrl: apiUrl),
    ));
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      textAlign: TextAlign.center,
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
                onPressed: () {
                  _sendPostRequest(); // 서버 요청 함수 호출
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

  // 서버에 문장 보내기
  void _sendPostRequest() async {
    final apiUrl = 'https://9ede-122-36-149-213.ngrok-free.app/api/v1/texts';
    final requestBody = {'text': _controller.text};
    String userName = Provider.of<UserName>(context, listen: false).userName;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'nickName': userName,
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        final locationHeader = response.headers['location'];
        if (locationHeader != null) {
          // Location 헤더에 포함된 URL을 전달
          workload_enter(locationHeader);
        } else {
          print('Location 헤더가 존재하지 않습니다.');
        }
      } else {
        print('API 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('예외 발생: $e');
    }
  }
}
