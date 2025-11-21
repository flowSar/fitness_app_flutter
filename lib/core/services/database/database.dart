import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'w_allfit.db');
    return openDatabase(path, version: 1, onConfigure: (db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('DROP TABLE IF EXISTS users');

    db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT,
      email TEXT UNIQUE,
      password_hash TEXT,
      gender TEXT,
      height REAL,
      weight REAL,
      created_at TEXT
    );

  ''');

    await db.execute('''
    CREATE TABLE plans (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      description TEXT,
      duration_days INTEGER,
      sessions INTEGER,
      created_at TEXT
    );
  ''');

    await db.execute('''
    CREATE TABLE exercises (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    description TEXT,
    category TEXT,
    image TEXT,  -- Path to the media file (image/video)
    video TEXT,  -- Path to the media file (image/video)
    created_at TEXT
  );
''');

    db.execute('''
    CREATE TABLE workout_plans (
      id INTEGER PRIMARY EY AUTOINCREMENT,
      levvel TEXT,
      plan_id INTEGER,
      exercise_id INTEGER,
      FOREIGN KEY (plan_id) REFERENCES plans(id),
      FOREIGN KEY (exercise_id) REFERENCES exercises(id)
    )
  ''');

    // user database

    await db.execute('''
    CREATE TABLE user_plans (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      progress INTEGER DEFAULT 0,
      created_at TEXT,
      plan_id INTEGER,
      user_id INTEGER,
      FOREIGN KEY (user_id) REFERENCES users(id),
      FOREIGN KEY (plan_id) REFERENCES plans(id)
    );
  ''');

    await db.execute('''
    CREATE TABLE user_workout_plan_sessions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      day INTEGER,
      progress REAL,
      duration REAL,
      complete BOOL DEFAULT false,
      created_at TEXT,
      user_plan_id INTEGER,
      FOREIGN KEY(user_plan_id) REFERENCES user_plans(id)
    );
  ''');

    db.execute('''
    CREATE TABLE user_workout_plans (
      id INTEGER PRIMARY EY AUTOINCREMENT,
      complete BOOL DEFAULT false,
      plan_id INTEGER,
      exercise_id INTEGER,
      user_workout_plan_sessions_id INTEGER,
      FOREIGN KEY (plan_id) REFERENCES plans(id),
      FOREIGN KEY (exercise_id) REFERENCES exercises(id),
      FOREIGN KEY (user_workout_plan_sessions_id) REFERENCES user_workout_plan_sessions(id)
    )
  ''');

    //   await db.execute('''
    //   CREATE TABLE session_exercise_plan (
    //     plan_id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     session_id INTEGER,
    //     exercise_id INTEGER,
    //     order_number INTEGER,
    //     sets INTEGER,
    //     reps INTEGER,
    //     duration_seconds INTEGER,
    //     rest INTEGER,
    //     created_at TEXT,
    //     FOREIGN KEY(session_id) REFERENCES sessions(session_id),
    //     FOREIGN KEY(exercise_id) REFERENCES exercises(exercise_id)
    //   );
    // ''');
  }

  // Insert a new user
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
  }

  Future<List<Map<String, String>>> getUsers() async {
    final db = await database;
    // Performing the query
    List<Map<String, Object?>> result = await db.query('users');

    // Transform the result into List<Map<String, String>> by casting values
    List<Map<String, String>> userData = result.map((e) {
      return e.map((key, value) {
        return MapEntry(key, value.toString()); // Cast each value to String
      });
    }).toList();

    return userData;
  }

  Future<void> insertFakeUser() async {
    final db = await database;

    // Insert a fake user with ID = 1
    await db.insert('users', {
      'user_id': 1, // Explicitly set ID to 1
      'username': 'john_doe',
      'email': 'john_doe@example.com',
      'password_hash': 'hashed_password',
      'first_name': 'John',
      'last_name': 'Doe',
      'age': 30,
      'gender': 'Male',
      'height': 175.0,
      'weight': 70.0,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<int> insertFakeProgram() async {
    final db = await database;

    // Insert a fake program
    int programId = await db.insert('programs', {
      'name': 'Fat Loss Program',
      'description':
          'A program designed to help you lose fat over a 30-day period.',
      'duration_days': 30,
      'created_at': DateTime.now().toIso8601String(),
    });

    return programId; // Return the inserted program ID for reference
  }

  Future<int> insertFakeSession(int programId) async {
    final db = await database;

    // Insert a fake session
    int sessionId = await db.insert('sessions', {
      'program_id': programId,
      'name': 'Session 1: Introduction to Fat Loss',
      'description': 'The first session introduces basic concepts of fat loss.',
      'day_number': 1,
      'created_at': DateTime.now().toIso8601String(),
    });

    return sessionId; // Return the inserted session ID for reference
  }

  Future<int> insertFakeExercise() async {
    final db = await database;

    // Insert a fake exercise with a media path (URL or local file path)
    int exerciseId = await db.insert('exercises', {
      'name': 'Push-up',
      'description':
          'A basic bodyweight exercise to strengthen the chest and arms.',
      'category': 'Strength',
      'image':
          'https://media-cldnry.s-nbcnews.com/image/upload/t_fit-560w,f_auto,q_auto:best/rockcms/2024-09/chest-workouts-hug-a-tree-mc-240925-e52a8d.gif', // Example URL
      'created_at': DateTime.now().toIso8601String(),
    });

    return exerciseId; // Return the inserted exercise ID for reference
  }

  Future<void> insertFakeSessionExercisePlan(
      int sessionId, int exerciseId) async {
    final db = await database;

    // Insert a fake session exercise plan
    await db.insert('session_exercise_plan', {
      'session_id': sessionId,
      'exercise_id': exerciseId,
      'order_number': 1,
      'sets': 3,
      'reps': 12,
      'duration_seconds': 30, // Example: duration for a specific exercise
      'rest': 60, // Rest time in seconds
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<void> insertFakeData() async {
    // Insert a fake user
    // await insertFakeUser();

    // Insert a fake program
    int programId = await insertFakeProgram();

    // Insert a fake session
    int sessionId = await insertFakeSession(programId);

    // Insert a fake exercise
    int exerciseId = await insertFakeExercise();

    // Insert a fake session exercise plan
    await insertFakeSessionExercisePlan(sessionId, exerciseId);

    print("Fake data inserted successfully!");
  }
}
