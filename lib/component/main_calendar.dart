import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../const/colors.dart';

class MainCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;
  final DateTime focusedDate;

  MainCalendar({
    required this.onDaySelected,
    required this.selectedDate,
    required this.focusedDate,
  });


  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_kr',
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
    );
  }
}

