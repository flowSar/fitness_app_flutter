class FakeDatabase {
  static bool darkMode = false;
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
      "image": "assets/images/lose-weight.webp",
      "level": "beginner",
      "duration": "30min",
      "type": "program",
    },
    {
      "id": 2,
      "name": "Build Muscle",
      "description": "A strength-focused hypertrophy program.",
      "sessions_number": 15,
      "image": "assets/images/legs.webp",
      "level": "beginner",
      "duration": "30min",
      "type": "program",
    },
    {
      "id": 3,
      "name": "Full Body Strength",
      "description": "Functional strength and endurance training.",
      "sessions_number": 6,
      "image": "assets/images/Full Body Strength.webp",
      "level": "Advance",
      "duration": "30min",
      "type": "program",
    },
    {
      "id": 4,
      "name": "Core & Abs Shred",
      "description": "Core-focused routines to build stability and definition.",
      "sessions_number": 6,
      "image": "assets/images/abs.webp",
      "level": "Advance",
      "duration": "30min",
      "type": "program",
    },
    {
      "id": 5,
      "name": "Home Workout Challenge",
      "description": "No-equipment home training for overall fitness.",
      "sessions_number": 6,
      "image": "assets/images/lose-weight.png",
      "level": "intermediate",
      "duration": "30min",
      "type": "program",
    },
    {
      "id": 6,
      "name": "Home Workout Challenge",
      "description": "No-equipment home training for overall fitness.",
      "sessions_number": 6,
      "image": "assets/images/lose-weight.png",
      "level": "intermediate",
      "duration": "30min",
      "type": "program",
    },
    {
      "id": 7,
      "name": "abs Workout",
      "description": "No-equipment home training for overall fitness.",
      "sessions_number": 6,
      "image": "assets/images/abs-workout0.jpg",
      "level": "beginner",
      "duration": "30min",
      "type": "quick",
    },
    {
      "id": 8,
      "name": "HIIT Workout",
      "description": "No-equipment home training for overall fitness.",
      "sessions_number": 6,
      "image": "assets/images/Hiit-workout.jpg",
      "level": "beginner",
      "duration": "30min",
      "type": "quick",
    },
    {
      "id": 9,
      "name": "Cardio",
      "description": "No-equipment home training for overall fitness.",
      "sessions_number": 6,
      "image": "assets/images/cardio.jpg",
      "level": "beginner",
      "duration": "30min",
      "type": "quick",
    },
    {
      "id": 10,
      "name": "Yoga Flow",
      "description": "No-equipment home training for overall fitness.",
      "sessions_number": 6,
      "image": "assets/images/yoga.jpg",
      "level": "beginner",
      "duration": "30min",
      "type": "quick",
    }
  ];

  static final user_programs = [
    {
      "id": 1,
      "name": "Lose Fat",
      "description": "A 30-day fat-loss program with cardio-focused sessions.",
      "sessions_number": 6,
      "image": "assets/images/lose-weight.webp",
      "duration": "6",
      "level": "beginner",
      // "duration": "30min"
    },
    {
      "id": 2,
      "name": "Build Muscle",
      "description": "A strength-focused hypertrophy program.",
      "sessions_number": 7,
      "image": "assets/images/legs.webp",
      "duration": "7",
      "level": "intermediate",
      // "duration": "30min"
    },
  ];

  static final List<Map<String, Object>> quickStartWorkout = [
    {
      "id": 1,
      "plan_id": 7,
    },
    {
      "id": 2,
      "plan_id": 8,
    },
    {
      "id": 3,
      "plan_id": 9,
    },
    {
      "id": 4,
      "plan_id": 10,
    }
  ];

  static final List<Map<String, Object>> sessions = [
    {
      "id": 1,
      "name": "session 1",
      "day_number": 1,
      "complete": false,
      'plan_id': 1,
      "progress": 0,
      "duration": "6",
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
      "id": 7,
      "name": "session 1",
      "day_number": 1,
      "complete": false,
      'plan_id': 2,
      "progress": 0
    },
    {
      "id": 8,
      "name": "session 1",
      "day_number": 2,
      "complete": false,
      'plan_id': 2,
      "progress": 0
    },
    {
      "id": 9,
      "name": "session 1",
      "day_number": 3,
      "complete": false,
      'plan_id': 2,
      "progress": 0
    },
    {
      "id": 10,
      "name": "session 1",
      "day_number": 4,
      "complete": false,
      'plan_id': 2,
      "progress": 0
    },
    {
      "id": 11,
      "name": "session 1",
      "day_number": 5,
      "complete": false,
      'plan_id': 2,
      "progress": 0
    },
    {
      "id": 12,
      "name": "session 1",
      "day_number": 6,
      "complete": false,
      'plan_id': 2,
      "progress": 0
    },
    {
      "id": 13,
      "name": "session 1",
      "day_number": 7,
      "complete": false,
      'plan_id': 2,
      "progress": 0
    },
    {
      "id": 14,
      "name": "session 1",
      "day_number": 1,
      "complete": false,
      'plan_id': 3,
      "progress": 0
    },
    {
      "id": 15,
      "name": "session 1",
      "day_number": 2,
      "complete": false,
      'plan_id': 3,
      "progress": 0
    },
    {
      "id": 16,
      "name": "session 1",
      "day_number": 3,
      "complete": false,
      'plan_id': 3,
      "progress": 0
    },
    {
      "id": 17,
      "name": "session 1",
      "day_number": 4,
      "complete": false,
      'plan_id': 3,
      "progress": 0
    },
    {
      "id": 18,
      "name": "session 1",
      "day_number": 5,
      "complete": false,
      'plan_id': 3,
      "progress": 0
    },
    {
      "id": 19,
      "name": "session 1",
      "day_number": 6,
      "complete": false,
      'plan_id': 3,
      "progress": 0
    },
    {
      "id": 20,
      "name": "abs",
      "day_number": 1,
      "complete": false,
      'plan_id': 3,
      "progress": 0
    },
    {
      "id": 21,
      "name": "abs",
      "day_number": 1,
      "complete": false,
      'plan_id': 7,
      "progress": 0
    },
    {
      "id": 22,
      "name": "abs",
      "day_number": 1,
      "complete": false,
      'plan_id': 8,
      "progress": 0
    },
    {
      "id": 23,
      "name": "abs",
      "day_number": 1,
      "complete": false,
      'plan_id': 9,
      "progress": 0
    },
    {
      "id": 24,
      "name": "abs",
      "day_number": 1,
      "complete": false,
      'plan_id': 10,
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
          "duration_seconds": 10,
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

  static final Map<String, List<Map<String, Object>>> nutritionPlans = {
    "breakfasts": [
      {
        "name": "Eggs",
        "image": "assets/images/egges.jpg",
        "description": "High in protein and perfect for a quick breakfast."
      },
      {
        "name": "Carrot and sultana mini pancakes recipe",
        "image":
            "assets/images/Carrot-and-sultana-mini-pancakes_tVmBZci.width-320.jpg",
        "description": "Sweet, healthy pancakes with carrots and sultanas."
      },
      {
        "name": "Baked tomatoes on toast recipe",
        "image": "assets/images/Baked-tomatos-on-toast_14srP1t.width-320.jpg",
        "description": "A simple and tasty vegetarian breakfast."
      },
      {
        "name": "Banana and apricot bagels recipe",
        "image":
            "assets/images/Banana-and-apricot-bagels_he8yBxu.width-320.jpg",
        "description": "Delicious bagels with banana and apricot topping."
      }
    ],
    "lunches": [
      {
        "name": "Cheesy veggie wedges recipe",
        "image": "assets/images/Cheesy_veggie_wedges.width-320.png",
        "description": "Crispy wedges loaded with cheesy goodness."
      },
      {
        "name": "Cheats' pizza calzone recipe",
        "image": "assets/images/2.-Cheats-Pizza-Calzone.width-320.jpg",
        "description": "Quick and easy calzone with your favorite toppings."
      },
      {
        "name": "Chicken and tomato jacket potato recipe",
        "image": "assets/images/Chicken__tomato_jacket_potato.width-320.png",
        "description": "Hearty potato with chicken and tomato sauce."
      },
      {
        "name": "Chicken pizza naan recipe",
        "image": "assets/images/Chicken_pizza_naan_gTs3oNh.width-320.png",
        "description": "Tasty naan topped with chicken and cheese."
      },
      {
        "name": "Couscous with chicken and peas recipe",
        "image":
            "assets/images/4.-Couscous-with-chicken-and-peas.width-320.jpg",
        "description": "Light couscous salad with chicken and peas."
      }
    ]
  };
}
