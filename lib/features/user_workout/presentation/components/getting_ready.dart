import 'dart:async';

import 'package:flutter/material.dart';

class GettingReady extends StatefulWidget {
  final String exerciseName;
  final Function(int) gettingReady;
  const GettingReady(
      {required this.exerciseName, required this.gettingReady, super.key});

  @override
  State<GettingReady> createState() => _GettingReadyState();
}

class _GettingReadyState extends State<GettingReady> {
  late double _progress = 1;
  late int count = 10;
  late Timer _timer;
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startCountingDown();
    super.initState();
  }

  void startCountingDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _progress = count / 10;
        if (count <= 0) {
          _timer.cancel();
        }
        widget.gettingReady(count);
        count--;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Ready TO GO",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text("exerciseName"),
        CircularProgressIndicator(
          value: _progress,
          color: Colors.redAccent,
        )
      ],
    );
  }
}
