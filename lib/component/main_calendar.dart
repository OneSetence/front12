import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../const/colors.dart';
import '../component/schedule_card.dart';


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
        markerBuilder: (context, date, _) {
          final eventCount = events[date]?.length ?? 0;
          if (eventCount > 0) {
            return Positioned(
              bottom: 1,
              child: Text(
                '$eventCount', // 이벤트 개수를 표시
                style: TextStyle(color: Colors.blue, fontSize: 12.0),
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
