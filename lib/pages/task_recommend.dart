import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../const/colors.dart';
import '../component/schedule_card.dart';

class TaskRecommend extends StatefulWidget {
  TaskRecommend({Key? key}) : super(key: key);

  @override
  _TaskRecommendState createState() => _TaskRecommendState();
}

class _TaskRecommendState extends State<TaskRecommend> {
  List<ScheduleCard> tasks = [
    // 더미 데이터
    ScheduleCard(
      start_year: 2024,
      start_month: 7,
      start_day: 30,
      start_hour: 9,
      start_minutes: 0,
      end_year: 2024,
      end_month: 7,
      end_day: 30,
      end_hour: 10,
      end_minutes: 0,
      content: '더미 일정 - 회의',
      state: 'TODO',
    ),
    ScheduleCard(
      start_year: 2024,
      start_month: 7,
      start_day: 30,
      start_hour: 9,
      start_minutes: 0,
      end_year: 2024,
      end_month: 7,
      end_day: 30,
      end_hour: 10,
      end_minutes: 0,
      content: '더미 일정 - 회의',
      state: 'TODO',
    ),
    ScheduleCard(
      start_year: 2024,
      start_month: 7,
      start_day: 30,
      start_hour: 9,
      start_minutes: 0,
      end_year: 2024,
      end_month: 7,
      end_day: 30,
      end_hour: 10,
      end_minutes: 0,
      content: '더미 일정 - 회의',
      state: 'TODO',
    ),
    ScheduleCard(
      start_year: 2024,
      start_month: 7,
      start_day: 30,
      start_hour: 9,
      start_minutes: 0,
      end_year: 2024,
      end_month: 7,
      end_day: 30,
      end_hour: 10,
      end_minutes: 0,
      content: '더미 일정 - 회의',
      state: 'TODO',
    ),
    ScheduleCard(
      start_year: 2024,
      start_month: 7,
      start_day: 30,
      start_hour: 9,
      start_minutes: 0,
      end_year: 2024,
      end_month: 7,
      end_day: 30,
      end_hour: 10,
      end_minutes: 0,
      content: '더미 일정 - 회의',
      state: 'TODO',
    ),
    ScheduleCard(
      start_year: 2024,
      start_month: 7,
      start_day: 30,
      start_hour: 9,
      start_minutes: 0,
      end_year: 2024,
      end_month: 7,
      end_day: 30,
      end_hour: 10,
      end_minutes: 0,
      content: '더미 일정 - 회의',
      state: 'TODO',
    ),ScheduleCard(
      start_year: 2024,
      start_month: 7,
      start_day: 30,
      start_hour: 9,
      start_minutes: 0,
      end_year: 2024,
      end_month: 7,
      end_day: 30,
      end_hour: 10,
      end_minutes: 0,
      content: '더미 일정 - 회의',
      state: 'TODO',
    ),
    ScheduleCard(
      start_year: 2024,
      start_month: 7,
      start_day: 30,
      start_hour: 9,
      start_minutes: 0,
      end_year: 2024,
      end_month: 7,
      end_day: 30,
      end_hour: 10,
      end_minutes: 0,
      content: '더미 일정 - 회의',
      state: 'TODO',
    ),

  ];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final response = await http.get(Uri.parse('https://8b21-122-36-149-213.ngrok-free.app/api/v1/todos?status=TODO'));

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
              '스킵이 예진 님의',
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



