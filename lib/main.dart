import 'package:flutter/material.dart';
import 'pages/task_page.dart';
import 'pages/my_page.dart';
import 'pages/calendar_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      title: _title,
      home: MyWidget(),
    );
  }
}


class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super (key: key);

  @override
  State<StatefulWidget> createState() => _MyWidget();
}

class _MyWidget extends State<MyWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget> [
    TaskPage(),
    CalendarPage(),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('바텀시트'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset("images/bottomBar/task_nonactive.png"),
            activeIcon: Image.asset("images/bottomBar/task_active.png"),
            label: '할 일',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("images/bottomBar/calendar_nonactive.png"),
            activeIcon: Image.asset("images/bottomBar/calendar_active.png"),
            label: '일정',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("images/bottomBar/my_nonactive.png"),
            activeIcon: Image.asset("images/bottomBar/my_active.png"),

            label: '마이',
          ),
        ],

        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
 }




