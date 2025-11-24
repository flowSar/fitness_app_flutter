import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/features/workout/presentation/provider/workout_provider.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_plan_session_screen.dart';

class QuickStartCard extends StatefulWidget {
  final Map<String, Object> plan;
  final int sessionId;
  const QuickStartCard(
      {super.key, required this.plan, required this.sessionId});

  @override
  State<QuickStartCard> createState() => _QuickStartCardState();
}

class _QuickStartCardState extends State<QuickStartCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<WorkoutProvider>().updatePlanId(widget.plan['id'] as int);
        context.read<WorkoutProvider>().updateSessionId(widget.sessionId);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  WorkoutPlanSessionScreen(id: widget.sessionId),
            ));
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 100,
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white12, Colors.white30],
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
                '${widget.plan['name']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('20 min . Burn fast'),
            ],
          ),
        ),
      ),
    );
  }
}
