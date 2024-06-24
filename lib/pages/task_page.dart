import 'package:flutter/material.dart';

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
                child: Text("시작 전"),
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
        body: const TabBarView(
          children: <Widget> [
            Center (
              child: Text('시작 전입니다.'),
            ),
            Center(
              child: Text('진행중입니다.'),
            ),
            Center(
              child: Text('마감된 페이지입니다.')
            ),
          ],
        )
      )
    );
  }
}