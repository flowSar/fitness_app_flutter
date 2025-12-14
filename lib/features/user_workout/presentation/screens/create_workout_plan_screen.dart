import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:w_allfit/core/data/models/exercise_model.dart';
import 'package:w_allfit/features/user_workout/data/models/user_plan_model.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_plans/user_plan_event.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_plans/user_plan_state.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_plans/user_plans_bloc.dart';

import '../../../workout/presentation/components/exercise_card.dart';

class CreateWorkoutPlanScreen extends StatefulWidget {
  const CreateWorkoutPlanScreen({super.key});

  @override
  State<CreateWorkoutPlanScreen> createState() =>
      _CreateWorkoutPlanScreenState();
}

class _CreateWorkoutPlanScreenState extends State<CreateWorkoutPlanScreen> {
  final _workoutPlanName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPrivate = false;
  final List<ExerciseModel> _selectedExercises = [];
  late bool isProcessing = false;

  @override
  void dispose() {
    _workoutPlanName.dispose();
    super.dispose();
  }

  Future<void> _addExercise() async {
    final result = await context.push('/exercisesScreen');
    if (result != null && result is ExerciseModel) {
      setState(() {
        _selectedExercises.add(result);
      });
    }
  }

  void _removeExercise(int index) {
    if (index >= 0 && index < _selectedExercises.length) {
      setState(() {
        _selectedExercises.removeAt(index);
      });
    }
  }

  void createUserPlan() {
    print('create user plan');
    context.read<UserPlansBloc>().add(CreateUserPlan(
        planName: _workoutPlanName.text.trim(),
        visibility: false,
        exercises: _selectedExercises));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text('Create Workout Plan'),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return BlocListener<UserPlansBloc, UserPlansState>(
                  listener: (context, state) {
                    if (state is CreateUserPlanLoading) {
                      isProcessing = true;
                    }
                    if (state is CreateUserPlanSuccess) {
                      isProcessing = false;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Plan created successfully'),
                        duration: Duration(seconds: 3),
                      ));
                      context.read<UserPlansBloc>().add(LoadUserPlans());
                      context.go('/workoutScreen');
                    }
                    if (state is CreateUserPlanFailed) {
                      isProcessing = false;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Failed to create plan: ${state.error}'),
                        duration: Duration(seconds: 3),
                      ));
                    }
                  },
                  child: Column(
                    children: [
                      // Form section - scrollable when keyboard appears
                      Flexible(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Workout Plan Name',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: _workoutPlanName,
                                    decoration: const InputDecoration(
                                      hintText: 'e.g. Full Body Blast',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Please enter a plan name';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  SwitchListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: const Text(
                                      'Make plan private',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: const Text(
                                        'Private plans are only visible to you. Public plans can be shared.'),
                                    value: _isPrivate,
                                    onChanged: (value) {
                                      setState(() {
                                        _isPrivate = value;
                                      });
                                    },
                                  ),
                                  const Divider(height: 32),
                                  // Selected exercises section
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Selected Exercises (${_selectedExercises.length})',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      if (_selectedExercises.isEmpty)
                                        Flexible(
                                          child: Text(
                                            'No exercises added',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  // Exercises list with constrained height
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: constraints.maxHeight * 0.4,
                                      minHeight: 100,
                                    ),
                                    child: _selectedExercises.isEmpty
                                        ? Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.fitness_center,
                                                  size: 64,
                                                  color: Colors.grey.shade400,
                                                ),
                                                const SizedBox(height: 16),
                                                Text(
                                                  'No exercises selected',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Tap "Add Exercise" to get started',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey.shade500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            itemCount:
                                                _selectedExercises.length,
                                            itemBuilder: (context, index) {
                                              final exercise =
                                                  _selectedExercises[index];
                                              return Dismissible(
                                                key: Key(
                                                    'exercise_${exercise.id}_$index'),
                                                direction:
                                                    DismissDirection.endToStart,
                                                background: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20),
                                                  color: Colors.red,
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onDismissed: (direction) {
                                                  _removeExercise(index);
                                                },
                                                child: ExerciseCard(
                                                  exercise: exercise,
                                                  onUpdate: (updatedExercise) {
                                                    setState(() {
                                                      _selectedExercises[
                                                              index] =
                                                          updatedExercise;
                                                    });
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Buttons section - fixed at bottom
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(0, 0, 0, 1)
                                  .withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, -2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: _addExercise,
                                icon: const Icon(Icons.add),
                                label: const Text(
                                  'Add Exercise',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  side: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    if (_selectedExercises.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Please add at least one exercise'),
                                        ),
                                      );
                                      return;
                                    }
                                    // Replace with your save/submit logic
                                  }
                                  createUserPlan();
                                },
                                style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Save Plan',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      if (isProcessing) _loadingOverlay(context),
    ]);
  }
}

Widget _loadingOverlay(BuildContext context) {
  return Container(
    color: Color.fromRGBO(44, 38, 38, 0.8),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ),
          SizedBox(
            height: 10,
          ),
          Text('preparing plan',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'roboto'))
        ],
      ),
    ),
  );
}
