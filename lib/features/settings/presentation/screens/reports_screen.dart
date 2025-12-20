import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  DateTime? _rangeStartDay;
  DateTime? _rangeEndDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    getUserLogdates();
  }

  void getUserLogdates() async {
    final List<String> dates = await userLogDates();
    _rangeStartDay = DateFormat('yyyy-MM-dd').parse(dates[0]);
    _rangeEndDay = DateFormat('yyyy-MM-dd').parse(dates[dates.length - 1]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
              focusedDay: _focusedDay,
              rangeStartDay: _rangeStartDay,
              rangeEndDay: _rangeEndDay,
              selectedDayPredicate: (date) => isSameDay(_selectedDay, date),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                  rangeHighlightColor: Colors.redAccent,
                  selectedDecoration: BoxDecoration(
                    color: Colors.lightBlue,
                  )),
            ),
          ],
        ),
      ),
    ));
  }
}
