import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  Set<DateTime> loginDays = {};

  @override
  void initState() {
    getUserLogdates();
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  void getUserLogdates() async {
    final List<String> dates = await userLogDates();
    for (final date in dates) {
      setState(() {
        loginDays.add(DateFormat('yyyy-MM-dd').parse(date));
      });
    }
  }

  // Function to check if a date is in the login dates
  bool isLoginDay(DateTime date) {
    for (var loginDate in loginDays) {
      if (date.year == loginDate.year &&
          date.month == loginDate.month &&
          date.day == loginDate.day) {
        return true;
      }
    }
    return false;
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
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  print(
                      '--------------------------${day.day}-------------------------------');
                  if (isLoginDay(day)) {
                    // return Positioned(
                    //   right: 1,
                    //   bottom: 1,
                    //   child: Icon(
                    //     FontAwesomeIcons.fireFlameCurved,
                    //     size: 24, // Adjust size to fit the cell
                    //     color: Colors.red, // Icon color
                    //   ),
                    // );
                    return Positioned(
                      right: 1,
                      bottom: 1,
                      left: 1,
                      top: 1,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.red, // Mark the login days with green
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                            child: Text(
                          day.day.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
              selectedDayPredicate: (date) => isSameDay(_selectedDay, date),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
            ),
          ],
        ),
      ),
    ));
  }
}
