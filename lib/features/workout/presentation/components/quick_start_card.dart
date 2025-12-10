import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/features/explore/data/models/plan_model.dart';
import 'package:w_allfit/features/workout/presentation/provider/workout_provider.dart';

class QuickStartCard extends StatefulWidget {
  final PlanModel plan;
  const QuickStartCard({super.key, required this.plan});

  @override
  State<QuickStartCard> createState() => _QuickStartCardState();
}

class _QuickStartCardState extends State<QuickStartCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<WorkoutProvider>().updateSelectedPlan(widget.plan);

        context.push('/workoutPlanSession');
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
                widget.plan.name.length > 20
                    ? '${widget.plan.name.substring(0, 20)}...'
                    : widget.plan.name,
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
