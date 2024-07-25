import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../component/main_calendar.dart';
import '../const/colors.dart';
import '../component/schedule_card.dart';
// 일정 순서 추천 페이지 이동을 위한
import 'package:han_final/pages/task_recommend.dart';

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
    final response = await http.get(Uri.parse('https://8b21-122-36-149-213.ngrok-free.app/api/v1/todos/statuses?status=TODO'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      setState(() {
        startTask = jsonResponse.map((task) => ScheduleCard.fromJson(task)).toList();
      });
    } else {
      throw Exception('Failed to load tasks');
    }
    final response2 = await http.get(Uri.parse('https://8b21-122-36-149-213.ngrok-free.app/api/v1/todos/statuses?status=IN_PROGRESS'));

    if (response2.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(utf8.decode(response2.bodyBytes));
      setState(() {
        ingTask = jsonResponse.map((task) => ScheduleCard.fromJson(task)).toList();
      });
    } else {
      throw Exception('Failed to load tasks');
    }

    final response3 = await http.get(Uri.parse('https://8b21-122-36-149-213.ngrok-free.app/api/v1/todos/statuses?status=DONE'));

    if (response3.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(utf8.decode(response3.bodyBytes));
      setState(() {
        endTask = jsonResponse.map((task) => ScheduleCard.fromJson(task)).toList();
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

  void task_recommend() {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (_) => TaskRecommend(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final _selectedColor = blue_01;
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0), // AppBar와 아래 콘텐츠 사이 여백
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
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            ListView.builder(
              itemCount: startTask.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0), // 리스트 아이템 사이 여백
                  child: startTask[index],
                );
              },
            ),
            ListView.builder(
              itemCount: ingTask.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0), // 리스트 아이템 사이 여백
                  child: ingTask[index],
                );
              },
            ),
            ListView.builder(
              itemCount: endTask.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0), // 리스트 아이템 사이 여백
                  child: endTask[index],
                );
              },
            ),
          ],
        ),
        floatingActionButton: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: 20, // 여기서 원하는 만큼의 간격을 조정할 수 있습니다.
              child: Container(
                height: 50.0, // 버튼 높이 조정
                child: FloatingActionButton.extended(
                  onPressed: task_recommend,
                  label: Text(
                    '일정 순서를 추천 받아요!',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: white_01
                    ), // 텍스트 크기 조정
                  ),
                  icon: Icon(
                    Icons.thumb_up,
                    size: 15.0,
                    color: white_01,
                  ), // 아이콘 크기 조정
                  backgroundColor: _selectedColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // 원하는 반경 값 설정
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
