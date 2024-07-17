import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../component/main_calendar.dart';
import '../const/colors.dart';
import '../component/schedule_card.dart';
import '../component/schedule_bottom_sheet.dart';



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
    ScheduleCard(
        start_year: 2024,
        start_month: 123,
        start_day: 123,
        start_hour: 1,
        start_minutes: 3,
        end_year: 2022,
        end_month: 3,
        end_day: 1,
        end_hour: 3,
        end_minutes: 3,
        content: '예지니랑 테니스하기',
        state: '시작 전'
    ),
    ]
  };

  @override
  Widget build(BuildContext context) {
    List<ScheduleCard> selectedSchedules = schedules[selectedDate] ?? [];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: main_color,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            builder: (_) => ScheduleBottomSheet(),
            isScrollControlled: true,
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              selectedDate: selectedDate,
              onDaySelected: onDaySelected,
            ),
            ...selectedSchedules.map((schedule) => ScheduleCard(
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


