import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../component/main_calendar.dart';
import '../const/colors.dart';
import '../component/schedule_card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class TaskPage extends StatefulWidget {
  TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<ScheduleCard> startTask = [];
  List<ScheduleCard> ingTask = [
    // 나머지 항목들 생략
  ];
  List<ScheduleCard> endTask = [

  ];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final response = await http.get(Uri.parse('http://192.168.100.22:8080/api/v1/todos?status=TODO'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        startTask = jsonResponse.map((task) => ScheduleCard.fromJson(task)).toList();
      });
    } else {
      throw Exception('Failed to load tasksddddd');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                child: Text(
                    '시작 전',
                    style: TextStyle(
                      color: blue_01,
                    ),
                ),
              ),
              Tab(
                child: Text(
                    '진행중',
                    style: TextStyle(
                      color: blue_01,
                    ),
                ),
              ),
              Tab(
                child: Text(
                    '마감',
                    style: TextStyle(
                      color: blue_01,
                    ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(

          children: <Widget>[
            ListView.builder(
              itemCount: startTask.length,
              itemBuilder: (context, index) {
                return startTask[index];
              },
            ),
            ListView.builder(
              itemCount: ingTask.length,
              itemBuilder: (context, index) {
                return ingTask[index];
              },
            ),
            ListView.builder(
              itemCount: endTask.length,
              itemBuilder: (context, index) {
                return endTask[index];
              },
            ),
          ],
        ),
      ),
    );
  }
}