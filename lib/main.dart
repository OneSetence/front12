import 'package:flutter/material.dart';
import 'pages/task_page.dart';
import 'pages/my_page.dart';
import 'pages/calendar_page.dart';
import '../const/colors.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFFFFFF),
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
        selectedItemColor: Color(0xFF0094FF), // 선택된 항목의 라벨 색상
        unselectedItemColor: Color(0xFFACACAC),
        onTap: _onItemTapped,
      ),
    );
  }
 }




