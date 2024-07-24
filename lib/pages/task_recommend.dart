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
              fontSize: 17.0
            ),
        ),//title 지정
      ),
      body: Container(),
    );
  }
}