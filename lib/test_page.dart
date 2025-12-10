import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:w_allfit/components/count_down_card.dart';
import 'package:w_allfit/components/reps_count_card.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late Timer _timer;
  late int count = 10;
  late double _progress = 1;
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    startCountDown();
  }

  void startCountDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // if (count > 0) {
        count--;
        // }
        _progress = count / 10;
        // if (count == 4) {
        //   playCountDown();
        // }
        if (count <= 0) {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    void showSnackBar() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("data loded"),
        duration: Duration(seconds: 3),
      ));
    }

    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
            child: Column(
          children: [
            RepsCountCard(
              next: () {},
              previous: () {},
              complete: () {},
              name: '',
              reps: 10,
            ),
            CountDownCard(
              next: () {},
              duration: 10,
              onCount: (int count) {},
            )
          ],
        )),
      ),
    ));
  }
}
