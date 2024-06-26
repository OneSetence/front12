import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../component/main_calendar.dart';
import '../const/colors.dart';
import '../component/schedule_card.dart';





List<ScheduleCard> start_task = [
  ScheduleCard(startTime: 12, endTime: 14, content: '예진이...', state: '시작 전'),
  ScheduleCard(startTime: 132, endTime: 134, content: '서예진.....바보><', state: '시작 전'),
];

List<ScheduleCard> ing_task = [
  ScheduleCard(startTime: 121, endTime: 124, content: '진행중인데 어쩔래', state: '진행중'),
  ScheduleCard(startTime: 123, endTime: 134, content: '와와와왕', state: '진행중'),
  ScheduleCard(startTime: 121, endTime: 124, content: '안녕', state: '진행중'),
  ScheduleCard(startTime: 123, endTime: 134, content: '하지못해', state: '진행중'),
  ScheduleCard(startTime: 121, endTime: 124, content: '미안해', state: '진행중'),
  ScheduleCard(startTime: 123, endTime: 134, content: '하지않아', state: '진행중'),
  ScheduleCard(startTime: 121, endTime: 124, content: '드라마 볼래', state: '진행중'),
  ScheduleCard(startTime: 123, endTime: 134, content: '테스트', state: '진행중'),
  ScheduleCard(startTime: 121, endTime: 124, content: '래미콘', state: '진행중'),
  ScheduleCard(startTime: 123, endTime: 134, content: '우아랑ㄴㄹ', state: '진행중'),
  ScheduleCard(startTime: 121, endTime: 124, content: 'ㅇㅇㅇㅇ', state: '진행중'),
  ScheduleCard(startTime: 123, endTime: 134, content: '깅거해', state: '진행중'),
  ScheduleCard(startTime: 121, endTime: 124, content: '오늘의', state: '진행중'),
  ScheduleCard(startTime: 123, endTime: 134, content: '행복을', state: '진행중'),

];

List<ScheduleCard> end_task = [
  ScheduleCard(startTime: 12, endTime: 14, content: '드디어 마감이에요', state: '마감'),
  ScheduleCard(startTime: 13, endTime: 110, content: '과제과제과제과제', state: '마감'),
];



class TaskPage extends StatelessWidget {
  TaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex:1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                child: Text('시작 전'),
              ),
              Tab(
                child: Text('진행중'),
              ),
              Tab(
                child: Text('마감'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget> [
            ListView.builder(
              itemCount: start_task.length,
              itemBuilder: (context, index) {
                return start_task[index];
              },
            ),
            ListView.builder(
              itemCount: ing_task.length,
              itemBuilder: (context, index) {
                return ing_task[index];
              },
            ),
            ListView.builder(
              itemCount: end_task.length,
              itemBuilder: (context, index) {
                return end_task[index];
              },
            ),
          ],
        )
      )
    );
  }
}