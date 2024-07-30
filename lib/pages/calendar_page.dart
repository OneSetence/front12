import 'package:flutter/material.dart';
import 'package:han_final/component/custom_text_field.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/services.dart';
import '../component/main_calendar.dart';
import '../const/colors.dart';
import '../component/schedule_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:han_final/component/today_banner.dart';
import 'package:han_final/pages/text_add.dart';
import '../component/progress_dropdown.dart';
import '../component/category_dropdown.dart';
import '../component/title_textfield.dart';

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
  final TextEditingController inputTimeController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController friendController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  String selectedCategory = '학교';
  String selectedProgress = '시작전';
  Map<DateTime, List<ScheduleCard>> events = {}; // 일정 이벤트를 저장할 맵

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
    final String baseUrl = 'https://9ede-122-36-149-213.ngrok-free.app/api/v1/todos';
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      try {
        List<dynamic> todos = json.decode(utf8.decode(response.bodyBytes));
        if (todos != null) {
          setState(() {
            allSchedules = todos.map((todo) => ScheduleCard.fromJson(todo)).toList();
            _setupEvents(); // 이벤트 설정
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

  void _setupEvents() {
    events.clear(); // 기존 이벤트 초기화
    for (var schedule in allSchedules) {
      final scheduleStartDate = DateTime(
        schedule.start_year ?? 0,
        schedule.start_month ?? 1,
        schedule.start_day ?? 1,
      );

      final scheduleEndDate = DateTime(
        schedule.end_year ?? schedule.start_year ?? 0,
        schedule.end_month ?? schedule.start_month ?? 1,
        schedule.end_day ?? schedule.start_day ?? 1,
      );

      for (DateTime date = scheduleStartDate;
      date.isBefore(scheduleEndDate.add(const Duration(days: 1)));
      date = date.add(const Duration(days: 1))) {
        final dateWithoutTime = DateTime(date.year, date.month, date.day); // 시간 정보 제거
        if (events[dateWithoutTime] == null) {
          events[dateWithoutTime] = [];
        }
        events[dateWithoutTime]!.add(schedule);
      }
    }

    // Console에 이벤트 정보 출력
    events.forEach((key, value) {
      print("Date: $key, Events: ${value.length}");
    });
  }

  void _filterSchedulesForSelectedDate() {
    setState(() {
      final selectedDateWithoutTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      );
      selectedSchedules = events[selectedDateWithoutTime] ?? [];
    });
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = DateTime.utc(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      );
      this.focusedDate = focusedDate;
      _filterSchedulesForSelectedDate();
    });
  }

  String _mapProgressToStatus(String progress) {
    switch (progress) {
      case '시작전':
        return 'TODO';
      case '진행중':
        return 'IN_PROGRESS';
      case '완료':
        return 'DONE';
      default:
        return 'TODO';
    }
  }

  Future<void> onSavePressed() async {
    final int startHour = 13;
    final int startMinute = 45;
    final int endHour = 15;
    final int endMinute = 0;

    final startDateParts = startDateController.text.split('년 ');
    final startYear = int.parse(startDateParts[0]);
    final startMonth = int.parse(startDateParts[1].split('월 ')[0]);
    final startDay = int.parse(startDateParts[1].split('월 ')[1].split('일')[0]);

    final endDateParts = endDateController.text.split('년 ');
    final endYear = int.parse(endDateParts[0]);
    final endMonth = int.parse(endDateParts[1].split('월 ')[0]);
    final endDay = int.parse(endDateParts[1].split('월 ')[1].split('일')[0]);

    final String status = _mapProgressToStatus(selectedProgress);

    final String baseUrl = 'https://9ede-122-36-149-213.ngrok-free.app/api/v1/todos';
    final Map<String, dynamic> body = {
      "title": titleController.text,
      "startYear": startYear,
      "startMonth": startMonth,
      "startDay": startDay,
      "startHour": startHour,
      "startMinute": startMinute,
      "endYear": endYear,
      "endMonth": endMonth,
      "endDay": endDay,
      "endHour": endHour,
      "endMinute": endMinute,
      "category": selectedCategory,
      "status": status,
      "location": locationController.text,
      "together": friendController.text,
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
      Navigator.pop(context);
      _fetchAllSchedules();
    } else {
      print('Failed to create schedule, status code: ${response.statusCode}');
    }
  }

  void _showDateSelectionBottomSheet(BuildContext context, TextEditingController controller) {
    DateTime tempSelectedDate = selectedDate;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height / 1.7 + bottomInset,
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
                bottom: 30,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: TableCalendar(
                        locale: 'ko_KR',
                        firstDay: DateTime.utc(2000, 1, 1),
                        lastDay: DateTime.utc(2100, 12, 31),
                        focusedDay: tempSelectedDate,
                        selectedDayPredicate: (day) => isSameDay(tempSelectedDate, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            tempSelectedDate = selectedDay;
                          });
                        },
                        headerStyle: HeaderStyle(
                          titleCentered: true,
                          formatButtonVisible: false,
                        ),
                        calendarStyle: CalendarStyle(
                          isTodayHighlighted: false,
                          selectedDecoration: BoxDecoration(
                            color: blue_01,
                            shape: BoxShape.circle,
                          ),
                          todayDecoration: BoxDecoration(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.text =
                          "${tempSelectedDate.year}년 ${tempSelectedDate.month}월 ${tempSelectedDate.day}일";
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue_01,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: Size(double.infinity, 60),
                        ),
                        child: Text(
                          "${tempSelectedDate.year}년 ${tempSelectedDate.month}월 ${tempSelectedDate.day}일 선택",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      backgroundColor: Colors.transparent,
    ).then((_) {
      setState(() {
        if (controller == startDateController) {
          startDateController.text = "${tempSelectedDate.year}년 ${tempSelectedDate.month}월 ${tempSelectedDate.day}일";
        } else if (controller == endDateController) {
          endDateController.text = "${tempSelectedDate.year}년 ${tempSelectedDate.month}월 ${tempSelectedDate.day}일";
        }
      });
    });
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
                      height: MediaQuery.of(context).size.height / 1.2 + bottomInset,
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
                            Expanded(
                              child: TitleTextfield(
                                controller: titleController,
                              ),
                            ),
                            SizedBox(height:10),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    label: '시작일',
                                    isTime: true,
                                    controller: startDateController,
                                    onTap: () {
                                      _showDateSelectionBottomSheet(context, startDateController);
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: CustomTextField(
                                    label: '종료일',
                                    isTime: true,
                                    controller: endDateController,
                                    onTap: () {
                                      _showDateSelectionBottomSheet(context, endDateController);
                                    },
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
                            SizedBox(height:10),
                            Expanded(
                              child: CustomTextField(
                                label: "장소",
                                isTime: false,
                                controller: locationController,
                              ),
                            ),
                            SizedBox(height:10),
                            Expanded(
                              child: CustomTextField(
                                label: '친구',
                                isTime: false,
                                controller: friendController,
                              ),
                            ),
                            SizedBox(height:10),
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
              events: events,
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
            ),
          ],
        ),
      ),
    );
  }
}

class MainCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;
  final DateTime focusedDate;
  final Map<DateTime, List<ScheduleCard>> events;

  MainCalendar({
    required this.onDaySelected,
    required this.selectedDate,
    required this.focusedDate,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      onDaySelected: onDaySelected,
      selectedDayPredicate: (date) =>
      date.year == selectedDate.year &&
          date.month == selectedDate.month &&
          date.day == selectedDate.day,
      firstDay: DateTime(1800, 1, 1),
      lastDay: DateTime(2050, 1, 1),
      focusedDay: focusedDate,
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
        ),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        selectedDecoration: BoxDecoration(
          color: blue_01,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(), // 오늘 날짜에 대한 장식 제거
      ),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            return Positioned(
              bottom: 1,
              child: Text(
                '${events.length}', // 이벤트 개수를 표시
                style: TextStyle(color: Colors.blue, fontSize: 12.0),
              ),
            );
          }
          return null;
        },
      ),
      eventLoader: (date) {
        final dateWithoutTime = DateTime(date.year, date.month, date.day);
        return events[dateWithoutTime] ?? [];
      },
    );
  }
}















