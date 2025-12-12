import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/core/data/models/exercise_model.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/exercises/exercises_bloc.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/exercises/exercises_event.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/exercises/exercises_state.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  @override
  void initState() {
    context.read<ExercisesBloc>().add(LoadAllExercises());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocBuilder<ExercisesBloc, ExercisesState>(
          builder: (context, state) {
            if (state is ExercisesLaoding) {
              return const Center(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (state is ExercisesLaodingFailed) {
              return Center(child: Text(state.error));
            }
            if (state is ExercisesLoaded) {
              final exercises = state.exercises;
              if (exercises.isEmpty) {
                return const Center(child: Text('No exercises available'));
              }
              return ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  return InkWell(
                      onTap: () {
                        context.pop(exercise);
                      },
                      child: _ExerciseCard(exercise: exercise));
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    ));
  }
}

class _ExerciseCard extends StatelessWidget {
  final ExerciseModel exercise;

  const _ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final imageUrl = exercise.image.replaceAll('mp4', 'gif');
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: isDark ? 0 : 2,
      color: isDark ? Colors.grey.shade900 : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 100,
                  height: 100,
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                  child: Icon(
                    Icons.image_not_supported,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    exercise.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Chip(
                        backgroundColor: isDark
                            ? Colors.blueGrey.shade800
                            : Colors.blue.shade50,
                        label: Text(
                          'Level: ${exercise.level}',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
