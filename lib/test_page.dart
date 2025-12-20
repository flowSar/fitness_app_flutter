import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:w_allfit/core/data/models/exercise_model.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late bool disyplayOverlayScreen = false;

  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    getUserLogsdates();
  }

  Future<void> getUserLogsdates() async {
    final List<String> dates = await userLogDates();
    print('dates $dates');
    _startDate = DateFormat('yyyy-MM-dd').parse(dates[0]);
    _endDate = DateFormat('yyyy-MM-dd').parse(dates[1]);
  }

  void _onDaySelected(selectedDay, focusDay) {
    if (!isSameDay(selectedDay, _selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            setState(() {
              disyplayOverlayScreen = true;
            });
          },
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: EdgeInsets.all(10),
                child: SafeArea(
                    child: Scaffold(
                  body: Column(
                    children: [
                      Text('$currentDate'),
                      TableCalendar(
                        firstDay: DateTime(2020),
                        lastDay: DateTime(2035),
                        focusedDay: _focusedDay,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        rangeStartDay: _startDate,
                        rangeEndDay: _endDate,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        onDaySelected: _onDaySelected,
                      ),
                    ],
                  ),
                )),
              ),
            ),
          ),
        ),
        if (disyplayOverlayScreen)
          _overlayScreen(context, () {
            setState(() {
              disyplayOverlayScreen = false;
            });
          }),
      ],
    );
  }
}

Widget _overlayScreen(BuildContext context, VoidCallback fn) {
  final width = MediaQuery.sizeOf(context).width * 0.90;
  return Positioned.fill(
      child: SafeArea(
          child: Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromRGBO(62, 61, 66, 0.699),
    ),
    backgroundColor: Color.fromRGBO(62, 61, 66, 0.699),
    body: SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            style: TextButton.styleFrom(
                fixedSize: Size(width, 60),
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            child: Text(
              'quit',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: () {
              fn();
            },
            style: TextButton.styleFrom(
                fixedSize: Size(width, 60),
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            child: Text(
              'Resume',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    ),
  )));
}

class ExerciseCardTest extends StatefulWidget {
  final ExerciseModel exercise;
  final Function(ExerciseModel exercise)? onUpdate;
  const ExerciseCardTest(
      {super.key, required this.exercise, required this.onUpdate});

  @override
  State<ExerciseCardTest> createState() => _ExerciseCardTestState();
}

class _ExerciseCardTestState extends State<ExerciseCardTest> {
  void _showDialog() {
    late int reps = widget.exercise.reps;
    late int sets = widget.exercise.sets;
    late int duration = widget.exercise.duration;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setDialogState) {
          return AlertDialog(
            title: Text(
              'Edit Exercise ${widget.exercise.name}',
              style: TextStyle(fontSize: 16),
            ),
            content: SizedBox(
              height: 200,
              child: Column(
                children: [
                  _buildDialogField((value) {
                    setDialogState(() {
                      reps = value;
                    });
                  }, reps),
                  SizedBox(
                    height: 10,
                  ),
                  _buildDialogField((value) {
                    setDialogState(() {
                      sets = value;
                    });
                  }, sets),
                  SizedBox(
                    height: 10,
                  ),
                  _buildDialogField((value) {
                    setDialogState(() {
                      duration = value;
                    });
                  }, duration)
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text('cancel')),
              TextButton(
                  onPressed: () {
                    widget.onUpdate!(widget.exercise
                        .copyWith(sets: sets, reps: reps, duration: duration));
                    context.pop();
                  },
                  child: Text('Save'))
            ],
          );
        });
      },
    );
  }

  Widget _buildDialogField(
    Function(int) onChanged,
    int value,
  ) {
    late int minValue = value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
            onPressed: () {
              onChanged(minValue + 1);
            },
            child: Text(
              '+',
              style: TextStyle(fontSize: 30),
            )),
        Text(
          '$minValue',
        ),
        TextButton(
            onPressed: () {
              if (minValue > 1) {
                onChanged(minValue - 1);
              }
            },
            child: Text(
              '-',
              style: TextStyle(fontSize: 30),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.exercise.name),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20,
                  color: Colors.white70,
                ),
                onPressed: _showDialog,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            spacing: 6,
            children: [
              Text('reps: ${widget.exercise.reps}'),
              Text('sets: ${widget.exercise.sets}'),
              Text('duration: ${widget.exercise.duration}'),
            ],
          )
        ],
      ),
    );
  }
}
