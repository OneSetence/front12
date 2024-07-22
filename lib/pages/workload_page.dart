import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../const/colors.dart';

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
                onPressed:() {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue_01, // 보라색 버튼
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  //padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  minimumSize: Size(double.infinity, 50),
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
  // 서버 요청 함수

  // 다음 페이지 이동 함수
}