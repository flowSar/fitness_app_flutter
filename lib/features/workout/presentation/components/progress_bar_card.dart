import 'package:flutter/material.dart';
import 'package:w_allfit/core/utils/functions.dart';

class ProgressBarCard extends StatelessWidget {
  final double progress;
  const ProgressBarCard({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.3),
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress ${roundToHalf(progress)}%',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          LinearProgressIndicator(
            value: progress / 100,
            color: Colors.redAccent,
            minHeight: 8,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
    );
  }
}
