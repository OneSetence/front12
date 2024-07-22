import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../component/main_calendar.dart';
import '../const/colors.dart';
import '../component/schedule_card.dart';

class TaskPage extends StatefulWidget {
  TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with SingleTickerProviderStateMixin {
  List<ScheduleCard> startTask = [];
  List<ScheduleCard> ingTask = [];
  List<ScheduleCard> endTask = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    fetchTasks();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> fetchTasks() async {
    final response = await http.get(Uri.parse('http://192.168.100.22:8080/api/v1/todos?status=TODO'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        startTask = jsonResponse.map((task) => ScheduleCard.fromJson(task)).toList();
      });
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _selectedColor = Color(0xff1a73e8);
    final _unselectedColor = Color(0xff5f6368);

    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight - 8.0),
            child: Container(
              height: kToolbarHeight - 8.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: _selectedColor,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '시작 전',
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '진행중',
                            ),
                          ),
                        ),
                        Tab(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '마감',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
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
