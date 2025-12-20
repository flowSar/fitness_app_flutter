import 'package:flutter/material.dart';

class QuitWorkoutOverlay extends StatelessWidget {
  final VoidCallback onQuit;
  final VoidCallback onResume;
  const QuitWorkoutOverlay(
      {super.key, required this.onQuit, required this.onResume});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: onResume,
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
                  onPressed: onQuit,
                  child: Text('Quit'),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
