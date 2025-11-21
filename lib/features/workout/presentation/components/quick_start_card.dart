import 'package:flutter/material.dart';

class QuickStartCard extends StatefulWidget {
  const QuickStartCard({super.key});

  @override
  State<QuickStartCard> createState() => _QuickStartCardState();
}

class _QuickStartCardState extends State<QuickStartCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.deepOrange],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Icon(Icons.local_fire_department_sharp),
          Text(
            'HIIT workout',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('20 min . Burn fast'),
        ],
      ),
    );
  }
}
