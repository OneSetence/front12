import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../const/colors.dart';
import '../component/schedule_card.dart';
import '../provider/UserName.dart';
import 'package:provider/provider.dart';

class TaskRecommend extends StatefulWidget {
  TaskRecommend({Key? key}) : super(key: key);

  @override
  _TaskRecommendState createState() => _TaskRecommendState();
}

class _TaskRecommendState extends State<TaskRecommend> {
  List<ScheduleCard> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    String userName = Provider.of<UserName>(context, listen: false).userName;
    final response = await http.get(
      Uri.parse('https://9ede-122-36-149-213.ngrok-free.app/api/v1/todos/priorities'),
      headers: {'nickName': userName},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        tasks = jsonResponse.map((task) => ScheduleCard.fromJson(task)).toList();
      });
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  @override
  Widget build(BuildContext context) {
    String userName = Provider.of<UserName>(context).userName;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '일정 순서 추천',
          style: TextStyle(
            fontSize: 17.0,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              '한끝이 ${userName} 님의',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              '일정 순서를 추천해드렸어요.',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            ListView.builder(
              shrinkWrap: true, // ListView.builder의 크기를 자식 요소에 맞춤
              physics: NeverScrollableScrollPhysics(), // 스크롤 동작 비활성화
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: tasks[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}




