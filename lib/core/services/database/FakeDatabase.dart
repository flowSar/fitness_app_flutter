class FakeDatabase {
  static final Users = [
    {
      "name": "brahim",
      "email": "brahim@gmail.com",
      "password": "brahim",
    }
  ];

  static final programs = [
    {
      "id": 1,
      "name": "Lose Fat",
      "description": "A 30-day fat-loss program with cardio-focused sessions.",
      "sessions_number": 6,
      "image": "assets/images/lose-weight.png",
      "level": "beginner",
      "duration": "30min"
    },
    {
      "id": 2,
      "name": "Build Muscle",
      "description": "A strength-focused hypertrophy program.",
      "sessions_number": 15,
      "image": "assets/images/legs.png",
      "level": "beginner",
      "duration": "30min"
    },
    {
      "id": 3,
      "name": "Full Body Strength",
      "description": "Functional strength and endurance training.",
      "sessions_number": 6,
      "image": "assets/images/lose-weight.png",
      "level": "intermediate",
      "duration": "30min"
    },
    {
      "id": 4,
      "name": "Core & Abs Shred",
      "description": "Core-focused routines to build stability and definition.",
      "sessions_number": 6,
      "image": "assets/images/legs.png",
      "level": "intermediate",
      "duration": "30min"
    },
    {
      "id": 5,
      "name": "Home Workout Challenge",
      "description": "No-equipment home training for overall fitness.",
      "sessions_number": 6,
      "image": "assets/images/lose-weight.png",
      "level": "intermediate",
      "duration": "30min"
    },
  ];

  static final user_programs = [
    {
      "id": 1,
      "name": "Lose Fat",
      "description": "A 30-day fat-loss program with cardio-focused sessions.",
      "sessions_number": 6,
      "image": "assets/images/lose-weight.png",
      "level": "beginner",
      "duration": "30min"
    },
    {
      "id": 2,
      "name": "Build Muscle",
      "description": "A strength-focused hypertrophy program.",
      "sessions_number": 6,
      "image": "assets/images/legs.png",
      "level": "intermediate",
      "duration": "30min"
    },
  ];

  static final List<Map<String, Object>> sessions = [
    {
      "id": 1,
      "name": "session 1",
      "day_number": 1,
      "complete": false,
      'plan_id': 1,
      "progress": 0
    },
    {
      "id": 2,
      "name": "session 1",
      "day_number": 2,
      "complete": false,
      'plan_id': 1,
      "progress": 0
    },
    {
      "id": 3,
      "name": "session 1",
      "day_number": 3,
      "complete": false,
      'plan_id': 1,
      "progress": 0
    },
    {
      "id": 4,
      "name": "session 1",
      "day_number": 4,
      "complete": false,
      'plan_id': 1,
      "progress": 0
    },
    {
      "id": 5,
      "name": "session 1",
      "day_number": 5,
      "complete": false,
      'plan_id': 1,
      "progress": 0
    },
    {
      "id": 6,
      "name": "session 1",
      "day_number": 6,
      "complete": false,
      'plan_id': 1,
      "progress": 0
    },
    {
      "id": 1,
      "name": "session 1",
      "day_number": 1,
      "complete": false,
      'plan_id': 2,
      "progress": 0
    },
    {
      "id": 2,
      "name": "session 1",
      "day_number": 2,
      "complete": false,
      'plan_id': 2,
      "progress": 0
    },
    {
      "id": 3,
      "name": "session 1",
      "day_number": 3,
      "complete": false,
      'plan_id': 2,
      "progress": 0
    },
    {
      "id": 4,
      "name": "session 1",
      "day_number": 4,
      "complete": false,
      'plan_id': 2,
      "progress": 0
    },
    {
      "id": 5,
      "name": "session 1",
      "day_number": 5,
      "complete": false,
      'plan_id': 2,
      "progress": 0
    },
    {
      "id": 6,
      "name": "session 1",
      "day_number": 6,
      "complete": false,
      'plan_id': 2,
      "progress": 0
    },
    {
      "id": 1,
      "name": "session 1",
      "day_number": 1,
      "complete": false,
      'plan_id': 3,
      "progress": 0
    },
    {
      "id": 2,
      "name": "session 1",
      "day_number": 2,
      "complete": false,
      'plan_id': 3,
      "progress": 0
    },
    {
      "id": 3,
      "name": "session 1",
      "day_number": 3,
      "complete": false,
      'plan_id': 3,
      "progress": 0
    },
    {
      "id": 4,
      "name": "session 1",
      "day_number": 4,
      "complete": false,
      'plan_id': 3,
      "progress": 0
    },
    {
      "id": 5,
      "name": "session 1",
      "day_number": 5,
      "complete": false,
      'plan_id': 3,
      "progress": 0
    },
    {
      "id": 6,
      "name": "session 1",
      "day_number": 6,
      "complete": false,
      'plan_id': 3,
      "progress": 0
    },
    {
      "id": 6,
      "name": "abs",
      "day_number": 1,
      "complete": false,
      'plan_id': 3,
      "progress": 0
    }
  ];

  static final List<Map<String, Object>> session_workout_plan = [
    for (int j = 1; j <= sessions.length; j++)
      for (int i = 1; i <= exercises.length; i++)
        {
          "id": i,
          "session_id": j,
          "exercise_id": i,
          "complete": false,
          "sets": 3,
          "reps": 12,
          "duration_seconds": 30,
          "rest": 20,
        }
  ];

  static final exercises = [
    {
      "id": 1,
      "name": "Jumping Jacks",
      "image_url": "assets/gif/jumping-jacks.gif"
    },
    {"id": 2, "name": "High Knees", "image_url": "assets/gif/high-knees.gif"},
    {
      "id": 3,
      "name": "Reverse-Crunch",
      "image_url": "assets/gif/reverse-crunch.gif"
    },
    {
      "id": 4,
      "name": "Mountain Climbers",
      "image_url": "assets/gif/mountain-climbers.gif"
    },
    {
      "id": 5,
      "name": "Knee Push Ups",
      "image_url": "assets/gif/knee-push-ups.gif"
    },
    {"id": 6, "name": "Squats", "image_url": "assets/gif/squat.gif"},
    {"id": 7, "name": "Plank Hold", "image_url": "assets/gif/plank.gif"},
    {"id": 8, "name": "Lunges", "image_url": "assets/gif/lunges.gif"},
    {
      "id": 9,
      "name": "Russian Twists",
      "image_url": "assets/gif/russian-twist.gif"
    },
  ];

  static final List<String> tags = [
    'abs',
    'arms',
    'yoga',
    'legs',
    'lower body',
  ];
}
