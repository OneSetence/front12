import 'package:flutter/material.dart';
import 'package:han_final/component/custom_text_field.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/services.dart';
import '../component/main_calendar.dart';
import '../const/colors.dart';
import '../component/schedule_card.dart';
import '../component/schedule_bottom_sheet.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:han_final/component/today_banner.dart';
import 'package:han_final/pages/text_add.dart';
import '../component/progress_dropdown.dart';
import '../component/category_dropdown.dart';

class CalendarPage extends StatefulWidget {
  CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarState();
}

class _CalendarState extends State<CalendarPage> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDate = DateTime.now();
  List<ScheduleCard> allSchedules = [];
  List<ScheduleCard> selectedSchedules = [];
  final TextEditingController startController = TextEditingController();
  final TextEditingController endController = TextEditingController();
  final TextEditingController inputTimeController = TextEditingController();
  String selectedCategory = '';
  String selectedProgress = '';

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    _fetchAllSchedules();
  }

  Future<void> _fetchAllSchedules() async {
    final String baseUrl = 'https://8b21-122-36-149-213.ngrok-free.app/api/v1/todos';
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      try {
        List<dynamic> todos = json.decode(utf8.decode(response.bodyBytes)); // 수정된 부분
        if (todos != null) {
          setState(() {
            allSchedules = todos.map((todo) => ScheduleCard.fromJson(todo)).toList();
            _filterSchedulesForSelectedDate();
          });
        } else {
          print('No schedules found in response.');
        }
      } catch (e) {
        print('Error parsing JSON: $e');
      }
    } else {
      print('Failed to load schedules, status code: ${response.statusCode}');
    }
  }

  void _filterSchedulesForSelectedDate() {
    setState(() {
      selectedSchedules = allSchedules.where((schedule) {
        final scheduleDate = DateTime(
          schedule.start_year ?? 0,
          schedule.start_month ?? 1,
          schedule.start_day ?? 1,
        );
        return scheduleDate.year == selectedDate.year &&
            scheduleDate.month == selectedDate.month &&
            scheduleDate.day == selectedDate.day;
      }).toList();
    });
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
      this.focusedDate = focusedDate;
      _filterSchedulesForSelectedDate();
    });
  }

  Future<void> onSavePressed() async {
    final String baseUrl = 'https://8b21-122-36-149-213.ngrok-free.app/api/v1/todos';
    final Map<String, dynamic> body = {
      "title": "시간표 짜기", // Title can be fetched from an input field if needed
      "start": startController.text,
      "end": endController.text,
      "category": selectedCategory,
      "status": selectedProgress,
      "location": "집", // Location can be fetched from an input field if needed
      "together": "서에진", // Together can be fetched from an input field if needed
      "inputTime": int.tryParse(inputTimeController.text) ?? 0,
    };

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );

    if (response.statusCode == 201) {
      print('Schedule created successfully');
    } else {
      print('Failed to create schedule, status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(
                Alignment.bottomRight.x, Alignment.bottomRight.y - 0.2),
            child: FloatingActionButton(
              backgroundColor: blue_01,
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
                    return Container(
                      height: MediaQuery.of(context).size.height / 1.8 + bottomInset,
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        bottom: 30,
                      ),
                      decoration: const BoxDecoration(
                        color: white_01,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, right:20, top:20, bottom:20),
                        child: Column(
                          children: [
                            Image.asset('images/bottomdown.png'),
                            SizedBox(height:12),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    label: '시작일',
                                    isTime: true,
                                    controller: startController,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: CustomTextField(
                                    label: '종료일',
                                    isTime: true,
                                    controller: endController,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '진행상태',
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: 50,
                              child: ProgressDropdown(
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedProgress = value ?? '';
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text('카테고리'),
                            ),
                            Container(
                              height: 50,
                              child: CategoryDropdown(
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedCategory = value ?? '';
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Expanded(
                              child: CustomTextField(
                                label: '작업량',
                                isTime: false,
                                controller: inputTimeController,
                              ),
                            ),
                            SizedBox(height:15),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: onSavePressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: blue_01,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  minimumSize: Size(double.infinity, 60),
                                ),
                                child: Text(
                                  '등록하기',
                                  style: TextStyle(
                                    color: white_01,
                                  )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  backgroundColor: Colors.transparent,
                );
              },
              child: Icon(
                Icons.add,
                color: white_01,
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: blue_01,
              onPressed: () {
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                    builder: (_) => TextAdd(),
                  ),
                );
              },
              tooltip: "문장 등록",
              child: Icon(
                Icons.edit,
                color: white_01,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
              focusedDate: focusedDate,
            ),
            SizedBox(height: 10.0),
            TodayBanner(
              selectedDate: selectedDate,
              count: selectedSchedules.length,
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: ListView(
                children: selectedSchedules.map((schedule) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ScheduleCard(
                    start_year: schedule.start_year,
                    start_month: schedule.start_month,
                    start_day: schedule.start_day,
                    start_hour: schedule.start_hour,
                    start_minutes: schedule.start_minutes,
                    end_year: schedule.end_year,
                    end_month: schedule.end_month,
                    end_day: schedule.end_day,
                    end_hour: schedule.end_hour,
                    end_minutes: schedule.end_minutes,
                    content: schedule.content,
                    state: schedule.state,
                  ),
                )).toList(),
              ),
           
