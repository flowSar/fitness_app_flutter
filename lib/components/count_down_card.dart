import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class CountDownCard extends StatefulWidget {
  final VoidCallback next;
  final int duration;
  final Function(int count) onCount;
  const CountDownCard(
      {super.key,
      required this.next,
      required this.duration,
      required this.onCount});

  @override
  State<CountDownCard> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CountDownCard> {
  late Timer _timer;
  late int count = widget.duration;
  late double _progress = 1;
  final player = AudioPlayer();
  @override
  void dispose() {
    _timer.cancel();
    player.pause();
    super.dispose();
  }

  @override
  void initState() {
    startCountDown();
    super.initState();
  }

  void startCountDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (count > 0) {
          // pass the count
          count--;
          widget.onCount(count);
        }

        _progress = count / widget.duration;
        if (count == 4) {
          playCountDown();
        }
        if (count <= 0) {
          _timer?.cancel();
        }
      });
    });
  }

  void playCountDown() async {
    await player.play(AssetSource('sounds/clock-countdown.wav'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      children: [
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 120,
          height: 120,
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
        SizedBox(
          height: 20,
        ),
        Row(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  setState(() {
                    if (_timer!.isActive) {
                      _timer?.cancel();
                      player.pause();
                    } else {
                      startCountDown();
                      player.resume();
                    }
                  });
                },
                style: TextButton.styleFrom(
                    backgroundColor:
                        _timer!.isActive ? Colors.red : Colors.green,
                    fixedSize: Size(120, 45)),
                child: Text(
                  _timer!.isActive ? "Pause" : "Resume",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
            TextButton(
                onPressed: widget.next,
                style: TextButton.styleFrom(
                    backgroundColor: Colors.grey, fixedSize: Size(120, 45)),
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ],
        )
      ],
    );
  }
}
