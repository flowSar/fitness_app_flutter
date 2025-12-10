import 'package:flutter/material.dart';

class RepsCountCard extends StatelessWidget {
  final VoidCallback next;
  final VoidCallback complete;
  final VoidCallback previous;
  final String name;
  final int reps;
  const RepsCountCard({
    super.key,
    required this.next,
    required this.complete,
    required this.previous,
    required this.name,
    required this.reps,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.9,
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 22,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
                text: 'X',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: '${reps}',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 36)),
                ]),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: previous,
                  child: Icon(
                    Icons.chevron_left,
                    size: 70,
                    color: Colors.blueGrey,
                  )),
              TextButton(
                onPressed: complete,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  shape: CircleBorder(),
                ),
                child: Icon(
                  Icons.check_rounded,
                  size: 75,
                  color: Colors.blueGrey,
                ),
              ),
              TextButton(
                  onPressed: next,
                  child: Icon(
                    Icons.chevron_right,
                    size: 70,
                    color: Colors.blueGrey,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
