import 'package:flutter/material.dart';
import 'package:w_allfit/core/data/models/exercise_model.dart';

class ExerciseCard extends StatefulWidget {
  final ExerciseModel exercise;
  final Function(ExerciseModel)? onUpdate;

  const ExerciseCard({
    required this.exercise,
    this.onUpdate,
  });

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  void _showEditDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    int sets = widget.exercise.sets;
    int reps = widget.exercise.reps;
    int duration = widget.exercise.duration;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
              title: Text(
                'Edit ${widget.exercise.name}',
                style: TextStyle(
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDialogField(
                      'Sets',
                      sets,
                      (value) {
                        setDialogState(() {
                          sets = value;
                        });
                      },
                      isDark,
                      minValue: 1,
                    ),
                    const SizedBox(height: 10),
                    _buildDialogField(
                      'Reps',
                      reps,
                      (value) {
                        setDialogState(() {
                          reps = value;
                        });
                      },
                      isDark,
                      minValue: 1,
                    ),
                    const SizedBox(height: 10),
                    _buildDialogField(
                      'Duration (seconds)',
                      duration,
                      (value) {
                        setDialogState(() {
                          duration = value;
                        });
                      },
                      isDark,
                      minValue: 0,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (widget.onUpdate != null) {
                      final updatedExercise = ExerciseModel(
                        id: widget.exercise.id,
                        name: widget.exercise.name,
                        description: widget.exercise.description,
                        sets: sets,
                        reps: reps,
                        duration: duration,
                        notes: widget.exercise.notes,
                        level: widget.exercise.level,
                        image: widget.exercise.image,
                        video: widget.exercise.video,
                      );
                      widget.onUpdate!(updatedExercise);
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDialogField(
    String label,
    int value,
    Function(int) onChanged,
    bool isDark, {
    int minValue = 0,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.remove_circle,
                size: 32,
              ),
              onPressed: value > minValue ? () => onChanged(value - 1) : null,
              color: value > minValue
                  ? (isDark ? Colors.white70 : Colors.black87)
                  : Colors.grey,
            ),
            Container(
              width: 70,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                value.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.add_circle,
                size: 32,
              ),
              onPressed: () => onChanged(value + 1),
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final imageUrl = widget.exercise.image.replaceAll('mp4', 'gif');

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
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.exercise.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                        onPressed: _showEditDialog,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildInfoChip('Sets: ${widget.exercise.sets}', isDark),
                      const SizedBox(width: 8),
                      _buildInfoChip('Reps: ${widget.exercise.reps}', isDark),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                          'Duration: ${widget.exercise.duration}s', isDark),
                    ],
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String text, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.blueGrey.shade800 : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: isDark ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
