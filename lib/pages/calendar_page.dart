import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../component/main_calendar.dart';
import '../const/colors.dart';
import '../component/schedule_card.dart';


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

  // 일정 데이터를 저장할 Map
  Map<DateTime, List<ScheduleCard>> schedules = {
  DateTime.utc(2024, 5, 18): [
    ScheduleCard(startTime: 12, endTime: 14, content: 'Meeting with Team A'),
    ScheduleCard(startTime: 16, endTime: 17, content: 'Dentist appointment'),
    ],
  DateTime.utc(2024, 5, 19): [
    ScheduleCard(startTime: 10, endTime: 11, content: 'Conference call'),
    ],
  };

  @override
  Widget build(BuildContext context) {
    List<ScheduleCard> selectedSchedules = schedules[selectedDate] ?? [];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
            ),
            ...selectedSchedules.map((schedule) => ScheduleCard(
              startTime: schedule.startTime,
              endTime: schedule.endTime,
              content: schedule.content,
            )).toList(),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}


