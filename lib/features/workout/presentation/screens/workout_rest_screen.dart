import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_state.dart';

class WorkoutRestScreen extends StatefulWidget {
  const WorkoutRestScreen({super.key});

  @override
  State<WorkoutRestScreen> createState() => _WorkoutRestScreenState();
}

class _WorkoutRestScreenState extends State<WorkoutRestScreen> {
  Timer? _timer;
  double _progress = 1;
  int count = 10;
  final player = AudioPlayer();
  bool displayQuitOverlay = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startCountDown();
    super.initState();
  }

  void startCountDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          count--;
          _progress = count / 10;
          if (count == 4) {
            playCountDown();
          }
          if (count <= 0) {
            timer.cancel();
            _timer = null;
            Future.delayed(Duration(seconds: 1));
            if (mounted) context.push('/workoutExercise');
          }
        });
      }
    });
  }

  void playCountDown() async {
    await player.play(AssetSource('sounds/clock-countdown.wav'));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        setState(() {
          displayQuitOverlay = true;
          player.pause();
          if (_timer != null && _timer!.isActive) {
            _timer!.cancel();
            _timer = null;
          }
        });
      },
      child: Stack(children: [
        SafeArea(
          child: Scaffold(
            backgroundColor: isDark ? Colors.white : Colors.white,
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white, Colors.white60],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 4,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rest Time!",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 140,
                          height: 140,
                          child: CircularProgressIndicator(
                            value: _progress,
                            color: Colors.blueGrey,
                            backgroundColor: Colors.black12,
                            strokeWidth: 8,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "00:${count < 10 ? '0$count' : '$count'}",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child:
                        BlocConsumer<WorkoutSessionBloc, WorkoutSessionState>(
                      listener: (context, state) {
                        if (state is WorkoutComplete) {
                          context.go('/workoutComplete');
                        }
                      },
                      builder: (context, state) {
                        if (state is WorkoutExerciseInProgress) {
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Up Next',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  state.exercise.name,
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Image.network(
                                  state.exercise.image.replaceAll('mp4', 'gif'),
                                  width: 270,
                                  height: 270,
                                ),
                              ],
                            ),
                          );
                        }
                        return Text("");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (displayQuitOverlay)
          _overlayScreen(context, () {
            context.go('/workoutPlanSession');
          }, () {
            setState(() {
              displayQuitOverlay = false;
              if (_timer == null || !_timer!.isActive) {
                startCountDown();
              }

              player.resume();
            });
          })
      ]),
    );
  }
}

Widget _overlayScreen(
    BuildContext context, Function onQuit, Function onResume) {
  return SafeArea(
      child: Scaffold(
    backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
    body: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure you wanna quit',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  onResume();
                },
                child: Text('Resume'),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => onQuit(),
                child: Text('Quit'),
              ),
            )
          ],
        ),
      ),
    ),
  ));
}
